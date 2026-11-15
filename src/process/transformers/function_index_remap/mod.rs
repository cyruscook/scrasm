use anyhow::{Context, Result, bail};
use rand::{SeedableRng, seq::SliceRandom};
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;
use wasmbin::{
    Module,
    indices::FuncId,
    sections::{ImportDesc, payload},
    visit::Visit,
};

use super::transformer::{Transformer, TransformerOutput, TransformerReport};

#[derive(Clone, Debug)]
pub struct FunctionIndexRemap {
    pub config: FunctionIndexRemapConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct FunctionIndexRemapReport {
    pub remapped_function_count: usize,
    pub diagnostics: Vec<FunctionIndexRemapDiagnostic>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema)]
pub enum FunctionIndexRemapDiagnostic {
    Disabled,
    TooFewLocalFunctions { count: usize },
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct FunctionIndexRemapConfig {
    pub enabled: bool,
    pub seed: Option<[u8; 32]>,
}

#[allow(clippy::derivable_impls)]
impl Default for FunctionIndexRemapConfig {
    fn default() -> Self {
        Self {
            enabled: true,
            seed: None,
        }
    }
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

fn shuffled_local_order(local_func_count: usize, seed: Option<[u8; 32]>) -> Result<Vec<usize>> {
    let mut order: Vec<_> = (0..local_func_count).collect();
    let mut rng = match seed {
        Some(seed) => rand::rngs::StdRng::from_seed(seed),
        None => rand::rngs::StdRng::try_from_os_rng()?,
    };
    order.shuffle(&mut rng);
    if order.iter().copied().eq(0..local_func_count) {
        order.rotate_left(1);
    }
    Ok(order)
}

fn rewrite_local_function_ids(
    module: &mut Module,
    imported_func_count: u32,
    new_func_ids: &[u32],
) -> Result<()> {
    module.visit_mut(|func_id: &mut FuncId| {
        if let Some(local_index_u32) = func_id.index.checked_sub(imported_func_count)
            && let Ok(local_index) = usize::try_from(local_index_u32)
            && let Some(new_func_id) = new_func_ids.get(local_index)
        {
            func_id.index = *new_func_id;
        }
    })?;
    Ok(())
}

fn reorder_local_functions(module: &mut Module, local_order: &[usize]) -> Result<()> {
    let local_func_count = local_order.len();
    let original_types = {
        let function_section = module
            .find_std_section_mut::<payload::Function>()
            .context("missing function section while reordering local functions")?;
        let function_types = function_section
            .try_contents_mut()
            .context("failed to decode function section")?;
        if function_types.len() != local_func_count {
            bail!("function section length changed during remap");
        }
        std::mem::take(function_types)
    };
    let original_bodies = {
        let code_section = module
            .find_std_section_mut::<payload::Code>()
            .context("missing code section while reordering local functions")?;
        let code_bodies = code_section
            .try_contents_mut()
            .context("failed to decode code section")?;
        if code_bodies.len() != local_func_count {
            bail!(
                "function section and code section length mismatch: {} vs {}",
                local_func_count,
                code_bodies.len()
            );
        }
        std::mem::take(code_bodies)
    };

    let mut original_types = original_types.into_iter().map(Some).collect::<Vec<_>>();
    let mut original_bodies = original_bodies.into_iter().map(Some).collect::<Vec<_>>();
    let mut reordered_types = Vec::with_capacity(local_func_count);
    let mut reordered_bodies = Vec::with_capacity(local_func_count);

    for &old_local_index in local_order {
        let function_type = original_types
            .get_mut(old_local_index)
            .and_then(Option::take)
            .context("local function order referenced missing function type")?;
        let function_body = original_bodies
            .get_mut(old_local_index)
            .and_then(Option::take)
            .context("local function order referenced missing function body")?;
        reordered_types.push(function_type);
        reordered_bodies.push(function_body);
    }

    module
        .find_std_section_mut::<payload::Function>()
        .context("missing function section while storing reordered local functions")?
        .try_contents_mut()
        .context("failed to decode function section")?
        .extend(reordered_types);
    module
        .find_std_section_mut::<payload::Code>()
        .context("missing code section while storing reordered local functions")?
        .try_contents_mut()
        .context("failed to decode code section")?
        .extend(reordered_bodies);

    Ok(())
}

impl Transformer for FunctionIndexRemap {
    fn name(&self) -> &'static str {
        "function_index_remap"
    }

    fn transform(
        &self,
        _capabilities: &crate::capabilities::Capabilities,
        mut module: Module,
    ) -> Result<TransformerOutput> {
        let mut report = FunctionIndexRemapReport::default();
        if !self.config.enabled {
            report
                .diagnostics
                .push(FunctionIndexRemapDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::FunctionIndexRemap(report),
            });
        }

        let local_func_count =
            module
                .find_std_section::<payload::Function>()
                .map_or(Ok(0usize), |section| {
                    section
                        .try_contents()
                        .context("failed to decode function section")
                        .map(std::vec::Vec::len)
                })?;
        if local_func_count < 2 {
            report
                .diagnostics
                .push(FunctionIndexRemapDiagnostic::TooFewLocalFunctions {
                    count: local_func_count,
                });
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::FunctionIndexRemap(report),
            });
        }

        let imported_func_count = imported_func_count(&module)?;
        let imported_func_count_u32 = u32::try_from(imported_func_count)
            .context("imported function count did not fit u32")?;
        let local_order = shuffled_local_order(local_func_count, self.config.seed)?;
        let mut new_func_ids = vec![0u32; local_func_count];
        for (new_local_index, old_local_index) in local_order.iter().copied().enumerate() {
            let new_local_index_u32 = u32::try_from(new_local_index)
                .context("new local function index did not fit u32")?;
            let new_func_id = imported_func_count_u32
                .checked_add(new_local_index_u32)
                .context("failed to compute remapped function index")?;
            let slot = new_func_ids
                .get_mut(old_local_index)
                .context("local function order referenced missing function slot")?;
            *slot = new_func_id;
        }

        reorder_local_functions(&mut module, &local_order)?;
        rewrite_local_function_ids(&mut module, imported_func_count_u32, &new_func_ids)?;

        report.remapped_function_count = local_func_count;
        Ok(TransformerOutput {
            module,
            report: TransformerReport::FunctionIndexRemap(report),
        })
    }
}
