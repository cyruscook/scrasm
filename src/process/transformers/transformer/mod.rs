use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

#[derive(Debug)]
pub struct TransformerOutput {
    pub module: wasmbin::Module,
    pub report: TransformerReport,
}

#[derive(Clone, Debug, Serialize, Deserialize, JsonSchema)]
pub enum TransformerReport {
    CallGraph(super::call_graph::CallGraphReport),
    DataEncryptionInit(super::data_encryption_init::DataEncryptionInitReport),
    Dump(super::dump::DumpReport),
    FunctionIndexRemap(super::function_index_remap::FunctionIndexRemapReport),
    StringEncryption(super::string_encryption::StringEncryptionReport),
    StripDebug(super::strip_debug::StripDebugReport),
}

pub trait Transformer {
    fn name(&self) -> &'static str;

    fn transform(
        &self,
        capabilities: &crate::capabilities::Capabilities,
        module: wasmbin::Module,
    ) -> anyhow::Result<TransformerOutput>;
}
