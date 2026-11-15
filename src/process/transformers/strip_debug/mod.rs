use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;

use super::transformer::{Transformer, TransformerOutput, TransformerReport};

const BRANCH_HINT_SECTION_NAME: &str = "metadata.code.branch_hint";

#[derive(Clone, Debug)]
pub struct StripDebug {
    pub config: StripDebugConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct StripDebugReport {
    pub removed_custom_sections: usize,
    pub diagnostics: Vec<StripDebugDiagnostic>,
}

#[derive(Clone, Debug, Serialize, Deserialize, JsonSchema)]
pub enum StripDebugDiagnostic {
    Disabled,
    NoCustomSectionsEligibleForStripping,
    PreservedBranchHints { count: usize },
    ModuleUnchanged,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct StripDebugConfig {
    pub enabled: bool,
    pub strip_branch_hints: bool,
}
#[allow(clippy::derivable_impls)]
impl Default for StripDebugConfig {
    fn default() -> Self {
        Self {
            enabled: true,
            strip_branch_hints: false,
        }
    }
}

impl Transformer for StripDebug {
    fn name(&self) -> &'static str {
        "strip_debug"
    }

    fn transform(
        &self,
        _capabilities: &crate::capabilities::Capabilities,
        mut module: wasmbin::Module,
    ) -> anyhow::Result<TransformerOutput> {
        let mut report = StripDebugReport::default();
        if !self.config.enabled {
            report.diagnostics.push(StripDebugDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::StripDebug(report),
            });
        }

        let original_section_count = module.sections.len();
        let mut removed_custom_sections = 0usize;
        let mut preserved_branch_hint_sections = 0usize;
        module.sections.retain(|section| match section {
            wasmbin::sections::Section::Custom(custom) => {
                let is_branch_hint = custom
                    .try_contents()
                    .is_ok_and(|custom| custom.name() == BRANCH_HINT_SECTION_NAME);

                if is_branch_hint && !self.config.strip_branch_hints {
                    preserved_branch_hint_sections += 1;
                    true
                } else {
                    removed_custom_sections += 1;
                    false
                }
            }
            _ => true,
        });

        if removed_custom_sections == 0 {
            report
                .diagnostics
                .push(StripDebugDiagnostic::NoCustomSectionsEligibleForStripping);
        }
        report.removed_custom_sections = removed_custom_sections;

        if preserved_branch_hint_sections != 0 {
            report
                .diagnostics
                .push(StripDebugDiagnostic::PreservedBranchHints {
                    count: preserved_branch_hint_sections,
                });
        }

        if original_section_count == module.sections.len() && removed_custom_sections == 0 {
            report
                .diagnostics
                .push(StripDebugDiagnostic::ModuleUnchanged);
        }

        Ok(TransformerOutput {
            module,
            report: TransformerReport::StripDebug(report),
        })
    }
}
