use std::{
    fs,
    path::{Path, PathBuf},
    process::Command,
    time::{SystemTime, UNIX_EPOCH},
};

use anyhow::Context;
use serde_json::Value;

fn temp_test_dir(name: &str) -> anyhow::Result<PathBuf> {
    let unique = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .context("system clock is before UNIX_EPOCH")?
        .as_nanos();
    let path = std::env::temp_dir().join(format!("scrasm-{name}-{unique}"));
    fs::create_dir_all(&path)
        .with_context(|| format!("failed to create temp dir {}", path.display()))?;
    Ok(path)
}

fn wat_to_module(src: &str) -> anyhow::Result<Vec<u8>> {
    let mut lexer = wast::lexer::Lexer::new(src);
    lexer.allow_confusing_unicode(true);
    let buffer = wast::parser::ParseBuffer::new_with_lexer(lexer)?;
    let mut wat = wast::parser::parse::<wast::Wat<'_>>(&buffer)?;
    wat.encode().map_err(Into::into)
}

fn run_scrasm(args: &[&str]) -> anyhow::Result<std::process::Output> {
    Command::new(env!("CARGO_BIN_EXE_scrasm"))
        .args(args)
        .output()
        .context("failed to run scrasm binary")
}

fn run_scrasm_json_schema(args: &[&str]) -> anyhow::Result<std::process::Output> {
    Command::new(env!("CARGO_BIN_EXE_schema-gen"))
        .args(args)
        .output()
        .context("failed to run schema-gen binary")
}

fn read_json(path: &Path) -> anyhow::Result<Value> {
    let bytes =
        fs::read(path).with_context(|| format!("failed to read JSON file {}", path.display()))?;
    serde_json::from_slice(&bytes)
        .with_context(|| format!("failed to parse JSON file {}", path.display()))
}

#[test]
fn emits_config_schema() -> anyhow::Result<()> {
    let output = run_scrasm_json_schema(&["config"])?;
    anyhow::ensure!(
        output.status.success(),
        "scrasm exited with status {:?}",
        output.status.code()
    );

    let schema: Value = serde_json::from_slice(&output.stdout).context("invalid schema JSON")?;
    let schema_text = schema.to_string();
    anyhow::ensure!(
        schema_text.contains("ScrasmConfig"),
        "config schema did not include ScrasmConfig title"
    );
    anyhow::ensure!(
        schema_text.contains("StringEncryptionConfig"),
        "config schema did not include nested transformer config definitions"
    );

    Ok(())
}

#[test]
fn emits_output_schema() -> anyhow::Result<()> {
    let output = run_scrasm_json_schema(&["output"])?;
    anyhow::ensure!(
        output.status.success(),
        "scrasm exited with status {:?}",
        output.status.code()
    );

    let schema: Value = serde_json::from_slice(&output.stdout).context("invalid schema JSON")?;
    let schema_text = schema.to_string();
    anyhow::ensure!(
        schema_text.contains("ScrasmJsonOutput"),
        "output schema did not include ScrasmJsonOutput title"
    );
    anyhow::ensure!(
        schema_text.contains("TransformerReport"),
        "output schema did not include transformer report definitions"
    );

    Ok(())
}

#[test]
fn processes_module_with_json_config_and_result_output() -> anyhow::Result<()> {
    let dir = temp_test_dir("json-cli")?;
    let input_path = dir.join("input.wasm");
    let output_path = dir.join("output.wasm");
    let config_path = dir.join("config.json");
    let result_path = dir.join("result.json");

    let module = wat_to_module("(module)")?;
    fs::write(&input_path, module)
        .with_context(|| format!("failed to write {}", input_path.display()))?;
    fs::write(
        &config_path,
        serde_json::to_vec_pretty(&serde_json::json!({
            "force_visit": true,
            "capabilities": {
                "minimum_required_support": "Legacy"
            },
            "transformers": {
                "call_graph": {
                    "enabled": false,
                    "seed": null
                },
                "data_encryption_init": {
                    "enabled": false,
                    "seed": null
                },
                "dump": {
                    "enabled": false,
                    "include_raw": true
                },
                "string_encryption": {
                    "enabled": false,
                    "seed": null,
                    "imported_js_string_namespace": "string_constants"
                },
                "strip_debug": {
                    "enabled": false,
                    "strip_branch_hints": false
                }
            }
        }))?,
    )
    .with_context(|| format!("failed to write {}", config_path.display()))?;

    let output = run_scrasm(&[
        "--input-file",
        input_path
            .to_str()
            .context("input path was not valid UTF-8")?,
        "--output-file",
        output_path
            .to_str()
            .context("output path was not valid UTF-8")?,
        "--config-json",
        config_path
            .to_str()
            .context("config path was not valid UTF-8")?,
        "--result-json",
        result_path
            .to_str()
            .context("result path was not valid UTF-8")?,
    ])?;
    anyhow::ensure!(
        output.status.success(),
        "scrasm exited with status {:?}: {}",
        output.status.code(),
        String::from_utf8_lossy(&output.stderr)
    );

    let result_json = read_json(&result_path)?;
    anyhow::ensure!(
        result_json.get("reports").is_some(),
        "result JSON did not contain reports"
    );
    anyhow::ensure!(
        result_json.pointer("/reports/strip_debug/0/StripDebug/diagnostics/0")
            == Some(&Value::String("Disabled".to_owned())),
        "strip_debug report did not contain the expected disabled diagnostic"
    );
    anyhow::ensure!(
        fs::metadata(&output_path).is_ok(),
        "output wasm file was not written"
    );

    fs::remove_dir_all(&dir)
        .with_context(|| format!("failed to remove temp dir {}", dir.display()))?;
    Ok(())
}
