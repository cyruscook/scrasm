use std::{collections::BTreeMap, io::Cursor};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{FunctionIndexRemapDiagnostic, ScrasmConfig, TransformerReport, TransformersConfig};
use wasmbin::{
    Module,
    instructions::Instruction,
    sections::{Element, ExportDesc, payload},
};

const FUNCTION_INDEX_REMAP_SEED: [u8; 32] = [
    0x41, 0x9c, 0x12, 0xe7, 0x55, 0x08, 0xaa, 0x31, 0x74, 0x6d, 0x90, 0x2b, 0xcf, 0x18, 0x63, 0xfe,
    0x21, 0xb4, 0x5a, 0x0d, 0x99, 0xc2, 0x37, 0x68, 0xde, 0x44, 0x7b, 0x15, 0xa8, 0xf1, 0x2e, 0x53,
];

const MODULE_SRC: &str = r#"
(module
  (type $ret-i32 (func (result i32)))
  (type $void (func))

  (global $started (mut i32) (i32.const 0))

  (func $zero (type $ret-i32) (result i32)
    (i32.const 11)
  )
  (func $one (type $ret-i32) (result i32)
    (call $zero)
  )
  (func $two (type $ret-i32) (result i32)
    (drop (ref.func $zero))
    (call $one)
  )
  (func $three (type $ret-i32) (result i32)
    (call $two)
  )
  (func $start-fn (type $void)
    (global.set $started (call $three))
  )

  (start $start-fn)

  (table 4 funcref)
  (elem (i32.const 0) func $zero $one)
  (elem declare funcref (ref.func $two) (ref.func $start-fn))

  (export "zero" (func $zero))
  (export "one" (func $one))
  (export "two" (func $two))
  (export "three" (func $three))
  (export "start_fn" (func $start-fn))
  (func (export "started") (result i32)
    (global.get $started)
  )
)
"#;

