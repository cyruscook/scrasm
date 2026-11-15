#![warn(clippy::all, clippy::pedantic, clippy::nursery, clippy::cargo)]
#![deny(clippy::unwrap_used, clippy::expect_used, clippy::panic)]

use std::{
    collections::BTreeMap,
    io::{Read, Seek, Write},
};

use schemars::{JsonSchema, Schema, schema_for};
use serde::{Deserialize, Serialize};
use ts_rs::TS;

pub(crate) mod capabilities;
pub mod json;
mod parse;
mod process;
pub(crate) mod utils;
mod write;

pub use process::{
    CallGraphConfig, CallGraphDiagnostic, CallGraphReport, DataEncryptionInitConfig,
    DataEncryptionInitDiagnostic, DataEncryptionInitReport, DumpConfig, DumpDiagnostic, DumpReport,
    FunctionIndexRemapConfig, FunctionIndexRemapDiagnostic, FunctionIndexRemapReport,
    StringEncryptionConfig, StringEncryptionDiagnostic, StringEncryptionReport, StripDebugConfig,
    StripDebugDiagnostic, StripDebugReport, TransformerReport, TransformersConfig,
};
use wasmbin::visit::Visit;

use crate::capabilities::get_capabilities_for_module;
pub use crate::capabilities::{CapabilitiesConfig, MinimumRequiredSupport};

pub type TransformerReportsByName = BTreeMap<String, Vec<TransformerReport>>;

#[derive(Clone, Debug)]
pub struct Scrasm {
    config: ScrasmConfig,
}

#[derive(Clone, Default, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct ScrasmConfig {
    pub capabilities: CapabilitiesConfig,
    pub transformers: TransformersConfig,
    pub force_visit: bool,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, JsonSchema)]
pub struct ScrasmJsonOutput {
    pub reports: TransformerReportsByName,
}

impl Scrasm {
    #[must_use]
    pub fn with_default_config() -> Self {
        Self {
            config: ScrasmConfig::default(),
        }
    }

    #[must_use]
    pub const fn with_config(config: ScrasmConfig) -> Self {
        Self { config }
    }

    #[allow(clippy::missing_errors_doc)]
    pub fn scrasm<R: Read + Seek, W: Write + Seek>(
        &self,
        inp: R,
        out: W,
    ) -> Result<(), anyhow::Error> {
        let _reports = self.scrasm_with_reports(inp, out)?;
        Ok(())
    }

    #[allow(clippy::missing_errors_doc)]
    pub fn scrasm_with_reports<R: Read + Seek, W: Write + Seek>(
        &self,
        inp: R,
        out: W,
    ) -> Result<TransformerReportsByName, anyhow::Error> {
        let mut module = parse::parse(inp)?;

        let capabilities = get_capabilities_for_module(self.config.capabilities, &module);

        if self.config.force_visit {
            module.visit_mut(|()| {})?;
        }
        let process_result = process::process(module, &capabilities, &self.config.transformers)?;
        let module = process_result.module;
        let mut reports_by_name = TransformerReportsByName::new();
        for named_report in process_result.reports {
            reports_by_name
                .entry(named_report.name)
                .or_default()
                .push(named_report.report);
        }

        write::write(out, &module)?;
        Ok(reports_by_name)
    }
}

#[must_use]
pub fn with_default_config() -> Scrasm {
    Scrasm::with_default_config()
}

#[must_use]
pub const fn with_config(config: ScrasmConfig) -> Scrasm {
    Scrasm::with_config(config)
}

#[must_use]
pub fn config_json_schema() -> Schema {
    schema_for!(ScrasmConfig)
}

#[must_use]
pub fn output_json_schema() -> Schema {
    schema_for!(ScrasmJsonOutput)
}
