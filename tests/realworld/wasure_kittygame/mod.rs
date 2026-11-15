// Sourced from r-carissimi/wasure at b3485bf4a3728a9f7df33eb466fced8bae19d25f:
// https://raw.githubusercontent.com/r-carissimi/wasure/b3485bf4a3728a9f7df33eb466fced8bae19d25f/wasure/benchmarks/wasm-r3/kittygame.wasm
use std::{fs, io::Cursor, path::Path};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast2js::V8Options;

use super::support;

const EXPECTED_FRAMES: &str = "8c8f007d:e69d6289:2df9e947";
const POSTLUDE: &str = r#"
const instance = __wastGetInstance(null);
instance.exports._start();
const hashes = [];
for (let frame = 0; frame < 3; frame++) {
    instance.exports.update();
    let hash = 0x811c9dc5;
    const memory = new Uint8Array(instance.exports.memory.buffer);
    for (const byte of memory) {
        hash ^= byte;
        hash = Math.imul(hash, 0x01000193) >>> 0;
    }
    hashes.push(hash.toString(16).padStart(8, "0"));
}
__stdout = hashes.join(":");
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
        .with_context(|| format!("failed to read WASURE kittygame fixture {wasm_path:?}"))?;
    let original_output = run_module(&original)
        .with_context(|| format!("V8 failed running original module {wasm_path:?}"))?;
    ensure!(
        original_output.stdout.trim() == EXPECTED_FRAMES,
        "unexpected original frame hashes: {}",
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
        transformed_output.stdout.trim() == EXPECTED_FRAMES,
        "unexpected transformed frame hashes: {}",
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
        .context("kittygame test module has no parent directory")?;
    let wasm_path = this_dir.join("kittygame.wasm");

    Ok(vec![Trial::test("wasure_kittygame", move || {
        v8_test(&wasm_path).map_err(|err| Failed::from(format!("{err:#}")))
    })])
}
