use anyhow::{Context, anyhow};
use wasmbin::{
    Module,
    builtins::Blob,
    indices::{FuncId, TypeId},
    sections::{FuncBody, ImportDesc, payload},
    types::RecursiveType,
};

pub fn next_type_index(types: &[RecursiveType]) -> anyhow::Result<usize> {
    types.iter().try_fold(0usize, |acc, recursive_type| {
        let added = match recursive_type {
            RecursiveType::SubType(_) => 1usize,
            RecursiveType::SubTypes(subtypes) => subtypes.len(),
        };
        acc.checked_add(added)
            .context("failed to count flattened type indices")
    })
}

pub fn add_single_func_to_mod(
    module: &mut Module,
    func_body: FuncBody,
    func_type: RecursiveType,
) -> anyhow::Result<FuncId> {
    add_funcs_to_mod(module, vec![(func_body, func_type)]).map(|mut func_ids| {
        #[allow(clippy::expect_used)]
        func_ids
            .pop()
            .expect("func_ids should have exactly one element since we only added one function")
    })
}

pub fn add_funcs_to_mod(
    module: &mut Module,
    new_funcs: Vec<(FuncBody, RecursiveType)>,
) -> anyhow::Result<Vec<FuncId>> {
    let (func_bodies, func_types): (Vec<_>, Vec<_>) = new_funcs.into_iter().unzip();

    let num_imports = module.find_std_section::<payload::Import>().map_or_else(
        || anyhow::Ok(0usize),
        |import| {
            import
                .try_contents()
                .context("failed to decode import section")
                .map(|imports| {
                    imports
                        .iter()
                        .filter(|import| matches!(import.desc, ImportDesc::Func(_)))
                        .count()
                })
        },
    )?;

    let code = module
        .find_or_insert_std_section::<payload::Code>(payload::Code::default)
        .try_contents_mut()
        .context("failed to decode code section")?;
    let orig_code_len = code.len();
    let fn_id_base = orig_code_len
        .checked_add(num_imports)
        .context("failed to add orig code len and num imports")?;

    let func_ids = (fn_id_base
        ..(fn_id_base
            .checked_add(func_bodies.len())
            .context("failed to add fn_id_base and num decrypt functions")?))
        .map(|idx| {
            u32::try_from(idx)
                .context("failed to convert decrypt function index into u32 - too many functions")
                .map(FuncId::from)
        })
        .collect::<anyhow::Result<Vec<FuncId>>>()?;
    code.extend(func_bodies.into_iter().map(Blob::from));

    let types = module
        .find_or_insert_std_section::<payload::Type>(payload::Type::default)
        .try_contents_mut()
        .context("failed to decode type section")?;
    let next_type_index = next_type_index(types)?;
    let data_decrypt_type_ids = (next_type_index
        ..(next_type_index
            .checked_add(func_types.len())
            .context("failed to add types len and num decrypt functions")?))
        .map(|idx| {
            u32::try_from(idx)
                .context("failed to convert decrypt function index into u32 - too many functions")
                .map(TypeId::from)
        })
        .collect::<anyhow::Result<Vec<TypeId>>>()?;
    types.extend(func_types);

    let funcs = module
        .find_or_insert_std_section::<payload::Function>(payload::Function::default)
        .try_contents_mut()
        .context("failed to decode functions section")?;
    if funcs.len() != orig_code_len {
        return Err(anyhow!(
            "function section did not match number of functions in code section"
        ));
    }
    funcs.extend(data_decrypt_type_ids);

    Ok(func_ids)
}
