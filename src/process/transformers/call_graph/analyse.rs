use std::collections::BTreeSet;

use anyhow::{Context, Result, bail};
use rand::{SeedableRng as _, seq::SliceRandom as _};
use wasmbin::{
    Module,
    indices::{FuncId, TypeId},
    instructions::Instruction,
    sections::{Element, ExportDesc, ImportDesc, payload},
    types::{AbstractHeapType, HeapType, RefType, TableType},
};

use super::{CallGraphDiagnostic, CallGraphReport};

#[derive(Clone, Debug)]
pub struct Analysis {
    pub imported_func_count: usize,
    pub original_defined_func_count: usize,
    /// Snapshot of the original local function section so later stages can reason
    /// about pre-dispatcher function ids even after appending helpers.
    pub original_local_type_ids: Vec<TypeId>,
    pub eligible_funcs: Vec<FuncId>,
    /// Functions in the order they are written into the private dispatch range.
    pub slot_order: Vec<FuncId>,
    pub local_table: Option<LocalTable>,
}

#[derive(Clone, Copy, Debug)]
pub struct LocalTable {
    pub min: u64,
    pub max: Option<u64>,
}

#[derive(Debug)]
pub enum AnalysisOutcome {
    Ready(Analysis),
    Skipped(CallGraphReport),
}

fn imported_func_count(module: &Module) -> Result<usize> {
    module
        .find_std_section::<payload::Import>()
        .map_or(Ok(0), |section| {
            section
                .try_contents()
                .context("failed to decode import section")
                .map(|imports| {
                    imports
                        .iter()
                        .filter(|import| matches!(import.desc, ImportDesc::Func(_)))
                        .count()
                })
        })
}

