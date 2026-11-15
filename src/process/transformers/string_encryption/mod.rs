mod decrypt_fn;

use anyhow::{Context, bail};
use rand::{Rng as _, SeedableRng as _};
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;
use wasmbin::{
    indices::{DataId, FuncId, GlobalId, TypeId},
    instructions::Instruction,
    sections::{self, Import, ImportDesc, payload},
    types::{
        AbstractHeapType, CompositeType, FieldType, FuncType, GlobalType, HeapType, RecursiveType,
        RefType, StorageType, SubType, ValueType,
    },
    visit::Visit,
};

use crate::utils::{
    mod_fn_add::add_funcs_to_mod,
    mod_fn_add::next_type_index,
    rng::{read_num, read_nums},
};

use self::decrypt_fn::{DecryptFnInput, EncryptedStringData, create_decrypt_fn_for_strings};
use super::transformer::{Transformer, TransformerOutput, TransformerReport};

type ByteRng = rand::distr::Iter<rand::distr::StandardUniform, rand::rngs::StdRng, u8>;

#[derive(Clone, Debug)]
pub struct StringEncryption {
    pub config: StringEncryptionConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct StringEncryptionReport {
    pub encrypted_imported_global_count: usize,
    pub replacement_global_count: usize,
    pub passive_data_segment_count: usize,
    pub decrypt_start_function_count: usize,
    pub diagnostics: Vec<StringEncryptionDiagnostic>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema)]
