use std::{
    fs,
    fs::read_dir,
    io::Cursor,
    path::{Path, PathBuf},
};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};

#[path = "../support/mod.rs"]
mod support;

const IGNORED_TESTS: [&str; 3] = ["kb", "kb_no_exc", "soli"];

const HARNESS: &str = r#"
let str_buff = "";

function print_i32(arg) {
    str_buff = str_buff + arg.toString();
};

function print_f64(arg) {
    __stdout = __stdout + String(arg);
};

function print_endline() {
    __stdout = __stdout + str_buff;
    str_buff = "";
}

function putchar(i_char) {
    let char = String.fromCharCode(i_char);
    str_buff = str_buff + char;
    // flush(); // TODO: remove this
};

function flush() {
    __stdout = __stdout + str_buff;
    str_buff = "";
}

const bindings = {
    "print_i32": print_i32,
    "print_f64": print_f64,
    "print_endline": print_endline,
    "putchar": putchar,
    "flush": flush,
    "atan2": Math.atan2,
    "sin": Math.sin,
    "asin": Math.asin,
    "fmod": (x, y) => x % y,
    "cos": Math.cos,
}

const imports = {
    "js_runtime" : bindings
}

new WebAssembly.Instance(new WebAssembly.Module(__wasm_bytes), imports);
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

fn v8_test(orig_wasm_path: &Path) -> Result<()> {
    // Run original WASM to get expected output
    let orig_wasm = fs::read(orig_wasm_path)?;
    let orig_output = support::run_wasm_script(&orig_wasm, HARNESS, &[])
        .with_context(|| format!("v8 harness failed running original {orig_wasm_path:?}"))?;

    let obf_wasm = transform_module(&orig_wasm)?;
    let obf_output = support::run_wasm_script(&obf_wasm, HARNESS, &[]).with_context(|| {
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

fn testfiles() -> Result<Vec<(String, PathBuf)>> {
    let thisdir = Path::new(file!()).parent().unwrap();
    let path = thisdir.join("tests");
    let mut test_files = Vec::new();

    for file in read_dir(&path).with_context(|| format!("Failed to read tests from {:?}", path))? {
        let path = file?.path();
        if path.extension().is_none_or(|ext| ext != "wasm") {
            continue;
        }
        let test_name = path.file_stem().unwrap().to_str().unwrap().to_string();
        test_files.push((test_name, path));
    }

    Ok(test_files)
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(testfiles()?
        .iter()
        .map(|(name, path)| {
            let ignored = IGNORED_TESTS.iter().any(|ignored| name == *ignored);
            let path = path.clone();
            Trial::test(format!("v8_runtime_roundtrip_{name}",), move || {
                (|| -> Result<()> {
                    v8_test(&path).context("v8 test failed")?;

                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            })
            .with_ignored_flag(ignored)
        })
        .collect())
}

fn main() -> anyhow::Result<()> {
    let mut args = libtest_mimic::Arguments::from_args();
    // Default to terse output as we have *a lot* of tests.
    if args.format.is_none() {
        args.format = Some(libtest_mimic::FormatSetting::Terse);
    }

    libtest_mimic::run(&args, trials()?).exit()
}
