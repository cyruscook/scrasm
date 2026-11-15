use std::collections::BTreeMap;

use anyhow::{Context, Result, anyhow};
use wasmbin::{
    indices::FuncId,
    instructions::Instruction,
    sections::{Element, Table, payload},
    types::{AbstractHeapType, Limits, RefType, TableType},
};

use super::{analyse::Analysis, dispatch::DispatcherInfo};

fn eligible_type_by_func(analysis: &Analysis, func_id: FuncId) -> Result<u32> {
    let local_index = usize::try_from(func_id.index)
        .context("failed to convert function index to usize")?
        .checked_sub(analysis.imported_func_count)
        .context("eligible callee was not locally defined")?;
    analysis
        .original_local_type_ids
        .get(local_index)
        .map(|type_id| type_id.index)
        .context("missing original function type for eligible callee")
}

pub fn install_dispatch_table(module: &mut wasmbin::Module, analysis: &Analysis) -> Result<()> {
    let private_slots =
        u64::try_from(analysis.slot_order.len()).context("private slot count did not fit u64")?;
    let (offset, needs_table) = analysis
        .local_table
        .map_or((0, true), |local_table| (local_table.min, false));

    if needs_table {
        let tables = module
            .find_or_insert_std_section::<payload::Table>(payload::Table::default)
            .try_contents_mut()
            .context("failed to decode table section")?;
        tables.push(Table {
            table_type: TableType {
                elem_type: RefType::AbstractHeapType(AbstractHeapType::Func),
                limits: Limits {
                    min: private_slots,
                    max: None,
                    is_64: false,
                    is_shared: false,
                },
            },
            expr: None,
        });
    } else if let Some(section) = module.find_std_section_mut::<payload::Table>() {
        let tables = section
            .try_contents_mut()
            .context("failed to decode table section")?;
        let table = tables
            .first_mut()
            .ok_or_else(|| anyhow!("missing local table after successful analysis"))?;
        table.table_type.limits.min = table
            .table_type
            .limits
            .min
            .checked_add(private_slots)
            .context("table minimum overflowed while appending private slots")?;
    }

    let elements = module
        .find_or_insert_std_section::<payload::Element>(payload::Element::default)
        .try_contents_mut()
        .context("failed to decode element section")?;
    elements.push(Element::ActiveWithFuncs {
        offset: vec![Instruction::I32Const(
            i32::try_from(offset).context("dispatch table offset did not fit i32")?,
        )],
        funcs: analysis.slot_order.clone(),
    });

    Ok(())
}

pub fn rewrite_calls(
    module: &mut wasmbin::Module,
    analysis: &Analysis,
    dispatchers: &BTreeMap<u32, DispatcherInfo>,
) -> Result<()> {
    // When a module already owns a local table, rewritten calls target the appended private
    // range above the existing public slots rather than a zero-based private table.
    let slot_base = analysis.local_table.map_or(0, |table| table.min);
    let slot_indices = analysis
        .slot_order
        .iter()
        .enumerate()
        .map(|(slot, func_id)| {
            let absolute_slot = slot_base
                .checked_add(u64::try_from(slot).context("slot index did not fit u64")?)
                .context("dispatch slot overflowed while rewriting calls")?;
            Ok((
                func_id.index,
                i32::try_from(absolute_slot).context("slot index did not fit i32")?,
            ))
        })
        .collect::<Result<BTreeMap<_, _>>>()?;

    let eligible = analysis
        .eligible_funcs
        .iter()
        .map(|func_id| Ok((func_id.index, eligible_type_by_func(analysis, *func_id)?)))
        .collect::<Result<BTreeMap<_, _>>>()?;

    let code = module
        .find_std_section_mut::<payload::Code>()
        .context("missing code section while rewriting calls")?
        .try_contents_mut()
        .context("failed to decode code section")?;

    for func in code.iter_mut().take(analysis.original_defined_func_count) {
        let body = func
            .try_contents_mut()
            .context("failed to decode function body")?;
        let old_expr = std::mem::take(&mut body.expr);
        let mut new_expr = Vec::with_capacity(old_expr.len());
        for instruction in old_expr {
            match instruction {
                Instruction::Call(func_id) if eligible.contains_key(&func_id.index) => {
                    let type_index = eligible
                        .get(&func_id.index)
                        .copied()
                        .context("missing dispatcher type for eligible call")?;
                    let dispatcher = dispatchers
                        .get(&type_index)
                        .copied()
                        .context("missing dispatcher for eligible call")?;
                    let slot = slot_indices
                        .get(&func_id.index)
                        .copied()
                        .context("missing slot for eligible call")?;
                    new_expr.push(Instruction::I32Const(slot ^ dispatcher.key));
                    new_expr.push(Instruction::Call(dispatcher.dispatcher_func_id));
                }
                Instruction::ReturnCall(func_id) if eligible.contains_key(&func_id.index) => {
                    let type_index = eligible
                        .get(&func_id.index)
                        .copied()
                        .context("missing dispatcher type for eligible tail call")?;
                    let dispatcher = dispatchers
                        .get(&type_index)
                        .copied()
                        .context("missing dispatcher for eligible tail call")?;
                    let slot = slot_indices
                        .get(&func_id.index)
                        .copied()
                        .context("missing slot for eligible tail call")?;
                    new_expr.push(Instruction::I32Const(slot ^ dispatcher.key));
                    new_expr.push(Instruction::ReturnCall(dispatcher.dispatcher_func_id));
                }
                other => new_expr.push(other),
            }
        }
        body.expr = new_expr;
    }

    Ok(())
}