pub enum StringEncryptionDiagnostic {
    Disabled,
    UnsupportedCapabilities { capabilities: Vec<String> },
    MissingImportedJsStringNamespace,
    NoEncryptableGlobalImports { namespace: String },
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct StringEncryptionConfig {
    pub enabled: bool,
    pub seed: Option<[u8; 32]>,
    pub imported_js_string_namespace: Option<String>,
}

#[allow(clippy::derivable_impls)]
impl Default for StringEncryptionConfig {
    fn default() -> Self {
        Self {
            enabled: true,
            seed: None,
            imported_js_string_namespace: Some("string_constants".to_owned()),
        }
    }
}

struct PreparedStringImports {
    import_id_map: Vec<Option<GlobalId>>,
    encrypted_imports: Vec<PendingEncryptedImport>,
    total_old_global_import_count: usize,
    remaining_imported_global_count: usize,
    key_len: usize,
    key_offset: usize,
    key: Vec<u16>,
}

struct PendingEncryptedImport {
    old_import_index: usize,
    blob: Vec<u8>,
    utf16_len: i32,
}

struct AssignedGlobalImport {
    global_id: GlobalId,
    blob: Vec<u8>,
    utf16_len: i32,
}

struct StoredStringData {
    key_data_id: DataId,
    encrypted: Vec<EncryptedStringData>,
    replacement_global_ids: Vec<GlobalId>,
}

fn encryption_rng(seed: Option<[u8; 32]>) -> anyhow::Result<ByteRng> {
    let rng = match seed {
        Some(seed) => rand::rngs::StdRng::from_seed(seed),
        None => rand::rngs::StdRng::try_from_os_rng()?,
    };
    Ok(rng.random_iter::<u8>())
}

fn encrypt_string_as_utf16(key: &[u16], key_offset: usize, data: &str) -> Vec<u8> {
    data.encode_utf16()
        .enumerate()
        .map(|(i, byte)| {
            let key_byte = key[(key_offset + i) % key.len()];
            byte ^ key_byte
        })
        .flat_map(u16::to_le_bytes)
        .collect()
}

fn prepare_string_imports(
    module: &mut wasmbin::Module,
    imported_js_string_namespace: &str,
    seed: Option<[u8; 32]>,
) -> anyhow::Result<Option<PreparedStringImports>> {
    let mut rng = encryption_rng(seed)?;
    let padding: usize = usize::from(read_num::<u8, _, _>(&mut rng)?);

    let Some(imports) = module.find_std_section_mut::<payload::Import>() else {
        return Ok(None);
    };
    let imports_section = imports
        .try_contents_mut()
        .context("failed to decode imports section")?;

    let (string_imports, old_imports): (Vec<_>, Vec<_>) = imports_section
        .iter()
        .filter(|import| matches!(import.desc, ImportDesc::Global(_)))
        .enumerate()
        .map(|(i, import)| (i, import.path.name.clone(), import.path.module.clone()))
        .partition(|(_, _, module_name)| module_name == imported_js_string_namespace);

    if string_imports.is_empty() {
        return Ok(None);
    }

    let string_import_max_length = string_imports
        .iter()
        .map(|(_, name, _)| name.len())
        .max()
        .unwrap_or(0);
    if string_import_max_length == 0 {
        return Ok(None);
    }

    let key_len = usize::min(32768usize, string_import_max_length + padding);
    let key: Vec<u16> = read_nums(&mut rng, key_len)?;
    let mut import_id_map = vec![None; old_imports.len() + string_imports.len()];

    for (new_i, (old_i, _, _)) in old_imports.iter().enumerate() {
        let new_global_id: GlobalId = u32::try_from(new_i)
            .context("failed to convert new global index to u32 - too many globals")?
            .into();
        import_id_map[*old_i] = Some(new_global_id);
    }

    let encrypted_imports = string_imports
        .into_iter()
        .map(|(old_import_index, old_name, _)| {
            Ok(PendingEncryptedImport {
                old_import_index,
                blob: encrypt_string_as_utf16(&key, padding, &old_name),
                utf16_len: i32::try_from(old_name.encode_utf16().count())
                    .context("encrypted string length did not fit i32")?,
            })
        })
        .collect::<anyhow::Result<Vec<_>>>()?;
    let encrypted_import_count = encrypted_imports.len();

    imports_section.retain(|import| {
        !matches!(import.desc, ImportDesc::Global(_))
            || import.path.module != imported_js_string_namespace
    });

    Ok(Some(PreparedStringImports {
        import_id_map,
        encrypted_imports,
        total_old_global_import_count: old_imports.len() + encrypted_import_count,
        remaining_imported_global_count: old_imports.len(),
        key_len,
        key_offset: padding,
        key,
    }))
}

fn insert_replacement_globals(
    module: &mut wasmbin::Module,
    import_id_map: &mut [Option<GlobalId>],
    remaining_imported_global_count: usize,
    encrypted_imports: Vec<PendingEncryptedImport>,
) -> anyhow::Result<Vec<AssignedGlobalImport>> {
    let globals_section = module
        .find_or_insert_std_section::<payload::Global>(payload::Global::default)
        .try_contents_mut()
        .context("failed to decode globals section")?;
    let existing_defined_global_count = globals_section.len();

    encrypted_imports
        .into_iter()
        .enumerate()
        .map(|(added_i, encrypted)| {
            let new_global_id: GlobalId = u32::try_from(
                remaining_imported_global_count + existing_defined_global_count + added_i,
            )
            .context("failed to convert new global index to u32 - too many globals")?
            .into();
            globals_section.push(sections::Global {
                ty: GlobalType {
                    value_type: ValueType::Ref(RefType::NullableHeapType(HeapType::Abstract(
                        AbstractHeapType::Extern,
                    ))),
                    mutable: true,
                },
                init: vec![Instruction::RefNull(HeapType::Abstract(
                    AbstractHeapType::Extern,
                ))],
            });
            import_id_map[encrypted.old_import_index] = Some(new_global_id);
            Ok(AssignedGlobalImport {
                global_id: new_global_id,
                blob: encrypted.blob,
                utf16_len: encrypted.utf16_len,
            })
        })
        .collect()
}

fn store_string_data(
    module: &mut wasmbin::Module,
    key: Vec<u16>,
    encrypted_imports: Vec<AssignedGlobalImport>,
) -> anyhow::Result<StoredStringData> {
    let data_section = module
        .find_or_insert_std_section::<payload::Data>(payload::Data::default)
        .try_contents_mut()
        .context("failed to decode data section")?;

    let key_data_id = u32::try_from(data_section.len())
        .context("failed to encode num datas into u32")?
        .into();
    data_section.push(sections::Data {
        init: sections::DataInit::Passive,
        blob: key.into_iter().flat_map(u16::to_le_bytes).collect(),
    });

    let encrypted = encrypted_imports
        .into_iter()
        .map(|encrypted| {
            let data_id = u32::try_from(data_section.len())
                .context("failed to encode num datas into u32")?
                .into();
            data_section.push(sections::Data {
                init: sections::DataInit::Passive,
                blob: encrypted.blob,
            });
            Ok(EncryptedStringData {
                global_id: encrypted.global_id,
                data_id,
                enc_len: encrypted.utf16_len,
            })
        })
        .collect::<anyhow::Result<Vec<_>>>()?;

    let replacement_global_ids = encrypted.iter().map(|entry| entry.global_id).collect();
    let data_count =
        u32::try_from(data_section.len()).context("failed to encode num datas into u32")?;
    *module
        .find_or_insert_std_section::<payload::DataCount>(payload::DataCount::default)
        .try_contents_mut()
        .context("failed to decode data count section")? = data_count;

    Ok(StoredStringData {
        key_data_id,
        encrypted,
        replacement_global_ids,
    })
}

fn ensure_utf16_mut_array_type(module: &mut wasmbin::Module) -> anyhow::Result<TypeId> {
    let type_section = module
        .find_or_insert_std_section::<payload::Type>(payload::Type::default)
        .try_contents_mut()
        .context("failed to decode type section")?;
    let utf16_mut_array_type = u32::try_from(next_type_index(type_section)?)
        .context("failed to encode num types into u32")?
        .into();
    type_section.push(RecursiveType::SubType(SubType::FinalEmptySubType(
        CompositeType::Array(FieldType {
            storage_type: StorageType::I16,
            mutable: true,
        }),
    )));
    Ok(utf16_mut_array_type)
}

fn find_from_charcode_array_import(module: &wasmbin::Module) -> Option<usize> {
    module
        .find_std_section::<payload::Import>()
        .and_then(|import_section| import_section.try_contents().ok())
        .and_then(|import_section| {
            import_section.iter().enumerate().find_map(|(i, import)| {
                if matches!(import.desc, ImportDesc::Func(_))
                    && import.path.module == "wasm:js-string"
                    && import.path.name == "fromCharCodeArray"
                {
                    Some(i)
                } else {
                    None
                }
            })
        })
}

fn ensure_from_charcode_array_import(
    module: &mut wasmbin::Module,
    utf16_mut_array_type: TypeId,
) -> anyhow::Result<(FuncId, Option<FuncId>)> {
    if let Some(func_id) = find_from_charcode_array_import(module) {
        return u32::try_from(func_id)
            .context("failed to convert fromCharCodeArray func index to u32")
            .map(|func_id| (FuncId::from(func_id), None));
    }

    let type_section = module
        .find_or_insert_std_section::<payload::Type>(payload::Type::default)
        .try_contents_mut()
        .context("failed to decode type section")?;
    let func_type_id = u32::try_from(next_type_index(type_section)?)
        .context("failed to encode num types into u32")?
        .into();
    type_section.push(RecursiveType::SubType(SubType::FinalEmptySubType(
        CompositeType::Func(FuncType {
            params: vec![
                ValueType::Ref(RefType::NullableHeapType(HeapType::TypeIndex(
                    utf16_mut_array_type,
                ))),
                ValueType::I32,
                ValueType::I32,
            ],
            results: vec![ValueType::Ref(RefType::HeapType(HeapType::Abstract(
                AbstractHeapType::Extern,
            )))],
        }),
    )));

    let import_section = module
        .find_or_insert_std_section::<payload::Import>(payload::Import::default)
        .try_contents_mut()
        .context("failed to decode import section")?;
    let func_id = u32::try_from(
        import_section
            .iter()
            .filter(|import| matches!(import.desc, ImportDesc::Func(_)))
            .count(),
    )
    .context("failed to encode num types into u32")
    .map(FuncId::from)?;
    import_section.push(Import {
        path: sections::ImportPath {
            module: "wasm:js-string".into(),
            name: "fromCharCodeArray".into(),
        },
        desc: ImportDesc::Func(func_type_id),
    });

    Ok((func_id, Some(func_id)))
}

fn shift_func_ids_for_added_import(
    module: &mut wasmbin::Module,
    added_func_import_id: Option<FuncId>,
) -> anyhow::Result<()> {
    let Some(added_func_import_id) = added_func_import_id else {
        return Ok(());
    };

    module.visit_mut(|func_id: &mut FuncId| {
        if func_id.index >= added_func_import_id.index {
            func_id.index += 1;
        }
    })?;
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

fn remap_global_ids(
    module: &mut wasmbin::Module,
    import_id_map: &[Option<GlobalId>],
    total_old_global_import_count: usize,
    removed_global_import_count: usize,
) -> anyhow::Result<()> {
    if let Err(error) = module.visit_mut(|global_id: &mut GlobalId| {
        let old_index =
            usize::try_from(global_id.index).context("failed to convert global index to usize")?;
        if old_index < total_old_global_import_count {
            *global_id = import_id_map[old_index]
                .context("missing remapped global index for old imported global")?;
        } else {
            global_id.index -= u32::try_from(removed_global_import_count)
                .context("failed to convert removed global import count to u32")?;
        }
        Ok::<(), anyhow::Error>(())
    }) {
        bail!("failed to map global IDs: {error}");
    }

    Ok(())
}

fn insert_non_null_global_gets(
    module: &mut wasmbin::Module,
    replacement_global_ids: &[GlobalId],
) -> anyhow::Result<()> {
    module.visit_mut(|expr: &mut Vec<Instruction>| {
        let mut rewritten = Vec::with_capacity(expr.len());
        for instruction in std::mem::take(expr) {
            let needs_non_null = matches!(
                &instruction,
                Instruction::GlobalGet(global_id) if replacement_global_ids.contains(global_id)
            );
            rewritten.push(instruction);
            if needs_non_null {
                rewritten.push(Instruction::RefAsNonNull);
            }
        }
        *expr = rewritten;
    })?;
    Ok(())
}

fn install_decrypt_start_fn(
    module: &mut wasmbin::Module,
    decrypt_fn: (sections::FuncBody, RecursiveType),
) -> anyhow::Result<()> {
    let decrypt_fn_id = add_funcs_to_mod(module, vec![decrypt_fn])?
        .pop()
        .context("failed to get decrypt function id after adding it to module")?;

    *module
        .find_or_insert_std_section::<payload::Start>(|| FuncId { index: 0 })
        .try_contents_mut()
        .context("failed to decode start section")? = decrypt_fn_id;

    Ok(())
}

impl Transformer for StringEncryption {
    fn name(&self) -> &'static str {
        "string_encryption"
    }

    fn transform(
        &self,
        capabilities: &crate::capabilities::Capabilities,
        mut module: wasmbin::Module,
    ) -> anyhow::Result<TransformerOutput> {
        let mut report = StringEncryptionReport::default();
        if !self.config.enabled {
            report
                .diagnostics
                .push(StringEncryptionDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::StringEncryption(report),
            });
        }

        let mut missing_capabilities = Vec::new();
        if !capabilities.reference_types() {
            missing_capabilities.push("reference_types".to_owned());
        }
        if !capabilities.bulk_memory() {
            missing_capabilities.push("bulk_memory".to_owned());
        }
        if !capabilities.gc() {
            missing_capabilities.push("gc".to_owned());
        }
        if !capabilities.js_string_builtins() {
            missing_capabilities.push("js_string_builtins".to_owned());
        }
        if !missing_capabilities.is_empty() {
            report
                .diagnostics
                .push(StringEncryptionDiagnostic::UnsupportedCapabilities {
                    capabilities: missing_capabilities,
                });
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::StringEncryption(report),
            });
        }

        let Some(imported_js_string_namespace) = &self.config.imported_js_string_namespace else {
            report
                .diagnostics
                .push(StringEncryptionDiagnostic::MissingImportedJsStringNamespace);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::StringEncryption(report),
            });
        };
        let Some(mut prepared) =
            prepare_string_imports(&mut module, imported_js_string_namespace, self.config.seed)?
        else {
            report
                .diagnostics
                .push(StringEncryptionDiagnostic::NoEncryptableGlobalImports {
                    namespace: imported_js_string_namespace.clone(),
                });
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::StringEncryption(report),
            });
        };
        let encrypted_import_count = prepared.encrypted_imports.len();

        let assigned_globals = insert_replacement_globals(
            &mut module,
            &mut prepared.import_id_map,
            prepared.remaining_imported_global_count,
            prepared.encrypted_imports,
        )?;
        let stored_data = store_string_data(&mut module, prepared.key, assigned_globals)?;
        let stored_string_count = stored_data.encrypted.len();
        let replacement_global_count = stored_data.replacement_global_ids.len();
        let utf16_mut_array_type = ensure_utf16_mut_array_type(&mut module)?;
        let (from_charcode_array_func_id, added_func_import_id) =
            ensure_from_charcode_array_import(&mut module, utf16_mut_array_type)?;
        shift_func_ids_for_added_import(&mut module, added_func_import_id)?;

        let decrypt_fn = create_decrypt_fn_for_strings(DecryptFnInput {
            key_data_id: stored_data.key_data_id,
            key_len: prepared.key_len,
            key_offset: prepared.key_offset,
            utf16_mut_array_type,
            from_charcode_array_func_id,
            old_start_fn: old_start_fn(&module)?,
            encrypted: stored_data.encrypted,
        })?;

        remap_global_ids(
            &mut module,
            &prepared.import_id_map,
            prepared.total_old_global_import_count,
            prepared.total_old_global_import_count - prepared.remaining_imported_global_count,
        )?;
        insert_non_null_global_gets(&mut module, &stored_data.replacement_global_ids)?;
        install_decrypt_start_fn(&mut module, decrypt_fn)?;

        report.encrypted_imported_global_count = encrypted_import_count;
        report.replacement_global_count = replacement_global_count;
        report.passive_data_segment_count = stored_string_count + 1;
        report.decrypt_start_function_count = 1;

        Ok(TransformerOutput {
            module,
            report: TransformerReport::StringEncryption(report),
        })
    }
}
