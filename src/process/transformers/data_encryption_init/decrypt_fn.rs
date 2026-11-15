// TODO: use f32.sqrt as proof of work

use anyhow::Context;
use wasmbin::{
    indices::{DataId, LabelId, LocalId, MemId},
    instructions::{Instruction, MemArg, Misc},
    sections::{FuncBody, Locals},
    types::{BlockType, CompositeType, FuncType, RecursiveType, SubType, ValueType},
};

use super::EncryptedData;

struct LocalIds {
    start_mem_idx: LocalId,
    i: LocalId,
    i_loaded_trap: LocalId,
    start_key_idx: LocalId,
    tmp_key: LocalId,
    segment_size: LocalId,
    key_data_i: LocalId,
    key_data_limit: LocalId,
    key_data_tmp_len: LocalId,
}

impl LocalIds {
    const fn new() -> Self {
        Self {
            start_mem_idx: LocalId { index: 0 },
            i: LocalId { index: 1 },
            i_loaded_trap: LocalId { index: 2 },
            start_key_idx: LocalId { index: 3 },
            tmp_key: LocalId { index: 4 },
            segment_size: LocalId { index: 5 },
            key_data_i: LocalId { index: 6 },
            key_data_limit: LocalId { index: 7 },
            key_data_tmp_len: LocalId { index: 8 },
        }
    }
}

struct SizedOps {
    is_64: bool,
    mem: MemId,
    add: Instruction,
    ge_u: Instruction,
    sub: Instruction,
    div_u: Instruction,
    xor: Instruction,
    zero: Instruction,
    one: Instruction,
    two: Instruction,
    load8_u: Instruction,
    store8: Instruction,
    key_offset: Instruction,
    data_len: Instruction,
}

impl SizedOps {
    fn new(enc_data: &EncryptedData, mem: MemId) -> anyhow::Result<Self> {
        Ok(if enc_data.is_64 {
            Self {
                is_64: true,
                mem,
                add: Instruction::I64Add,
                ge_u: Instruction::I64GeU,
                sub: Instruction::I64Sub,
                div_u: Instruction::I64DivU,
                xor: Instruction::I64Xor,
                zero: Instruction::I64Const(0),
                one: Instruction::I64Const(1),
                two: Instruction::I64Const(2),
                load8_u: Instruction::I64Load8U(MemArg {
                    align_log2: 0,
                    memory: mem,
                    offset: 0,
                }),
                store8: Instruction::I64Store8(MemArg {
                    align_log2: 0,
                    memory: mem,
                    offset: 0,
                }),
                key_offset: Instruction::I64Const(
                    i64::try_from(enc_data.key_offset)
                        .context("unable to convert key offset to i64")?,
                ),
                data_len: Instruction::I64Const(
                    i64::try_from(enc_data.data_len)
                        .context("unable to convert data len to i64")?,
                ),
            }
        } else {
            Self {
                is_64: false,
                mem,
                add: Instruction::I32Add,
                ge_u: Instruction::I32GeU,
                sub: Instruction::I32Sub,
                div_u: Instruction::I32DivU,
                xor: Instruction::I32Xor,
                zero: Instruction::I32Const(0),
                one: Instruction::I32Const(1),
                two: Instruction::I32Const(2),
                load8_u: Instruction::I32Load8U(MemArg {
                    align_log2: 0,
                    memory: mem,
                    offset: 0,
                }),
                store8: Instruction::I32Store8(MemArg {
                    align_log2: 0,
                    memory: mem,
                    offset: 0,
                }),
                key_offset: Instruction::I32Const(
                    i32::try_from(enc_data.key_offset)
                        .context("unable to convert key offset to i32")?,
                ),
                data_len: Instruction::I32Const(
                    i32::try_from(enc_data.data_len)
                        .context("unable to convert data len to i32")?,
                ),
            }
        })
    }

    fn locals(&self) -> Vec<Locals> {
        vec![
            Locals {
                repeat: 6,
                ty: if self.is_64 {
                    ValueType::I64
                } else {
                    ValueType::I32
                },
            },
            Locals {
                repeat: 3,
                ty: ValueType::I32,
            },
        ]
    }

    const fn wrap_to_i32(&self) -> Instruction {
        if self.is_64 {
            Instruction::I32WrapI64
        } else {
            Instruction::Nop
        }
    }

    const fn extend_i32(&self) -> Instruction {
        if self.is_64 {
            Instruction::I64ExtendI32U
        } else {
            Instruction::Nop
        }
    }
}

