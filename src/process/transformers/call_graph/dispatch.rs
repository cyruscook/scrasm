use std::collections::BTreeMap;

use anyhow::{Context, Result, anyhow};
use rand::{Rng as _, SeedableRng as _};
use wasmbin::{
    indices::{FuncId, LocalId, TableId, TypeId},
    instructions::{CallIndirect, Instruction},
    sections::{self, payload},
    types::{CompositeType, FuncType, RecursiveType, SubType, ValueType},
};

use crate::utils::mod_fn_add::add_funcs_to_mod;

use super::analyse::Analysis;

#[derive(Clone, Copy, Debug)]
pub struct DispatcherInfo {
    pub dispatcher_func_id: FuncId,
    /// Call sites store `absolute_slot ^ key`; the dispatcher XORs with the same key
    /// before issuing `call_indirect`.
    pub key: i32,
}

fn function_type_by_id(module: &wasmbin::Module, type_id: TypeId) -> Result<FuncType> {
    let types = module
        .find_std_section::<payload::Type>()
        .context("missing type section for function lookup")?
        .try_contents()
        .context("failed to decode type section")?;

    let mut next_index = 0u32;
    for recursive_type in types {
        match recursive_type {
            RecursiveType::SubType(sub_type) => {
                if next_index == type_id.index {
                    return match sub_type {
                        SubType::FinalSubType(data) | SubType::SubType(data) => {
                            match &data.composite_type {
                                CompositeType::Func(func_type) => Ok(func_type.clone()),
                                _ => Err(anyhow!(
                                    "type id {type_id:?} did not resolve to a function type"
                                )),
                            }
                        }
                        SubType::FinalEmptySubType(composite_type) => match composite_type {
                            CompositeType::Func(func_type) => Ok(func_type.clone()),
                            _ => Err(anyhow!(
                                "type id {type_id:?} did not resolve to a function type"
                            )),
                        },
                    };
                }
                next_index = next_index
                    .checked_add(1)
                    .context("type index overflow while scanning type section")?;
            }
            RecursiveType::SubTypes(sub_types) => {
                for sub_type in sub_types {
                    if next_index == type_id.index {
                        return match sub_type {
                            SubType::FinalSubType(data) | SubType::SubType(data) => {
                                match &data.composite_type {
                                    CompositeType::Func(func_type) => Ok(func_type.clone()),
                                    _ => Err(anyhow!(
                                        "type id {type_id:?} did not resolve to a function type"
                                    )),
                                }
                            }
                            SubType::FinalEmptySubType(composite_type) => match composite_type {
                                CompositeType::Func(func_type) => Ok(func_type.clone()),
                                _ => Err(anyhow!(
                                    "type id {type_id:?} did not resolve to a function type"
                                )),
                            },
                        };
                    }
                    next_index = next_index
                        .checked_add(1)
                        .context("type index overflow while scanning type section")?;
                }
            }
        }
    }

    Err(anyhow!("type id {type_id:?} was out of range"))
}

fn create_dispatcher(
    func_type: &FuncType,
    original_type_id: TypeId,
    key: i32,
) -> sections::FuncBody {
    let param_count = func_type.params.len();
    let encoded_slot_local = LocalId::from(u32::try_from(param_count).unwrap_or(u32::MAX));

    let mut expr = Vec::with_capacity(param_count + 5);
    for param_index in 0..param_count {
        if let Ok(local_index) = u32::try_from(param_index) {
            expr.push(Instruction::LocalGet(LocalId::from(local_index)));
        }
    }
    expr.push(Instruction::LocalGet(encoded_slot_local));
    expr.push(Instruction::I32Const(key));
    expr.push(Instruction::I32Xor);
    expr.push(Instruction::CallIndirect(CallIndirect {
        ty: original_type_id,
        table: TableId::from(0),
    }));

    sections::FuncBody {
        locals: Vec::new(),
        expr,
    }
}

pub fn append_dispatchers(
    module: &mut wasmbin::Module,
    analysis: &Analysis,
    seed: Option<[u8; 32]>,
) -> Result<BTreeMap<u32, DispatcherInfo>> {
    let mut dispatcher_funcs = Vec::new();
    let mut dispatcher_type_ids = BTreeMap::new();
    for eligible_func in &analysis.eligible_funcs {
        let local_index = usize::try_from(eligible_func.index)
            .context("failed to convert eligible func index to usize")?
            .checked_sub(analysis.imported_func_count)
            .context("eligible function was not locally defined")?;
        let type_id = analysis
            .original_local_type_ids
            .get(local_index)
            .copied()
            .context("missing function type for eligible callee")?;
        dispatcher_type_ids.entry(type_id.index).or_insert(type_id);
    }

    let mut rng = match seed {
        Some(seed) => rand::rngs::StdRng::from_seed(seed),
        None => rand::rngs::StdRng::try_from_os_rng()?,
    };

    let mut ordered_dispatcher_types = dispatcher_type_ids.into_iter().collect::<Vec<_>>();
    ordered_dispatcher_types.sort_by_key(|(type_index, _)| *type_index);

    let mut keys = BTreeMap::new();
    for (_, type_id) in &ordered_dispatcher_types {
        // One dispatcher per signature keeps each `call_indirect` immediate stable and lets
        // all callees of that signature share the same helper.
        let original_func_type = function_type_by_id(module, *type_id)?;
        let mut dispatcher_params = original_func_type.params.clone();
        dispatcher_params.push(ValueType::I32);
        let key = rng.random();
        dispatcher_funcs.push((
            create_dispatcher(&original_func_type, *type_id, key),
            RecursiveType::SubType(SubType::FinalEmptySubType(CompositeType::Func(FuncType {
                params: dispatcher_params,
                results: original_func_type.results.clone(),
            }))),
        ));
        keys.insert(
            type_id.index,
            DispatcherInfo {
                dispatcher_func_id: FuncId::from(0),
                key,
            },
        );
    }

    let dispatcher_ids = add_funcs_to_mod(module, dispatcher_funcs)?;
    if dispatcher_ids.len() != ordered_dispatcher_types.len() {
        return Err(anyhow!(
            "dispatcher count mismatch after appending functions"
        ));
    }

    for ((type_index, _), dispatcher_func_id) in
        ordered_dispatcher_types.into_iter().zip(dispatcher_ids)
    {
        let Some(dispatcher) = keys.get_mut(&type_index) else {
            return Err(anyhow!("missing dispatcher key for type {type_index}"));
        };
        dispatcher.dispatcher_func_id = dispatcher_func_id;
    }

    Ok(keys)
}
