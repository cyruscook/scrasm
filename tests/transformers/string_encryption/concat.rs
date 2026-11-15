use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use wast2js::V8Options;

use super::{
    IMPORTED_STRING_NAMESPACE, contains_subsequence, encode_wat, transform_module, utf16le_bytes,
};

const MODULE_SRC: &str = r#"
(module
  (global $hello (import "string_constants" "hello ") externref)
  (global $world (import "string_constants" "world!") externref)
  (func $concat (import "wasm:js-string" "concat")
    (param externref externref) (result (ref extern)))
  (func $log (import "m" "log") (param externref))

  (func (export "main")
    (call $log (call $concat (global.get $hello) (global.get $world)))
  )
)
"#;

fn check_host_calls(module: &[u8]) -> Result<()> {
    let output = super::super::support::run_wast2js_v8_module(
        module,
        &V8Options {
            prelude: format!(
                r#"
const logged = [];
__wastRegisterImport({IMPORTED_STRING_NAMESPACE:?}, {{}});
__wastRegisterImport("m", {{ log: (value) => logged.push(value) }});
"#
            ),
            compile_hook: Some(format!(
                "(bytes) => new WebAssembly.Module(bytes, {{ builtins: [\"js-string\"], importedStringConstants: {IMPORTED_STRING_NAMESPACE:?} }})"
            )),
            postlude: r#"
if (logged.length !== 0) {
  throw new Error("module called m.log before main");
}
__wastGetInstance(null).exports.main();
if (logged.length !== 1 || logged[0] !== "hello world!") {
  throw new Error(`expected one m.log call with "hello world!", got ${JSON.stringify(logged)}`);
}
"#
            .to_owned(),
            ..Default::default()
        },
    )?;
    ensure!(
        output.stdout.is_empty(),
        "unexpected stdout: {}",
        output.stdout
    );
    ensure!(
        output.stderr.is_empty(),
        "unexpected stderr: {}",
        output.stderr
    );
    Ok(())
}

pub(super) fn trial() -> Trial {
    Trial::test(
        "string_encryption_preserves_concat_and_host_calls_v8",
        || {
            (|| -> Result<()> {
                let original = encode_wat(MODULE_SRC)?;
                check_host_calls(&original).context("original concat fixture failed")?;

                let transformed =
                    transform_module(MODULE_SRC).context("failed to transform concat fixture")?;
                wasmparser::Validator::new()
                    .validate_all(&transformed)
                    .context("wasmparser rejected the transformed concat module")?;
                ensure!(
                    !contains_subsequence(&transformed, IMPORTED_STRING_NAMESPACE.as_bytes()),
                    "transformed module still contains the protected import namespace"
                );
                for protected in ["hello ", "world!"] {
                    ensure!(
                        !contains_subsequence(&transformed, protected.as_bytes())
                            && !contains_subsequence(&transformed, &utf16le_bytes(protected)),
                        "transformed module still contains plaintext for {protected:?}"
                    );
                }
                check_host_calls(&transformed).context("transformed concat fixture failed")
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        },
    )
}
