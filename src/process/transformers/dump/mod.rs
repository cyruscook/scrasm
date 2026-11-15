use std::fmt::Write;

use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;
use wasmbin::{
    io::DecodeError,
    visit::{Visit, VisitError},
};

use super::transformer::{Transformer, TransformerOutput, TransformerReport};

fn unlazify_with_opt<T: Visit>(wasm: &mut T, include_raw: bool) -> Result<(), DecodeError> {
    let res = if include_raw {
        wasm.visit(|()| {})
    } else {
        wasm.visit_mut(|()| {})
    };
    match res {
        Ok(()) => Ok(()),
        Err(err) => match err {
            VisitError::LazyDecode(err) => Err(err),
            VisitError::Custom(err) => match err {},
        },
    }
}

#[derive(Clone, Debug)]
pub struct Dump {
    pub config: DumpConfig,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct DumpReport {
    pub dumped_sections: usize,
    pub diagnostics: Vec<DumpDiagnostic>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub output: Option<String>,
}

#[derive(Clone, Debug, Serialize, Deserialize, JsonSchema)]
pub enum DumpDiagnostic {
    Disabled,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct DumpConfig {
    pub enabled: bool,
    pub include_raw: bool,
}
#[allow(clippy::derivable_impls)]
impl Default for DumpConfig {
    fn default() -> Self {
        Self {
            enabled: false,
            include_raw: true,
        }
    }
}

impl Transformer for Dump {
    fn name(&self) -> &'static str {
        "dump"
    }

    fn transform(
        &self,
        _capabilities: &crate::capabilities::Capabilities,
        mut module: wasmbin::Module,
    ) -> anyhow::Result<TransformerOutput> {
        let mut report = DumpReport::default();
        if !self.config.enabled {
            report.diagnostics.push(DumpDiagnostic::Disabled);
            return Ok(TransformerOutput {
                module,
                report: TransformerReport::Dump(report),
            });
        }

        let mut count = 0;
        let mut output = String::from("Dumping module:\n");
        for s in &mut module.sections {
            count += 1;
            unlazify_with_opt(s, self.config.include_raw)?;
            writeln!(output, "{s:#?}")?;
        }
        writeln!(output, "Dumped {count} sections.")?;
        #[cfg(not(target_arch = "wasm32"))]
        print!("{output}");

        report.dumped_sections = count;
        report.output = Some(output);

        Ok(TransformerOutput {
            module,
            report: TransformerReport::Dump(report),
        })
    }
}
