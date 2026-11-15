// Sourced from r-carissimi/wasure at b3485bf4a3728a9f7df33eb466fced8bae19d25f:
// https://raw.githubusercontent.com/r-carissimi/wasure/b3485bf4a3728a9f7df33eb466fced8bae19d25f/wasure/benchmarks/wasm-features/threads.wasm
use std::{fs, io::Cursor, path::Path};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast2js::V8Options;

use super::support;

const POSTLUDE: &str = r#"
const instance = __wastGetInstance(null);
instance.exports._start();
"#;

fn transform_module(src: &[u8]) -> Result<Vec<u8>> {
    let mut output = Vec::new();
    let transformers = TransformersConfig::default();

    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(Cursor::new(src), Cursor::new(&mut output))?;

    Ok(output)
}

fn run_module(module: &[u8]) -> Result<support::JsRunOutput> {
    support::run_wast2js_v8_module(
        module,
        &V8Options {
            postlude: POSTLUDE.to_owned(),
            ..Default::default()
        },
    )
}

fn v8_test(wasm_path: &Path) -> Result<()> {
    let original = fs::read(wasm_path)
        .with_context(|| format!("failed to read WASURE threads fixture {wasm_path:?}"))?;
    let original_output = run_module(&original)
        .with_context(|| format!("V8 failed running original module {wasm_path:?}"))?;
    ensure!(
        original_output.stdout.trim().is_empty(),
        "original module wrote to stdout: {}",
        original_output.stdout
    );
    ensure!(
        original_output.stderr.trim().is_empty(),
        "original module wrote to stderr: {}",
        original_output.stderr
    );

    let transformed = transform_module(&original)?;
    let transformed_output = run_module(&transformed)
        .with_context(|| format!("V8 failed running transformed module from {wasm_path:?}"))?;
    ensure!(
        transformed_output.stdout.trim().is_empty(),
        "transformed module wrote to stdout: {}",
        transformed_output.stdout
    );
    ensure!(
        transformed_output.stderr.trim().is_empty(),
        "transformed module wrote to stderr: {}",
        transformed_output.stderr
    );

    Ok(())
}

pub fn trials() -> Result<Vec<Trial>> {
    let this_dir = Path::new(file!())
        .parent()
        .context("threads test module has no parent directory")?;
    let wasm_path = this_dir.join("threads.wasm");

    Ok(vec![Trial::test("wasure_threads", move || {
        v8_test(&wasm_path).map_err(|err| Failed::from(format!("{err:#}")))
    })])
}
