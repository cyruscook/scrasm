use wasmbin::{
    indices::{DataId, FuncId},
    instructions::{Instruction, Misc},
    sections::FuncBody,
    types::{CompositeType, FuncType, RecursiveType, SubType},
};

pub fn create_init_fn(
    decrypt_data_fns: &[FuncId],
    old_start_fn: Option<FuncId>,
    should_drop_data: bool,
    key_data_id: DataId,
) -> (FuncBody, RecursiveType) {
    let expr: Vec<Instruction> = decrypt_data_fns
        .iter()
        .flat_map(|decrypt_fn| vec![Instruction::Call(*decrypt_fn)])
        .chain(if should_drop_data {
            vec![Instruction::Misc(Misc::DataDrop(key_data_id))]
        } else {
            vec![]
        })
        .chain(
            // Once we're done, call the original start function if it existed
            old_start_fn.map_or_else(Vec::new, |old_start_fn| {
                vec![Instruction::Call(old_start_fn)]
            }),
        )
        .collect();
    (
        FuncBody {
            locals: vec![],
            expr,
        },
        RecursiveType::SubType(SubType::FinalEmptySubType(CompositeType::Func(FuncType {
            params: vec![],
            results: vec![],
        }))),
    )
}
