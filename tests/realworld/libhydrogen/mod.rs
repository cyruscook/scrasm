use std::{fs, io::Cursor, path::Path};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast2js::V8Options;

use super::support;

const PRELUDE: &str = r#"
let instance;
let rngState = 0x243f6a88;

function nextRandomByte() {
    rngState ^= (rngState << 13) >>> 0;
    rngState ^= rngState >>> 17;
    rngState ^= (rngState << 5) >>> 0;
    rngState >>>= 0;
    return rngState & 0xff;
}

function readString(ptr, len) {
    const view = new Uint8Array(instance.exports.memory.buffer, ptr, len);
    let out = "";
    for (let i = 0; i < view.length; i++) {
        out += String.fromCharCode(view[i]);
    }
    return out;
}

__wastRegisterImport("env", {
    hydro_random_fill(ptr, len) {
        const view = new Uint8Array(instance.exports.memory.buffer, ptr, len);
        for (let i = 0; i < len; i++) {
            view[i] = nextRandomByte();
        }
        return 0;
    },
    hydro_console_log(ptr, len) {
        __stderr = __stderr + readString(ptr, len);
    },
    hydro_assert_fail(exprPtr, exprLen, filePtr, fileLen, line) {
        const expr = readString(exprPtr, exprLen);
        const file = readString(filePtr, fileLen);
        __stderr = __stderr + `Assertion failed at ${file}:${line}: ${expr}\n`;
    },
});
"#;

const POSTLUDE: &str = r#"
instance = __wastGetInstance(null);
const rc = instance.exports.main(0, 0);
if (rc !== 0) {
    throw new Error(`WASM tests returned ${rc}`);
}
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

fn v8_test(orig_wasm_path: &Path) -> Result<()> {
    let options = V8Options {
        prelude: PRELUDE.to_owned(),
        postlude: POSTLUDE.to_owned(),
        ..Default::default()
    };

    let orig_wasm = fs::read(orig_wasm_path)?;
    let orig_output = support::run_wast2js_v8_module(&orig_wasm, &options)
        .with_context(|| format!("v8 harness failed running original {orig_wasm_path:?}"))?;

    let obf_wasm = transform_module(&orig_wasm)?;
    let obf_output = support::run_wast2js_v8_module(&obf_wasm, &options).with_context(|| {
        format!("v8 harness failed running obfuscated module derived from {orig_wasm_path:?}")
    })?;

    ensure!(
        orig_output.stdout.trim() == obf_output.stdout.trim(),
        "stdout mismatch between original and obfuscated module\noriginal stdout:\n{}\nobfuscated stdout:\n{}",
        orig_output.stdout,
        obf_output.stdout
    );

    ensure!(
        orig_output.stderr.trim() == obf_output.stderr.trim(),
        "stderr mismatch between original and obfuscated module\noriginal stderr:\n{}\nobfuscated stderr:\n{}",
        orig_output.stderr,
        obf_output.stderr
    );

    Ok(())
}

pub fn trials() -> Result<Vec<Trial>> {
    let thisdir = Path::new(file!()).parent().unwrap();
    let wasmpath = thisdir.join("tests.wasm");
    Ok(vec![Trial::test("libhydrogen", move || {
        (|| -> Result<()> {
            v8_test(&wasmpath).context("v8 test failed")?;
            Ok(())
        })()
        .map_err(|err| Failed::from(format!("{err:#}")))
    })])
}
