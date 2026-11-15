use std::{
    fs::File,
    io::{Cursor, Read, Seek},
    path::Path,
};

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{ScrasmConfig, TransformersConfig};

fn transform_module<R: Read + Seek>(input: R) -> Result<Vec<u8>> {
    let mut output = Vec::new();

    let transformers = TransformersConfig::default();
    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(input, Cursor::new(&mut output))?;

    Ok(output)
}

pub fn trials() -> Result<Trial> {
    let name = "hyperquark-951679565";
    let thisdir = Path::new(file!()).parent().unwrap();
    let wasmpath = thisdir.join(name).with_added_extension("wasm");
    ensure!(
        wasmpath.exists(),
        "test fixture {name}.wasm not found at expected path",
    );
    let module_src = File::open(wasmpath)?;
    Ok(Trial::test("hyperquark", move || {
        (|| -> Result<()> {
            let transformed = transform_module(module_src)
                .context("failed to transform string-encryption fixture")?;
            wasmparser::Validator::new()
                .validate_all(&transformed)
                .context("wasmparser rejected the transformed module")?;
            Ok(())
        })()
        .map_err(|err| Failed::from(format!("{err:#}")))
    }))
}
