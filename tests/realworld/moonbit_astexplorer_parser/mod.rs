use std::{fs, io::Cursor, path::Path};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast2js::{V8Global, V8Options};

use super::support;

const PRELUDE: &str = r#"__wastRegisterImport("_", {});"#;
const POSTLUDE: &str = r#"
let instance = __wastGetInstance(null);
let source = "";
for (let i = 0; i < __mbt.length; i++) {
    source += String.fromCharCode(__mbt[i]);
}
__stdout = __stdout + instance.exports.parse(source, "handparser");
__stdout = __stdout + instance.exports.parse(source, "lexer");
__stdout = __stdout + instance.exports.parse(source, "yaccparser");
"#;

fn transform_module(src: &[u8]) -> Result<Vec<u8>> {
    let mut output = Vec::new();

    let transformers = TransformersConfig::default();
    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(Cursor::new(&src), Cursor::new(&mut output))?;

    Ok(output)
}

fn v8_test(orig_wasm_path: &Path, mbt_path: &Path) -> Result<()> {
    let mbt_src = fs::read(mbt_path).context("mbt path not exist")?;
    let options = V8Options {
        prelude: PRELUDE.to_owned(),
        globals: vec![V8Global::Blob {
            name: "__mbt".to_owned(),
            bytes: mbt_src,
        }],
        compile_hook: Some(
            "(bytes) => new WebAssembly.Module(bytes, { builtins: [\"js-string\"], importedStringConstants: \"_\" })"
                .into(),
        ),
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
    let mbtpath = thisdir.join("mandelbrot.mbt");
    let wasmpath = thisdir.join("moonbit_astexplorer_parser.wasm");
    Ok(vec![Trial::test("moonbit_astexplorer_parser", move || {
        (|| -> Result<()> {
            v8_test(&wasmpath, &mbtpath).context("v8 test failed")?;
            Ok(())
        })()
        .map_err(|err| Failed::from(format!("{err:#}")))
    })])
}
