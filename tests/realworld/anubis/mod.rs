use std::{fs, io::Cursor, path::Path};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast2js::V8Options;

use super::support;

const PRELUDE: &str = r#"
let instance;
__wastRegisterImport("anubis", {
    anubis_update_nonce(_nonce) {},
});
"#;

const POSTLUDE: &str = r#"
instance = __wastGetInstance(null);
const input = new Uint8Array(instance.exports.memory.buffer, instance.exports.data_ptr(), 16);
input.set([0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
           0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff]);
instance.exports.set_data_length(input.length);

const difficulty = 4;
const nonce = instance.exports.anubis_work(difficulty, 0, 1);
const result = new Uint8Array(
    instance.exports.memory.buffer,
    instance.exports.result_hash_ptr(),
    instance.exports.result_hash_size(),
);
const hash = Array.from(result);
const verification = new Uint8Array(
    instance.exports.memory.buffer,
    instance.exports.verification_hash_ptr(),
    instance.exports.verification_hash_size(),
);
verification.set(hash);
const valid = instance.exports.anubis_validate(nonce, difficulty);
const hex = hash.map((byte) => byte.toString(16).padStart(2, "0")).join("");
__stdout = `${nonce}:${hex}:${valid}`;
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

fn v8_test(wasm_path: &Path) -> Result<()> {
    let options = V8Options {
        prelude: PRELUDE.to_owned(),
        postlude: POSTLUDE.to_owned(),
        ..Default::default()
    };
    let original = fs::read(wasm_path)
        .with_context(|| format!("failed to read Anubis fixture {wasm_path:?}"))?;
    let original_output = support::run_wast2js_v8_module(&original, &options)
        .with_context(|| format!("V8 failed running original Anubis module {wasm_path:?}"))?;

    let transformed = transform_module(&original)?;
    let transformed_output = support::run_wast2js_v8_module(&transformed, &options)
        .with_context(|| format!("V8 failed running transformed Anubis module {wasm_path:?}"))?;

    ensure!(
        original_output.stdout == transformed_output.stdout,
        "output mismatch for {wasm_path:?}\noriginal: {}\ntransformed: {}",
        original_output.stdout,
        transformed_output.stdout,
    );
    ensure!(
        original_output.stderr == transformed_output.stderr,
        "stderr mismatch for {wasm_path:?}\noriginal: {}\ntransformed: {}",
        original_output.stderr,
        transformed_output.stderr,
    );

    Ok(())
}

pub fn trials() -> Result<Vec<Trial>> {
    let this_dir = Path::new(file!())
        .parent()
        .context("Anubis test module has no parent directory")?;
    let variants = ["baseline", "simd128"];
    let algorithms = ["argon2id", "hashx", "sha256"];

    Ok(variants
        .into_iter()
        .flat_map(|variant| {
            algorithms.into_iter().map(move |algorithm| {
                let wasm_path = this_dir.join(format!("{algorithm}-{variant}.wasm"));
                Trial::test(format!("anubis/{variant}/{algorithm}"), move || {
                    v8_test(&wasm_path).map_err(|err| Failed::from(format!("{err:#}")))
                })
            })
        })
        .collect())
}
