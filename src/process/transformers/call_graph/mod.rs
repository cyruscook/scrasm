//! Conservative direct-call obfuscation through a private table-dispatch layer.
//!
//! The pass only runs for modules that fit the v1 constraints from
//! `docs/control-flow-obfuscation-v1.md`. When those checks fail it becomes a no-op
//! instead of trying to partially rewrite the module.

mod analyse;
mod dispatch;
mod rewrite;

use anyhow::Result;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;

use super::transformer::{Transformer, TransformerOutput, TransformerReport};

#[derive(Clone, Debug)]
pub struct CallGraph {
    pub config: CallGraphConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct CallGraphReport {
    pub rewritten_callee_count: usize,
    pub dispatcher_count: usize,
    pub reserved_dispatch_slot_count: usize,
    pub diagnostics: Vec<CallGraphDiagnostic>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema)]
pub enum CallGraphDiagnostic {
    Disabled,
    UnsupportedCapabilities {
        capabilities: Vec<String>,
    },
    ImportedTable,
    UnsupportedTableConfiguration {
        reason: String,
    },
    InsufficientTableCapacity {
        maximum: u64,
        additional_private_slots: usize,
    },
    NoEligibleDirectCalls,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct CallGraphConfig {
    /// Enables the pass. Disabled by default because it adds an indirect dispatch layer.
    pub enabled: bool,
    /// Controls both slot shuffling and the per-dispatcher XOR key.
    pub seed: Option<[u8; 32]>,
}

#[allow(clippy::derivable_impls)]
impl Default for CallGraphConfig {
    fn default() -> Self {
        Self {
            enabled: false,
            seed: None,
        }
    }
}

impl Transformer for CallGraph {
    fn name(&self) -> &'static str {
        "call_graph"
    }

    fn transform(
        &self,
        capabilities: &crate::capabilities::Capabilities,
        mut module: wasmbin::Module,
    ) -> Result<TransformerOutput> {
        let mut report = CallGraphReport::default();
        if !self.config.enabled {
            report.diagnostics.push(CallGraphDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::CallGraph(report),
            });
        }

        let mut missing_capabilities = Vec::new();
        if !capabilities.reference_types() {
            missing_capabilities.push("reference_types".to_owned());
        }
        if !missing_capabilities.is_empty() {
            report
                .diagnostics
                .push(CallGraphDiagnostic::UnsupportedCapabilities {
                    capabilities: missing_capabilities,
                });
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::CallGraph(report),
            });
        }

        let analysis = match analyse::analyse(&module, self.config.seed)? {
            analyse::AnalysisOutcome::Ready(analysis) => analysis,
            analyse::AnalysisOutcome::Skipped(report) => {
                return Ok(TransformerOutput {
                    module,
                    report: TransformerReport::CallGraph(report),
                });
            }
        };

        rewrite::install_dispatch_table(&mut module, &analysis)?;
        let dispatchers = dispatch::append_dispatchers(&mut module, &analysis, self.config.seed)?;
        rewrite::rewrite_calls(&mut module, &analysis, &dispatchers)?;

        report.rewritten_callee_count = analysis.eligible_funcs.len();
        report.dispatcher_count = dispatchers.len();
        report.reserved_dispatch_slot_count = analysis.slot_order.len();

        Ok(TransformerOutput {
            module,
            report: TransformerReport::CallGraph(report),
        })
    }
}
