use anyhow::Context;
use wasmbin::{
    indices::{DataId, FuncId, GlobalId, LabelId, LocalId, TypeId},
    instructions::{Instruction, RefTypeOp},
    sections::{self, Locals},
    types::{
        BlockType, CompositeType, FuncType, HeapType, RecursiveType, RefType, SubType, ValueType,
    },
};

pub struct EncryptedStringData {
    pub global_id: GlobalId,
    pub data_id: DataId,
    pub enc_len: i32,
}

pub struct DecryptFnInput {
    pub key_data_id: DataId,
    pub key_len: usize,
    pub key_offset: usize,
    pub utf16_mut_array_type: TypeId,
    pub from_charcode_array_func_id: FuncId,
    pub old_start_fn: Option<FuncId>,
    pub encrypted: Vec<EncryptedStringData>,
}

struct LocalIds {
    key: LocalId,
    data: LocalId,
    i: LocalId,
}

impl LocalIds {
    const fn new() -> Self {
        Self {
            key: LocalId { index: 0 },
            data: LocalId { index: 1 },
            i: LocalId { index: 2 },
        }
    }
}

fn decrypt_fn_locals(utf16_mut_array_type: TypeId) -> Vec<Locals> {
    vec![
        Locals {
            ty: ValueType::Ref(RefType::NullableHeapType(HeapType::TypeIndex(
                utf16_mut_array_type,
            ))),
            repeat: 2,
        },
        Locals {
            ty: ValueType::I32,
            repeat: 1,
        },
    ]
}

fn build_key_setup(
    local_ids: &LocalIds,
    utf16_mut_array_type: TypeId,
    key_data_id: DataId,
    key_len_i32: i32,
) -> Vec<Instruction> {
    vec![
        Instruction::I32Const(0),
        Instruction::I32Const(key_len_i32),
        Instruction::RefTypeOp(RefTypeOp::ArrayNewData {
            array_type: utf16_mut_array_type,
            data_id: key_data_id,
        }),
        Instruction::LocalSet(local_ids.key),
    ]
}

fn build_string_decrypt_loop(
    local_ids: &LocalIds,
    utf16_mut_array_type: TypeId,
    key_len_i32: i32,
    key_offset_i32: i32,
    from_charcode_array_func_id: FuncId,
    encrypted: &EncryptedStringData,
) -> Vec<Instruction> {
    vec![
        Instruction::I32Const(0),
        Instruction::I32Const(encrypted.enc_len),
        Instruction::RefTypeOp(RefTypeOp::ArrayNewData {
            array_type: utf16_mut_array_type,
            data_id: encrypted.data_id,
        }),
        Instruction::LocalSet(local_ids.data),
        Instruction::I32Const(0),
        Instruction::LocalSet(local_ids.i),
        Instruction::BlockStart(BlockType::Empty),
        Instruction::LoopStart(BlockType::Empty),
        Instruction::LocalGet(local_ids.i),
        Instruction::I32Const(encrypted.enc_len),
        Instruction::I32GeU,
        Instruction::BrIf(LabelId { index: 1 }),
        Instruction::LocalGet(local_ids.data),
        Instruction::LocalGet(local_ids.i),
        Instruction::LocalGet(local_ids.data),
        Instruction::LocalGet(local_ids.i),
        Instruction::RefTypeOp(RefTypeOp::ArrayGetU(utf16_mut_array_type)),
        Instruction::LocalGet(local_ids.key),
        Instruction::LocalGet(local_ids.i),
        Instruction::I32Const(key_offset_i32),
        Instruction::I32Add,
        Instruction::I32Const(key_len_i32),
        Instruction::I32RemU,
        Instruction::RefTypeOp(RefTypeOp::ArrayGetU(utf16_mut_array_type)),
        Instruction::I32Xor,
        Instruction::RefTypeOp(RefTypeOp::ArraySet(utf16_mut_array_type)),
        Instruction::LocalGet(local_ids.i),
        Instruction::I32Const(1),
        Instruction::I32Add,
        Instruction::LocalSet(local_ids.i),
        Instruction::Br(LabelId { index: 0 }),
        Instruction::End,
        Instruction::End,
        Instruction::LocalGet(local_ids.data),
        Instruction::I32Const(0),
        Instruction::I32Const(encrypted.enc_len),
        Instruction::Call(from_charcode_array_func_id),
        Instruction::GlobalSet(encrypted.global_id),
    ]
}

pub fn create_decrypt_fn_for_strings(
    input: DecryptFnInput,
) -> anyhow::Result<(sections::FuncBody, RecursiveType)> {
    let key_len_i32 = i32::try_from(input.key_len).context("key length did not fit i32")?;
    let key_offset_i32 = i32::try_from(input.key_offset).context("key offset did not fit i32")?;
    let local_ids = LocalIds::new();

    let mut expr = build_key_setup(
        &local_ids,
        input.utf16_mut_array_type,
        input.key_data_id,
        key_len_i32,
    );
    for encrypted in input.encrypted {
        expr.extend(build_string_decrypt_loop(
            &local_ids,
            input.utf16_mut_array_type,
            key_len_i32,
            key_offset_i32,
            input.from_charcode_array_func_id,
            &encrypted,
        ));
    }
    if let Some(func_id) = input.old_start_fn {
        expr.push(Instruction::Call(func_id));
    }

    Ok((
        sections::FuncBody {
            locals: decrypt_fn_locals(input.utf16_mut_array_type),
            expr,
        },
        RecursiveType::SubType(SubType::FinalEmptySubType(CompositeType::Func(FuncType {
            params: vec![],
            results: vec![],
        }))),
    ))
}
