mod decrypt_fn;
mod encr_data;
mod init_fn;

use std::ops::Rem;

use anyhow::{Context, anyhow};
use decrypt_fn::create_decrypt_fn_for_single_data;
use encr_data::EncryptedData;
use init_fn::create_init_fn;
use rand::{Rng, SeedableRng};
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;
use wasmbin::{
    indices::{DataId, FuncId, MemId},
    instructions::Expression,
    sections::{
        Data, DataInit, FuncBody,
        payload::{self},
    },
    types::RecursiveType,
};

use crate::utils::{
    mod_fn_add::{add_funcs_to_mod, add_single_func_to_mod},
    rng::{read_num, read_nums},
};

use super::transformer::{Transformer, TransformerOutput, TransformerReport};

type ByteRng = rand::distr::Iter<rand::distr::StandardUniform, rand::rngs::StdRng, u8>;

#[derive(Clone, Debug)]
pub struct DataEncryptionInit {
    pub config: DataEncryptionInitConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct DataEncryptionInitReport {
    pub encrypted_data_segment_count: usize,
    pub active_data_segment_decryptor_count: usize,
    pub key_data_segment_count: usize,
    pub init_function_count: usize,
    pub diagnostics: Vec<DataEncryptionInitDiagnostic>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema)]
