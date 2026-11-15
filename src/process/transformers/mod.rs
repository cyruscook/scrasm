use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;

pub mod call_graph;
pub mod data_encryption_init;
pub mod dump;
pub mod function_index_remap;
pub mod string_encryption;
pub mod strip_debug;
pub mod transformer;

pub use {
    call_graph::{CallGraphConfig, CallGraphDiagnostic, CallGraphReport},
    data_encryption_init::{
        DataEncryptionInitConfig, DataEncryptionInitDiagnostic, DataEncryptionInitReport,
    },
    dump::{DumpConfig, DumpDiagnostic, DumpReport},
    function_index_remap::{
        FunctionIndexRemapConfig, FunctionIndexRemapDiagnostic, FunctionIndexRemapReport,
    },
    string_encryption::{
        StringEncryptionConfig, StringEncryptionDiagnostic, StringEncryptionReport,
    },
    strip_debug::{StripDebugConfig, StripDebugDiagnostic, StripDebugReport},
};

#[derive(Clone, Default, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct TransformersConfig {
    pub call_graph: CallGraphConfig,
    pub data_encryption_init: DataEncryptionInitConfig,
    pub dump: DumpConfig,
    pub function_index_remap: FunctionIndexRemapConfig,
    pub string_encryption: StringEncryptionConfig,
    pub strip_debug: StripDebugConfig,
}

pub fn get_all_transformers(config: &TransformersConfig) -> Vec<Box<dyn transformer::Transformer>> {
    vec![
        Box::new(dump::Dump {
            config: config.dump,
        }),
        Box::new(data_encryption_init::DataEncryptionInit {
            config: config.data_encryption_init,
        }),
        Box::new(strip_debug::StripDebug {
            config: config.strip_debug,
        }),
        Box::new(string_encryption::StringEncryption {
            config: config.string_encryption.clone(),
        }),
        Box::new(call_graph::CallGraph {
            config: config.call_graph,
        }),
        Box::new(function_index_remap::FunctionIndexRemap {
            config: config.function_index_remap,
        }),
        Box::new(dump::Dump {
            config: config.dump,
        }),
    ]
}