fn imported_table_count(module: &Module) -> Result<usize> {
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

fn local_function_type_ids(module: &Module) -> Result<Vec<TypeId>> {
    module
        .find_std_section::<payload::Function>()
        .map_or(Ok(Vec::new()), |section| {
            section
                .try_contents()
                .context("failed to decode function section")
                .cloned()
        })
}

fn exported_funcs(module: &Module) -> Result<BTreeSet<u32>> {
    module
        .find_std_section::<payload::Export>()
        .map_or(Ok(BTreeSet::new()), |section| {
            section
                .try_contents()
                .context("failed to decode export section")
                .map(|exports| {
                    exports
                        .iter()
                        .filter_map(|export| match export.desc {
                            ExportDesc::Func(func_id) => Some(func_id.index),
                            _ => None,
                        })
                        .collect()
                })
        })
}

fn start_func(module: &Module) -> Result<Option<FuncId>> {
    module
        .find_std_section::<payload::Start>()
        .map(|section| {
            section
                .try_contents()
                .copied()
                .context("failed to decode start section")
        })
        .transpose()
}

fn collect_ref_func(expr: &[Instruction], out: &mut BTreeSet<u32>) {
    for instruction in expr {
        if let Instruction::RefFunc(func_id) = instruction {
            out.insert(func_id.index);
        }
    }
}

fn address_taken_funcs(module: &Module) -> Result<BTreeSet<u32>> {
    let mut taken = BTreeSet::new();

    if let Some(section) = module.find_std_section::<payload::Element>() {
        for element in section
            .try_contents()
            .context("failed to decode element section")?
        {
            match element {
                Element::ActiveWithFuncs { funcs, .. }
                | Element::PassiveWithFuncs { funcs, .. }
                | Element::ActiveWithTableAndFuncs { funcs, .. }
                | Element::DeclarativeWithFuncs { funcs, .. } => {
                    for func_id in funcs {
                        taken.insert(func_id.index);
                    }
                }
                Element::ActiveWithExprs { exprs, .. }
                | Element::PassiveWithExprs { exprs, .. }
                | Element::ActiveWithTableAndExprs { exprs, .. }
                | Element::DeclarativeWithExprs { exprs, .. } => {
                    for expr in exprs {
                        collect_ref_func(expr, &mut taken);
                    }
                }
            }
        }
    }

    if let Some(section) = module.find_std_section::<payload::Code>() {
        for func in section
            .try_contents()
            .context("failed to decode code section")?
        {
            let body = func
                .try_contents()
                .context("failed to decode function body")?;
            collect_ref_func(&body.expr, &mut taken);
        }
    }

    Ok(taken)
}

fn directly_called_funcs(module: &Module) -> Result<BTreeSet<u32>> {
    let mut called = BTreeSet::new();
    if let Some(section) = module.find_std_section::<payload::Code>() {
        for func in section
            .try_contents()
            .context("failed to decode code section")?
        {
            let body = func
                .try_contents()
                .context("failed to decode function body")?;
            for instruction in &body.expr {
                match instruction {
                    Instruction::Call(func_id) | Instruction::ReturnCall(func_id) => {
                        called.insert(func_id.index);
                    }
                    _ => {}
                }
            }
        }
    }
    Ok(called)
}

fn local_table(module: &Module) -> Result<Option<LocalTable>> {
    let Some(section) = module.find_std_section::<payload::Table>() else {
        return Ok(None);
    };
    let tables = section
        .try_contents()
        .context("failed to decode table section")?;
    match tables.as_slice() {
        [] => Ok(None),
        [table] => {
            if table.expr.is_some() {
                bail!("table init expressions are not supported by call graph obfuscation v1");
            }
            if !matches!(
                table.table_type,
                TableType {
                    elem_type: RefType::AbstractHeapType(AbstractHeapType::Func)
                        | RefType::HeapType(HeapType::Abstract(AbstractHeapType::Func))
                        | RefType::NullableHeapType(HeapType::Abstract(AbstractHeapType::Func)),
                    ..
                }
            ) {
                bail!("unsupported local table element type");
            }
            Ok(Some(LocalTable {
                min: table.table_type.limits.min,
                max: table.table_type.limits.max,
            }))
        }
        _ => bail!("multiple local tables are not supported"),
    }
}

pub fn analyse(module: &Module, seed: Option<[u8; 32]>) -> Result<AnalysisOutcome> {
    if imported_table_count(module)? != 0 {
        return Ok(AnalysisOutcome::Skipped(CallGraphReport {
            diagnostics: vec![CallGraphDiagnostic::ImportedTable],
            ..Default::default()
        }));
    }

    let imported_func_count = imported_func_count(module)?;
    let local_type_ids = local_function_type_ids(module)?;
    let original_defined_func_count = local_type_ids.len();
    let local_table = match local_table(module) {
        Ok(local_table) => local_table,
        Err(error) => {
            return Ok(AnalysisOutcome::Skipped(CallGraphReport {
                diagnostics: vec![CallGraphDiagnostic::UnsupportedTableConfiguration {
                    reason: error.to_string(),
                }],
                ..Default::default()
            }));
        }
    };
    let exported_funcs = exported_funcs(module)?;
    let start_func = start_func(module)?.map(|func_id| func_id.index);
    let address_taken = address_taken_funcs(module)?;
    let directly_called = directly_called_funcs(module)?;

    let mut eligible_funcs = Vec::new();
    for (local_index, _) in local_type_ids.iter().enumerate() {
        let func_index = imported_func_count
            .checked_add(local_index)
            .context("failed to compute local function index")?;
        let func_index_u32 =
            u32::try_from(func_index).context("local function index did not fit u32")?;
        if exported_funcs.contains(&func_index_u32)
            || start_func == Some(func_index_u32)
            || address_taken.contains(&func_index_u32)
            || !directly_called.contains(&func_index_u32)
        {
            continue;
        }
        eligible_funcs.push(FuncId::from(func_index_u32));
    }

    let private_slots =
        u64::try_from(eligible_funcs.len()).context("eligible function count did not fit u64")?;
    if let Some(table) = local_table {
        let required_min = table
            .min
            .checked_add(private_slots)
            .context("table minimum overflowed when adding private slots")?;
        if let Some(max) = table.max
            && required_min > max
        {
            return Ok(AnalysisOutcome::Skipped(CallGraphReport {
                diagnostics: vec![CallGraphDiagnostic::InsufficientTableCapacity {
                    maximum: max,
                    additional_private_slots: eligible_funcs.len(),
                }],
                ..Default::default()
            }));
        }
    }

    if eligible_funcs.is_empty() {
        return Ok(AnalysisOutcome::Skipped(CallGraphReport {
            diagnostics: vec![CallGraphDiagnostic::NoEligibleDirectCalls],
            ..Default::default()
        }));
    }

    let mut slot_order = eligible_funcs.clone();
    if let Some(seed) = seed {
        let mut rng = rand::rngs::StdRng::from_seed(seed);
        slot_order.shuffle(&mut rng);
    } else {
        let mut rng = rand::rngs::StdRng::try_from_os_rng()?;
        slot_order.shuffle(&mut rng);
    }

    Ok(AnalysisOutcome::Ready(Analysis {
        imported_func_count,
        original_defined_func_count,
        original_local_type_ids: local_type_ids,
        eligible_funcs,
        slot_order,
        local_table,
    }))
}
