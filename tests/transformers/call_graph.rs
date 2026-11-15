use std::io::Cursor;

use anyhow::{Context, Result, anyhow, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{
    CallGraphDiagnostic, MinimumRequiredSupport, ScrasmConfig, TransformerReport,
    TransformersConfig,
};
use wasmbin::{
    Module,
    indices::{FuncId, TableId},
    instructions::{CallIndirect, Instruction},
    sections::{Element, ImportDesc, payload},
};

const CALL_GRAPH_SEED: [u8; 32] = [
    0x91, 0x34, 0x52, 0x70, 0x8e, 0xac, 0xca, 0xe8, 0x10, 0x32, 0x54, 0x76, 0x98, 0xba, 0xdc, 0xfe,
    0x13, 0x57, 0x9b, 0xdf, 0x24, 0x68, 0xac, 0xf0, 0x55, 0xaa, 0x33, 0xcc, 0x77, 0x11, 0x22, 0x44,
];

fn encode_wat(src: &str) -> Result<Vec<u8>> {
    let enhance_error = |mut err: wast::Error| {
        err.set_text(src);
        err
    };

    let mut lexer = wast::lexer::Lexer::new(src);
    lexer.allow_confusing_unicode(true);
    let buffer = wast::parser::ParseBuffer::new_with_lexer(lexer).map_err(enhance_error)?;
    let mut wat = wast::parser::parse::<wast::Wat<'_>>(&buffer).map_err(enhance_error)?;
    wat.encode().map_err(Into::into)
}

fn transform_module(src: &str) -> Result<Vec<u8>> {
    let mut input = encode_wat(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = false;
    transformers.function_index_remap.enabled = false;
    transformers.call_graph.enabled = true;
    transformers.call_graph.seed = Some(CALL_GRAPH_SEED);

    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(output)
}

fn transform_reports_with_support(
    src: &str,
    minimum_required_support: MinimumRequiredSupport,
) -> Result<Vec<TransformerReport>> {
    let mut input = encode_wat(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = false;
    transformers.function_index_remap.enabled = false;
    transformers.call_graph.enabled = true;
    transformers.call_graph.seed = Some(CALL_GRAPH_SEED);

    let reports = scrasm::with_config(ScrasmConfig {
        capabilities: scrasm::CapabilitiesConfig {
            minimum_required_support,
        },
        transformers,
        ..Default::default()
    })
    .scrasm_with_reports(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(reports.get("call_graph").cloned().unwrap_or_default())
}

fn decode_module(bytes: &[u8]) -> Result<Module> {
    Module::decode_from(Cursor::new(bytes)).map_err(Into::into)
}

fn validate_module(bytes: &[u8]) -> Result<()> {
    wasmparser::Validator::new().validate_all(bytes)?;
    Ok(())
}

fn run_exported_i32_func(module: &[u8], export: &str, args: &[i32]) -> Result<i32> {
    ensure!(
        args.len() == 1,
        "test helper currently expects exactly one i32 argument"
    );
    let engine = wasmi::Engine::default();
    let mut store = wasmi::Store::new(&engine, ());
    let module = wasmi::Module::new(&engine, module)?;
    let instance = wasmi::Linker::<()>::new(&engine).instantiate_and_start(&mut store, &module)?;
    let func = instance
        .get_typed_func::<i32, i32>(&store, export)
        .map_err(|err| anyhow!("failed to resolve export {export}: {err}"))?;
    func.call(&mut store, args[0]).map_err(Into::into)
}

fn count_defined_functions(module: &Module) -> Result<usize> {
    module
        .find_std_section::<payload::Code>()
        .map_or(Ok(0), |section| {
            section
                .try_contents()
                .context("failed to decode code section")
                .map(std::vec::Vec::len)
        })
}

fn defined_function_exprs(module: &Module) -> Result<Vec<Vec<Instruction>>> {
    module
        .find_std_section::<payload::Code>()
        .map_or(Ok(Vec::new()), |section| {
            section
                .try_contents()
                .context("failed to decode code section")?
                .iter()
                .map(|func| {
                    func.try_contents()
                        .context("failed to decode function body")
                        .map(|body| body.expr.clone())
                })
                .collect()
        })
}

fn table_section(module: &Module) -> Result<Option<Vec<wasmbin::sections::Table>>> {
    module
        .find_std_section::<payload::Table>()
        .map_or(Ok(None), |section| {
            section
                .try_contents()
                .context("failed to decode table section")
                .map(|tables| Some(tables.clone()))
        })
}

fn element_section(module: &Module) -> Result<Vec<Element>> {
    module
        .find_std_section::<payload::Element>()
        .map_or(Ok(Vec::new()), |section| {
            section
                .try_contents()
                .context("failed to decode element section")
                .cloned()
        })
}

fn import_table_count(module: &Module) -> Result<usize> {
    module
        .find_std_section::<payload::Import>()
        .map_or(Ok(0), |section| {
            section
                .try_contents()
                .context("failed to decode import section")
                .map(|imports| {
                    imports
                        .iter()
                        .filter(|import| matches!(import.desc, ImportDesc::Table(_)))
                        .count()
                })
        })
}

fn has_direct_call(expr: &[Instruction], func_id: FuncId) -> bool {
    expr.iter()
        .any(|instr| matches!(instr, Instruction::Call(id) if *id == func_id))
}

fn has_return_call(expr: &[Instruction], func_id: FuncId) -> bool {
    expr.iter()
        .any(|instr| matches!(instr, Instruction::ReturnCall(id) if *id == func_id))
}

fn find_dispatchers(exprs: &[Vec<Instruction>]) -> Vec<&[Instruction]> {
    exprs
        .iter()
        .map(Vec::as_slice)
        .filter(|expr| {
            expr.iter()
                .any(|instr| matches!(instr, Instruction::I32Xor))
                && expr.iter().any(|instr| {
                    matches!(
                        instr,
                        Instruction::CallIndirect(CallIndirect {
                            table,
                            ..
                        }) if *table == TableId::from(0)
                    )
                })
        })
        .collect()
}

fn rewrite_trials() -> Vec<Trial> {
    vec![
        Trial::test(
            "call_graph_skips_when_reference_types_capability_is_missing",
            || {
                (|| -> Result<()> {
                    let reports = transform_reports_with_support(
                        r#"
(module
  (func $helper (param i32) (result i32)
    local.get 0
  )
  (func (export "entry") (param i32) (result i32)
    local.get 0
    call $helper
  )
)
"#,
                        MinimumRequiredSupport::Legacy,
                    )?;

                    ensure!(reports.len() == 1, "expected one call_graph report");
                    let Some(TransformerReport::CallGraph(report)) = reports.first() else {
                        return Err(anyhow!("missing call_graph report"));
                    };
                    ensure!(
                        report.diagnostics
                            == [CallGraphDiagnostic::UnsupportedCapabilities {
                                capabilities: vec!["reference_types".to_owned()],
                            }],
                        "expected unsupported-capabilities diagnostic, got {:?}",
                        report.diagnostics
                    );

                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
        Trial::test("call_graph_rewrites_internal_calls_without_table", || {
            (|| -> Result<()> {
                let src = r#"
(module
  (func $helper (param i32) (result i32)
    local.get 0
    i32.const 11
    i32.add
  )
  (func (export "entry") (param i32) (result i32)
    local.get 0
    call $helper
  )
)
"#;

                let transformed =
                    transform_module(src).context("failed to transform no-table fixture")?;
                validate_module(&transformed)
                    .context("validator rejected transformed no-table fixture")?;
                ensure!(
                    run_exported_i32_func(&transformed, "entry", &[31])? == 42,
                    "runtime result changed after rewriting"
                );

                let module = decode_module(&transformed)?;
                let tables = table_section(&module)?.context("expected a synthetic table")?;
                ensure!(tables.len() == 1, "expected exactly one local table");
                ensure!(
                    tables[0].table_type.limits.min == 1,
                    "expected synthetic table minimum 1, got {}",
                    tables[0].table_type.limits.min
                );
                ensure!(
                    tables[0].table_type.limits.max.is_none(),
                    "expected synthetic table max to remain unset"
                );

                let elements = element_section(&module)?;
                ensure!(elements.len() == 1, "expected one active element segment");
                match &elements[0] {
                    Element::ActiveWithFuncs { funcs, .. } => {
                        ensure!(
                            funcs.as_slice() == [FuncId::from(0)],
                            "expected helper function in synthetic dispatch table"
                        );
                    }
                    other => return Err(anyhow!("unexpected element kind: {other:?}")),
                }

                let exprs = defined_function_exprs(&module)?;
                ensure!(
                    exprs.len() == 3,
                    "expected helper, entry, and one dispatcher"
                );
                ensure!(
                    !has_direct_call(&exprs[1], FuncId::from(0)),
                    "entry should no longer call helper directly"
                );
                ensure!(
                    exprs[1].windows(2).any(|window| matches!(
                        window,
                        [
                            Instruction::I32Const(_),
                            Instruction::Call(FuncId { index: 2 })
                        ]
                    )),
                    "entry should push an encoded slot then call the dispatcher"
                );
                ensure!(
                    find_dispatchers(&exprs).len() == 1,
                    "expected exactly one dispatcher body"
                );

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        }),
        Trial::test(
            "call_graph_appends_private_slots_to_existing_local_table",
            || {
                (|| -> Result<()> {
                let src = r#"
(module
  (type $unary (func (param i32) (result i32)))
  (func $existing (type $unary) (param i32) (result i32)
    local.get 0
  )
  (func $helper (type $unary) (param i32) (result i32)
    local.get 0
    i32.const 5
    i32.mul
  )
  (func (export "entry") (type $unary) (param i32) (result i32)
    local.get 0
    call $helper
  )
  (table 1 3 funcref)
  (elem (i32.const 0) func $existing)
)
"#;

                let transformed = transform_module(src)
                    .context("failed to transform existing-table fixture")?;
                validate_module(&transformed)
                    .context("validator rejected transformed existing-table fixture")?;
                ensure!(
                    run_exported_i32_func(&transformed, "entry", &[9])? == 45,
                    "runtime result changed after appending dispatch slots"
                );

                let module = decode_module(&transformed)?;
                let tables = table_section(&module)?.context("expected original table to remain")?;
                ensure!(tables.len() == 1, "expected one table");
                ensure!(
                    tables[0].table_type.limits.min == 2,
                    "expected table min to grow from 1 to 2"
                );
                ensure!(
                    tables[0].table_type.limits.max == Some(3),
                    "expected table max to remain unchanged"
                );

                let elements = element_section(&module)?;
                ensure!(elements.len() == 2, "expected original and private element segments");
                ensure!(
                    matches!(
                        &elements[1],
                        Element::ActiveWithFuncs { funcs, .. } if funcs.as_slice() == [FuncId::from(1)]
                    ),
                    "expected appended private segment to target helper at the new slot"
                );

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
    ]
}

fn skip_trials() -> Vec<Trial> {
    vec![
        Trial::test(
            "call_graph_skips_exported_and_address_taken_callees",
            || {
                (|| -> Result<()> {
                    let src = r#"
(module
  (type $unary (func (param i32) (result i32)))
  (func $exported (export "helper") (type $unary) (param i32) (result i32)
    local.get 0
    i32.const 3
    i32.add
  )
  (func $address_taken (type $unary) (param i32) (result i32)
    local.get 0
    i32.const 9
    i32.add
  )
  (func (export "entry") (type $unary) (param i32) (result i32)
    local.get 0
    call $exported
    call $address_taken
  )
  (table 1 funcref)
  (elem (i32.const 0) func $address_taken)
)
"#;

                    let transformed = transform_module(src)
                        .context("failed to transform exported/address-taken fixture")?;
                    validate_module(&transformed).context("validator rejected skipped fixture")?;
                    ensure!(
                        run_exported_i32_func(&transformed, "entry", &[5])? == 17,
                        "runtime result changed in skipped fixture"
                    );

                    let module = decode_module(&transformed)?;
                    ensure!(
                        count_defined_functions(&module)? == 3,
                        "expected no dispatcher helpers when every callee is ineligible"
                    );
                    let exprs = defined_function_exprs(&module)?;
                    ensure!(
                        has_direct_call(&exprs[2], FuncId::from(0)),
                        "call to exported callee should remain direct"
                    );
                    ensure!(
                        has_direct_call(&exprs[2], FuncId::from(1)),
                        "call to address-taken callee should remain direct"
                    );
                    ensure!(
                        find_dispatchers(&exprs).is_empty(),
                        "did not expect any dispatcher in skipped fixture"
                    );

                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
        Trial::test("call_graph_skips_imported_tables", || {
            (|| -> Result<()> {
                let src = r#"
(module
  (type $unary (func (param i32) (result i32)))
  (import "env" "table" (table 1 funcref))
  (func $helper (type $unary) (param i32) (result i32)
    local.get 0
    i32.const 2
    i32.mul
  )
  (func (export "entry") (type $unary) (param i32) (result i32)
    local.get 0
    call $helper
  )
)
"#;

                let transformed =
                    transform_module(src).context("failed to transform imported-table fixture")?;
                validate_module(&transformed)
                    .context("validator rejected imported-table fixture")?;

                let module = decode_module(&transformed)?;
                ensure!(
                    import_table_count(&module)? == 1,
                    "expected imported table to remain untouched"
                );
                ensure!(
                    count_defined_functions(&module)? == 2,
                    "expected no dispatcher helpers when imported tables force a skip"
                );
                ensure!(
                    table_section(&module)?.is_none(),
                    "expected no local table section to be added"
                );

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        }),
        Trial::test("call_graph_rewrites_return_call_to_dispatcher", || {
            (|| -> Result<()> {
                let src = r#"
(module
  (func $helper (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.add
  )
  (func (export "entry") (param i32) (result i32)
    local.get 0
    return_call $helper
  )
)
"#;

                let transformed =
                    transform_module(src).context("failed to transform return_call fixture")?;
                validate_module(&transformed)
                    .context("validator rejected transformed return_call fixture")?;

                let module = decode_module(&transformed)?;
                let exprs = defined_function_exprs(&module)?;
                ensure!(
                    !has_return_call(&exprs[1], FuncId::from(0)),
                    "entry should no longer tail-call helper directly"
                );
                ensure!(
                    exprs[1].windows(2).any(|window| matches!(
                        window,
                        [
                            Instruction::I32Const(_),
                            Instruction::ReturnCall(FuncId { index: 2 })
                        ]
                    )),
                    "entry should tail-call the dispatcher after pushing the encoded slot"
                );

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        }),
    ]
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(rewrite_trials().into_iter().chain(skip_trials()).collect())
}