fn build_prologue(local_ids: &LocalIds, ops: &SizedOps) -> Vec<Instruction> {
    vec![
        Instruction::LocalSet(local_ids.start_mem_idx),
        ops.key_offset.clone(),
        Instruction::LocalSet(local_ids.start_key_idx),
        ops.zero.clone(),
        Instruction::LocalSet(local_ids.i),
    ]
}

fn build_loop_condition(local_ids: &LocalIds, ops: &SizedOps) -> Vec<Instruction> {
    vec![
        Instruction::LocalGet(local_ids.i),
        ops.data_len.clone(),
        ops.ge_u.clone(),
        Instruction::BrIf(LabelId { index: 1 }),
    ]
}

fn build_segment_size_setup(local_ids: &LocalIds, ops: &SizedOps) -> Vec<Instruction> {
    vec![
        ops.data_len.clone(),
        Instruction::LocalGet(local_ids.i),
        ops.sub.clone(),
        ops.two.clone(),
        ops.div_u.clone(),
        Instruction::LocalSet(local_ids.segment_size),
        Instruction::BlockStart(BlockType::Empty),
        Instruction::LocalGet(local_ids.segment_size),
        ops.wrap_to_i32(),
        Instruction::IfStart(BlockType::Empty),
    ]
}

fn build_key_copy_loop(
    local_ids: &LocalIds,
    ops: &SizedOps,
    key_data_id: DataId,
    key_len: i32,
) -> Vec<Instruction> {
    vec![
        Instruction::LocalGet(local_ids.i),
        Instruction::LocalGet(local_ids.segment_size),
        ops.add.clone(),
        Instruction::LocalSet(local_ids.i_loaded_trap),
        Instruction::I32Const(0),
        Instruction::LocalSet(local_ids.key_data_i),
        Instruction::LocalGet(local_ids.segment_size),
        ops.wrap_to_i32(),
        Instruction::LocalSet(local_ids.key_data_limit),
        Instruction::BlockStart(BlockType::Empty),
        Instruction::LoopStart(BlockType::Empty),
        Instruction::LocalGet(local_ids.key_data_i),
        Instruction::LocalGet(local_ids.key_data_limit),
        Instruction::I32Eq,
        Instruction::BrIf(LabelId { index: 1 }),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.key_data_i),
        ops.extend_i32(),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.start_key_idx),
        ops.wrap_to_i32(),
        Instruction::LocalGet(local_ids.i),
        ops.wrap_to_i32(),
        Instruction::I32Add,
        Instruction::LocalGet(local_ids.key_data_i),
        Instruction::I32Add,
        Instruction::I32Const(key_len),
        Instruction::I32RemU,
        Instruction::LocalTee(local_ids.key_data_tmp_len),
        Instruction::I32Const(key_len),
        Instruction::LocalGet(local_ids.key_data_tmp_len),
        Instruction::I32Sub,
        Instruction::LocalGet(local_ids.key_data_limit),
        Instruction::LocalGet(local_ids.key_data_i),
        Instruction::I32Sub,
        Instruction::I32LtU,
        Instruction::IfStart(BlockType::Value(ValueType::I32)),
        Instruction::I32Const(key_len),
        Instruction::LocalGet(local_ids.key_data_tmp_len),
        Instruction::I32Sub,
        Instruction::IfElse,
        Instruction::LocalGet(local_ids.key_data_limit),
        Instruction::LocalGet(local_ids.key_data_i),
        Instruction::I32Sub,
        Instruction::End,
        Instruction::Misc(Misc::MemoryInit {
            data: key_data_id,
            mem: ops.mem,
        }),
        Instruction::LocalGet(local_ids.key_data_i),
        Instruction::I32Const(1),
        Instruction::I32Add,
        Instruction::LocalSet(local_ids.key_data_i),
        Instruction::Br(LabelId { index: 0 }),
        Instruction::End,
        Instruction::End,
    ]
}

fn build_encrypted_copy(
    local_ids: &LocalIds,
    ops: &SizedOps,
    encrypted_data_id: DataId,
) -> Vec<Instruction> {
    vec![
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        Instruction::LocalGet(local_ids.segment_size),
        ops.add.clone(),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.i),
        ops.wrap_to_i32(),
        Instruction::LocalGet(local_ids.segment_size),
        ops.wrap_to_i32(),
        Instruction::Misc(Misc::MemoryInit {
            data: encrypted_data_id,
            mem: ops.mem,
        }),
    ]
}

