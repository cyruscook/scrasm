use std::io::Cursor;

use anyhow::{Context, bail};
use scrasm::{ScrasmConfig, ScrasmJsonOutput};
use wasm_bindgen::prelude::*;
use wasmparser::{Validator, WasmFeatures};

#[wasm_bindgen]
pub struct ObfuscationResult {
    bytes: Vec<u8>,
    report: String,
}

#[wasm_bindgen]
impl ObfuscationResult {
    #[wasm_bindgen(getter)]
    pub fn bytes(&self) -> Vec<u8> {
        self.bytes.clone()
    }

    #[wasm_bindgen(getter)]
    pub fn report(&self) -> String {
        self.report.clone()
    }
}

#[wasm_bindgen]
pub fn version() -> String {
    env!("CARGO_PKG_VERSION").to_owned()
}

#[wasm_bindgen]
pub fn default_config() -> Result<String, String> {
    serde_json::to_string_pretty(&ScrasmConfig::default()).map_err(|error| error.to_string())
}

#[wasm_bindgen]
pub fn config_schema() -> Result<String, String> {
    serde_json::to_string(&scrasm::config_json_schema()).map_err(|error| error.to_string())
}

#[wasm_bindgen]
pub fn output_schema() -> Result<String, String> {
    serde_json::to_string(&scrasm::output_json_schema()).map_err(|error| error.to_string())
}

#[wasm_bindgen]
pub fn obfuscate(input: &[u8], config_json: &str) -> Result<ObfuscationResult, String> {
    process(input, config_json).map_err(|error| format!("{error:#}"))
}

fn process(input: &[u8], config_json: &str) -> anyhow::Result<ObfuscationResult> {
    let mut deserializer = serde_json::Deserializer::from_str(config_json);
    let mut unknown_fields = Vec::new();
    let config: ScrasmConfig = serde_ignored::deserialize(&mut deserializer, |path| {
        unknown_fields.push(path.to_string());
    })
    .context("Invalid Scrasm configuration")?;
    deserializer.end().context("Invalid Scrasm configuration")?;
    if !unknown_fields.is_empty() {
        bail!(
            "Unknown configuration fields: {}",
            unknown_fields.join(", ")
        );
    }
    if input.get(..8) != Some(b"\0asm\x01\0\0\0") {
        bail!("Choose a WebAssembly core module (.wasm), with a valid binary header");
    }
    // The host browser may lack a feature present in a module intended for another runtime.
    Validator::new_with_features(WasmFeatures::all())
        .validate_all(input)
        .context("The input module is not valid WebAssembly")?;
    let mut output = Cursor::new(Vec::new());
    let reports = scrasm::with_config(config)
        .scrasm_with_reports(Cursor::new(input), &mut output)
        .context("Scrasm could not process this module")?;
    let bytes = output.into_inner();
    Validator::new_with_features(WasmFeatures::all())
        .validate_all(&bytes)
        .context("Scrasm produced an invalid module; no output was returned")?;
    let report = serde_json::to_string(&ScrasmJsonOutput { reports })?;
    Ok(ObfuscationResult { bytes, report })
}

#[cfg(test)]
mod tests;