pub enum DataEncryptionInitDiagnostic {
    Disabled,
    UnsupportedCapabilities { capabilities: Vec<String> },
    NoNonEmptyDataSegments,
    MissingMemorySection,
    NoActiveNonEmptyDataSegments,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct DataEncryptionInitConfig {
    pub enabled: bool,
    pub seed: Option<[u8; 32]>,
}

#[allow(clippy::derivable_impls)]
impl Default for DataEncryptionInitConfig {
    fn default() -> Self {
        Self {
            enabled: true,
            seed: None,
        }
    }
}

/// Encrypt data
/// The key is always half the length of the data length
/// The data is xored with the key, looping the key as needed
/// e.g.
/// data: [0, 1, 0, 1, 0, 1, 0]
/// key:  [1, 1, 1]
/// encr: [1, 0, 1, 0, 1, 0, 1]
fn encrypt_data(
    key: &[u8],
    key_offset: usize,
    data_id: DataId,
    data: &mut Data,
    active_mem: Option<(MemId, Expression)>,
    is_64: bool,
) -> anyhow::Result<EncryptedData> {
    for (i, byte) in data.blob.iter_mut().enumerate() {
        *byte ^= key
            .get((i + key_offset).rem(key.len()))
            .ok_or_else(|| anyhow!("key element out of range"))?;
    }

    Ok(EncryptedData {
        data_id,
        data_len: data.blob.len(),
        key_offset,
        active_mem,
        is_64,
    })
}

fn max_data_len(module: &wasmbin::Module) -> anyhow::Result<Option<usize>> {
    let Some(data_section) = module.find_std_section::<payload::Data>() else {
        return Ok(None);
    };

    let data_max_len = data_section
        .try_contents()
        .context("failed to decode data section")?
        .iter()
        .map(|data| data.blob.len())
        .max()
        .unwrap_or(0);

    if data_max_len == 0 {
        Ok(None)
    } else {
        Ok(Some(data_max_len))
    }
}

fn memories_is_64(module: &wasmbin::Module) -> anyhow::Result<Option<Vec<bool>>> {
    let Some(memory_section) = module.find_std_section::<payload::Memory>() else {
        return Ok(None);
    };

    Ok(Some(
        memory_section
            .try_contents()
            .context("failed to decode memory section")?
            .iter()
            .map(|mem| mem.limits.is_64)
            .collect(),
    ))
}

fn create_key_material(
    seed: Option<[u8; 32]>,
    data_max_len: usize,
) -> anyhow::Result<(usize, Vec<u8>)> {
    let rng = match seed {
        Some(seed) => rand::rngs::StdRng::from_seed(seed),
        None => rand::rngs::StdRng::try_from_os_rng()?,
    };
    let mut rng = rng.random_iter::<u8>();

    let padding: u8 = read_num(&mut rng)?;
    let padding: usize = padding.into();
    let key_len = usize::min(32768usize, data_max_len + padding);
    let key = read_nums(&mut rng, key_len)?;

    Ok((key_len, key))
}

fn encryption_rng(seed: Option<[u8; 32]>) -> anyhow::Result<ByteRng> {
    let rng = match seed {
        Some(seed) => rand::rngs::StdRng::from_seed(seed),
        None => rand::rngs::StdRng::try_from_os_rng()?,
    };
    Ok(rng.random_iter::<u8>())
}

fn encrypt_active_data_segments(
    module: &mut wasmbin::Module,
    key: &[u8],
    key_len: usize,
    memories_is_64: &[bool],
    seed: Option<[u8; 32]>,
) -> anyhow::Result<Vec<EncryptedData>> {
    let mut rng = encryption_rng(seed)?;
    let _: u8 = read_num(&mut rng)?;

    module
        .find_std_section_mut::<payload::Data>()
        .context("already confirmed data section exists")?
        .try_contents_mut()
        .context("already decoded data section")?
        .iter_mut()
        .enumerate()
        .filter(|(_data_id, data)| {
            matches!(
                data.init,
                DataInit::Active { .. } | DataInit::ActiveWithMemory { .. }
            )
        })
        .filter(|(_data_id, data)| !data.blob.is_empty())
        .map(|(data_id, data)| {
            let offset: usize = read_num(&mut rng)?;
            let offset = offset.rem(key_len);
            let data_init = std::mem::replace(&mut data.init, DataInit::Passive);
            let active_mem = match data_init {
                DataInit::Active { offset } => Some((MemId { index: 0 }, offset)),
                DataInit::ActiveWithMemory { memory, offset } => Some((memory, offset)),
                DataInit::Passive => None,
            };
            let is_64 = active_mem
                .as_ref()
                .and_then(|active_mem| usize::try_from(active_mem.0.index).ok())
                .and_then(|mem_idx| memories_is_64.get(mem_idx).copied())
                .unwrap_or(false);

            encrypt_data(
                key,
                offset,
                u32::try_from(data_id)
                    .context("cannot turn data ID into u32")?
                    .into(),
                data,
                active_mem,
                is_64,
            )
        })
        .collect::<anyhow::Result<Vec<_>>>()
        .context("encrypting data segments")
}

fn insert_key_data(module: &mut wasmbin::Module, key: Vec<u8>) -> anyhow::Result<DataId> {
    let data_section = module
        .find_std_section_mut::<payload::Data>()
        .context("already confirmed data section exists")?
        .try_contents_mut()
        .context("already decoded contents")?;

    data_section.push(wasmbin::sections::Data {
        init: DataInit::Passive,
        blob: key,
    });

    Ok(DataId {
        index: (data_section.len() - 1)
            .try_into()
            .context("couldn't create key data ID - too many datas")?,
    })
}

fn update_data_count(module: &mut wasmbin::Module, key_data_idx: DataId) -> anyhow::Result<()> {
    let datas_count = module
        .find_or_insert_std_section::<payload::DataCount>(payload::DataCount::default)
        .try_contents_mut()
        .context("failed to decode data count section")?;
    *datas_count = key_data_idx
        .index
        .checked_add(1)
        .context("failed to encode num datas into u32")?;
    Ok(())
}

fn old_start_fn(module: &wasmbin::Module) -> anyhow::Result<Option<FuncId>> {
    module
        .find_std_section::<payload::Start>()
        .map(|start| {
            start
                .try_contents()
                .copied()
                .context("failed to decode start section")
        })
        .transpose()
}

fn create_data_decryptors(
    enc_datas: &[EncryptedData],
    key_data_idx: DataId,
    key_len: usize,
) -> anyhow::Result<Vec<(FuncBody, RecursiveType)>> {
    let key_len = key_len
        .try_into()
        .context("cannot convert key length into i32")?;

    enc_datas
        .iter()
        .filter_map(|enc_data| {
            enc_data
                .active_mem
                .as_ref()
                .map(|active_mem| (enc_data, active_mem))
        })
        .map(|(enc_data, active_mem)| {
            create_decrypt_fn_for_single_data(key_data_idx, key_len, enc_data, active_mem)
        })
        .collect::<anyhow::Result<Vec<_>>>()
        .context("creating decryptor functions for data segments")
}

fn install_init_fn(
    module: &mut wasmbin::Module,
    data_decryptors: Vec<(FuncBody, RecursiveType)>,
    old_start_fn: Option<FuncId>,
    key_data_idx: DataId,
) -> anyhow::Result<()> {
    let data_decrypt_fn_ids = add_funcs_to_mod(module, data_decryptors)?;
    let init_fn = create_init_fn(&data_decrypt_fn_ids, old_start_fn, true, key_data_idx);
    let init_fn_id = add_single_func_to_mod(module, init_fn.0, init_fn.1)?;

    *module
        .find_or_insert_std_section::<payload::Start>(|| FuncId { index: 0 })
        .try_contents_mut()
        .context("failed to decode start section")? = init_fn_id;

    Ok(())
}

impl Transformer for DataEncryptionInit {
    fn name(&self) -> &'static str {
        "data_encryption_init"
    }

