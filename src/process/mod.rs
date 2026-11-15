mod transformers;

use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

pub use transformers::{
    CallGraphConfig, CallGraphDiagnostic, CallGraphReport, DataEncryptionInitConfig,
    DataEncryptionInitDiagnostic, DataEncryptionInitReport, DumpConfig, DumpDiagnostic, DumpReport,
    FunctionIndexRemapConfig, FunctionIndexRemapDiagnostic, FunctionIndexRemapReport,
    StringEncryptionConfig, StringEncryptionDiagnostic, StringEncryptionReport, StripDebugConfig,
    StripDebugDiagnostic, StripDebugReport, TransformersConfig, transformer::TransformerReport,
};

use crate::capabilities::Capabilities;

#[derive(Clone, Debug, Serialize, Deserialize, JsonSchema)]
pub struct NamedTransformerReport {
    pub name: String,
    pub report: TransformerReport,
}

#[derive(Debug)]
pub struct ProcessResult {
    pub module: wasmbin::Module,
    pub reports: Vec<NamedTransformerReport>,
}

pub fn process(
    mut module: wasmbin::Module,
    capabilities: &Capabilities,
    transformers_config: &TransformersConfig,
) -> anyhow::Result<ProcessResult> {
    let transformers = transformers::get_all_transformers(transformers_config);
    let mut reports = Vec::with_capacity(transformers.len());
    for ele in transformers {
        let name = ele.name();
        let output = ele.transform(capabilities, module)?;
        module = output.module;
        reports.push(NamedTransformerReport {
            name: name.to_owned(),
            report: output.report,
        });
    }
    Ok(ProcessResult { module, reports })
}