fn build_xor_loop(local_ids: &LocalIds, ops: &SizedOps) -> Vec<Instruction> {
    vec![
        Instruction::BlockStart(BlockType::Empty),
        Instruction::LoopStart(BlockType::Empty),
        Instruction::LocalGet(local_ids.i),
        ops.wrap_to_i32(),
        Instruction::LocalGet(local_ids.i_loaded_trap),
        ops.wrap_to_i32(),
        Instruction::I32GeU,
        Instruction::BrIf(LabelId { index: 1 }),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        ops.load8_u.clone(),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.segment_size),
        ops.add.clone(),
        ops.load8_u.clone(),
        ops.xor.clone(),
        ops.store8.clone(),
        Instruction::LocalGet(local_ids.i),
        ops.one.clone(),
        ops.add.clone(),
        Instruction::LocalSet(local_ids.i),
        Instruction::Br(LabelId { index: 0 }),
        Instruction::End,
        Instruction::End,
    ]
}

fn build_nonzero_segment_path(
    local_ids: &LocalIds,
    ops: &SizedOps,
    key_data_id: DataId,
    key_len: i32,
    encrypted_data_id: DataId,
) -> Vec<Instruction> {
    let mut instructions = build_key_copy_loop(local_ids, ops, key_data_id, key_len);
    instructions.extend(build_encrypted_copy(local_ids, ops, encrypted_data_id));
    instructions.extend(build_xor_loop(local_ids, ops));
    instructions
}

fn build_single_byte_segment_path(
    local_ids: &LocalIds,
    ops: &SizedOps,
    key_data_id: DataId,
    key_len: i32,
    encrypted_data_id: DataId,
) -> Vec<Instruction> {
    vec![
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.start_key_idx),
        ops.wrap_to_i32(),
        Instruction::LocalGet(local_ids.i),
        ops.wrap_to_i32(),
        Instruction::I32Add,
        Instruction::I32Const(key_len),
        Instruction::I32RemU,
        Instruction::I32Const(1),
        Instruction::Misc(Misc::MemoryInit {
            data: key_data_id,
            mem: ops.mem,
        }),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        ops.load8_u.clone(),
        Instruction::LocalSet(local_ids.tmp_key),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        Instruction::LocalGet(local_ids.i),
        ops.wrap_to_i32(),
        Instruction::I32Const(1),
        Instruction::Misc(Misc::MemoryInit {
            data: encrypted_data_id,
            mem: ops.mem,
        }),
        Instruction::LocalGet(local_ids.start_mem_idx),
        Instruction::LocalGet(local_ids.i),
        ops.add.clone(),
        ops.load8_u.clone(),
        Instruction::LocalGet(local_ids.tmp_key),
        ops.xor.clone(),
        ops.store8.clone(),
        Instruction::Br(LabelId { index: 3 }),
    ]
}

fn build_decrypt_loop(
    local_ids: &LocalIds,
    ops: &SizedOps,
    key_data_id: DataId,
    key_len: i32,
    encrypted_data_id: DataId,
) -> Vec<Instruction> {
    let mut instructions = vec![
        Instruction::BlockStart(BlockType::Empty),
        Instruction::LoopStart(BlockType::Empty),
    ];
    instructions.extend(build_loop_condition(local_ids, ops));
    instructions.extend(build_segment_size_setup(local_ids, ops));
    instructions.extend(build_nonzero_segment_path(
        local_ids,
        ops,
        key_data_id,
        key_len,
        encrypted_data_id,
    ));
    instructions.push(Instruction::IfElse);
    instructions.extend(build_single_byte_segment_path(
        local_ids,
        ops,
        key_data_id,
        key_len,
        encrypted_data_id,
    ));
    instructions.extend([
        Instruction::End,
        Instruction::End,
        Instruction::Br(LabelId { index: 0 }),
        Instruction::End,
        Instruction::End,
    ]);
    instructions
}

pub fn create_decrypt_fn_for_single_data(
    key_data_id: DataId,
    key_len: i32,
    enc_data: &EncryptedData,
    target_mem: &(MemId, Vec<Instruction>),
) -> anyhow::Result<(FuncBody, RecursiveType)> {
    let local_ids = LocalIds::new();
    let ops = SizedOps::new(enc_data, target_mem.0)?;

    let mut expr = target_mem.1.clone();
    expr.extend(build_prologue(&local_ids, &ops));
    expr.extend(build_decrypt_loop(
        &local_ids,
        &ops,
        key_data_id,
        key_len,
        enc_data.data_id,
    ));

    Ok((
        FuncBody {
            locals: ops.locals(),
            expr,
        },
        RecursiveType::SubType(SubType::FinalEmptySubType(CompositeType::Func(FuncType {
            params: vec![],
            results: vec![],
        }))),
    ))
}