fn transform_module(src: &str) -> Result<Vec<u8>> {
    let mut input = super::wat_to_module(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = false;
    transformers.call_graph.enabled = false;
    transformers.function_index_remap.enabled = true;
    transformers.function_index_remap.seed = Some(FUNCTION_INDEX_REMAP_SEED);

    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(output)
}

fn transform_reports(src: &str) -> Result<Vec<TransformerReport>> {
    let mut input = super::wat_to_module(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = false;
    transformers.call_graph.enabled = false;
    transformers.function_index_remap.enabled = true;
    transformers.function_index_remap.seed = Some(FUNCTION_INDEX_REMAP_SEED);

    let reports = scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm_with_reports(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(reports
        .get("function_index_remap")
        .cloned()
        .unwrap_or_default())
}

fn decode_module(bytes: &[u8]) -> Result<Module> {
    Module::decode_from(Cursor::new(bytes)).map_err(Into::into)
}

fn exported_funcs(module: &Module) -> Result<BTreeMap<String, u32>> {
    module
        .find_std_section::<payload::Export>()
        .map_or(Ok(BTreeMap::new()), |section| {
            section
                .try_contents()
                .context("failed to decode export section")
                .map(|exports| {
                    exports
                        .iter()
                        .filter_map(|export| match export.desc {
                            ExportDesc::Func(func_id) => Some((export.name.clone(), func_id.index)),
                            _ => None,
                        })
                        .collect()
                })
        })
}

fn start_index(module: &Module) -> Result<Option<u32>> {
    module
        .find_std_section::<payload::Start>()
        .map(|section| {
            section
                .try_contents()
                .copied()
                .map(|func_id| func_id.index)
                .context("failed to decode start section")
        })
        .transpose()
}

fn function_expr(module: &Module, func_index: u32) -> Result<Vec<Instruction>> {
    let code = module
        .find_std_section::<payload::Code>()
        .context("missing code section")?
        .try_contents()
        .context("failed to decode code section")?;
    let body_index = usize::try_from(func_index).context("function index did not fit usize")?;
    let body = code
        .get(body_index)
        .context("function index did not resolve to code body")?
        .try_contents()
        .context("failed to decode function body")?;
    Ok(body.expr.clone())
}

fn active_element_funcs(module: &Module) -> Result<Vec<u32>> {
    let mut out = Vec::new();
    if let Some(section) = module.find_std_section::<payload::Element>() {
        for element in section
            .try_contents()
            .context("failed to decode element section")?
        {
            if let Element::ActiveWithFuncs { funcs, .. } = element {
                out.extend(funcs.iter().map(|func_id| func_id.index));
            }
        }
    }
    Ok(out)
}

fn declarative_ref_funcs(module: &Module) -> Result<Vec<u32>> {
    let mut out = Vec::new();
    if let Some(section) = module.find_std_section::<payload::Element>() {
        for element in section
            .try_contents()
            .context("failed to decode element section")?
        {
            if let Element::DeclarativeWithExprs { exprs, .. } = element {
                for expr in exprs {
                    for instruction in expr {
                        if let Instruction::RefFunc(func_id) = instruction {
                            out.push(func_id.index);
                        }
                    }
                }
            }
        }
    }
    Ok(out)
}

fn run_started(module: &[u8]) -> Result<i32> {
    let engine = wasmi::Engine::default();
    let wasm_module = wasmi::Module::new(&engine, module)?;
    let mut store = wasmi::Store::new(&engine, ());
    let instance =
        wasmi::Linker::<()>::new(&engine).instantiate_and_start(&mut store, &wasm_module)?;
    let started = instance.get_typed_func::<(), i32>(&store, "started")?;
    Ok(started.call(&mut store, ())?)
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(vec![
        Trial::test(
            "function_index_remap_rewrites_all_function_references",
            || {
                (|| -> Result<()> {
                    let original = super::wat_to_module(MODULE_SRC)?;
                    let transformed = transform_module(MODULE_SRC)
                        .context("failed to transform function-index-remap fixture")?;

                    wasmparser::Validator::new()
                        .validate_all(&transformed)
                        .context("wasmparser rejected the transformed module")?;

                    let original_module = decode_module(&original)?;
                    let transformed_module = decode_module(&transformed)?;

                    let original_exports = exported_funcs(&original_module)?;
                    let transformed_exports = exported_funcs(&transformed_module)?;

                    ensure!(
                        original_exports != transformed_exports,
                        "expected remapped function exports to change indices"
                    );

                    ensure!(
                        start_index(&transformed_module)?
                            == transformed_exports.get("start_fn").copied(),
                        "start section did not follow the remapped start function"
                    );

                    let zero = *transformed_exports
                        .get("zero")
                        .context("missing zero export")?;
                    let one = *transformed_exports
                        .get("one")
                        .context("missing one export")?;
                    let two = *transformed_exports
                        .get("two")
                        .context("missing two export")?;
                    let three = *transformed_exports
                        .get("three")
                        .context("missing three export")?;
                    let start_fn = *transformed_exports
                        .get("start_fn")
                        .context("missing start_fn export")?;

                    ensure!(
                        function_expr(&transformed_module, one)?
                            .contains(&Instruction::Call(wasmbin::indices::FuncId::from(zero))),
                        "remapped one function no longer calls zero"
                    );
                    let two_expr = function_expr(&transformed_module, two)?;
                    ensure!(
                        two_expr.contains(&Instruction::Call(wasmbin::indices::FuncId::from(one))),
                        "remapped two function no longer calls one"
                    );
                    ensure!(
                        two_expr
                            .contains(&Instruction::RefFunc(wasmbin::indices::FuncId::from(zero))),
                        "remapped two function no longer references zero via ref.func"
                    );
                    ensure!(
                        function_expr(&transformed_module, three)?
                            .contains(&Instruction::Call(wasmbin::indices::FuncId::from(two))),
                        "remapped three function no longer calls two"
                    );
                    ensure!(
                        function_expr(&transformed_module, start_fn)?
                            .contains(&Instruction::Call(wasmbin::indices::FuncId::from(three))),
                        "remapped start function no longer calls three"
                    );

                    ensure!(
                        active_element_funcs(&transformed_module)? == vec![zero, one],
                        "active element segment did not follow remapped function indices"
                    );
                    ensure!(
                        declarative_ref_funcs(&transformed_module)? == vec![two, start_fn],
                        "declarative ref.func segment did not follow remapped function indices"
                    );

                    ensure!(
                        run_started(&transformed)? == 11,
                        "runtime check observed incorrect start-side effect"
                    );

                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
        Trial::test(
            "function_index_remap_reports_when_no_shuffle_is_possible",
            || {
                (|| -> Result<()> {
                    let reports = transform_reports("(module (func))")?;
                    ensure!(
                        reports.len() == 1,
                        "expected one function_index_remap report"
                    );
                    let Some(TransformerReport::FunctionIndexRemap(report)) = reports.first()
                    else {
                        return Err(anyhow::anyhow!("missing function_index_remap report"));
                    };
                    ensure!(
                        report.diagnostics
                            == [FunctionIndexRemapDiagnostic::TooFewLocalFunctions { count: 1 }],
                        "expected too-few-local-functions diagnostic, got {:?}",
                        report.diagnostics
                    );
                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
    ])
}