    fn transform(
        &self,
        capabilities: &crate::capabilities::Capabilities,
        mut module: wasmbin::Module,
    ) -> anyhow::Result<TransformerOutput> {
        let mut report = DataEncryptionInitReport::default();
        if !self.config.enabled {
            report
                .diagnostics
                .push(DataEncryptionInitDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::DataEncryptionInit(report),
            });
        }

        let mut missing_capabilities = Vec::new();
        if !capabilities.bulk_memory() {
            missing_capabilities.push("bulk_memory".to_owned());
        }
        if !missing_capabilities.is_empty() {
            report
                .diagnostics
                .push(DataEncryptionInitDiagnostic::UnsupportedCapabilities {
                    capabilities: missing_capabilities,
                });
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::DataEncryptionInit(report),
            });
        }

        let Some(data_max_len) = max_data_len(&module)? else {
            report
                .diagnostics
                .push(DataEncryptionInitDiagnostic::NoNonEmptyDataSegments);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::DataEncryptionInit(report),
            });
        };
        let Some(memories_is_64) = memories_is_64(&module)? else {
            report
                .diagnostics
                .push(DataEncryptionInitDiagnostic::MissingMemorySection);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::DataEncryptionInit(report),
            });
        };

        let (key_len, key) = create_key_material(self.config.seed, data_max_len)?;
        let enc_datas = encrypt_active_data_segments(
            &mut module,
            &key,
            key_len,
            &memories_is_64,
            self.config.seed,
        )?;
        if enc_datas.is_empty() {
            report
                .diagnostics
                .push(DataEncryptionInitDiagnostic::NoActiveNonEmptyDataSegments);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::DataEncryptionInit(report),
            });
        }
        let key_data_idx = insert_key_data(&mut module, key)?;
        update_data_count(&mut module, key_data_idx)?;

        let old_start_fn = old_start_fn(&module)?;
        let data_decryptors = create_data_decryptors(&enc_datas, key_data_idx, key_len)?;
        install_init_fn(&mut module, data_decryptors, old_start_fn, key_data_idx)?;

        let active_segment_count = enc_datas
            .iter()
            .filter(|enc_data| enc_data.active_mem.is_some())
            .count();
        report.encrypted_data_segment_count = enc_datas.len();
        report.active_data_segment_decryptor_count = active_segment_count;
        report.key_data_segment_count = 1;
        report.init_function_count = 1;

        Ok(TransformerOutput {
            module,
            report: TransformerReport::DataEncryptionInit(report),
        })
    }
}
