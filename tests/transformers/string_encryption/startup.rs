use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use wast2js::V8Options;

use super::{IMPORTED_STRING_NAMESPACE, PROTECTED_STRINGS, encode_wat, transform_module};

const MODULE_SRC: &str = r#"
(module
  (global $first (import "string_constants" "scrasm secret alpha") (ref extern))
  (global $second (import "string_constants" "emoji globe ☃ 🌍") (ref extern))
  (func $record (import "host" "record") (param (ref extern) (ref extern)))

  (func $init
    (call $record (global.get $first) (global.get $second))
  )
  (start $init)
)
"#;

fn check_startup(module: &[u8]) -> Result<()> {
    let output = super::super::support::run_wast2js_v8_module(
        module,
        &V8Options {
            prelude: format!(
                r#"
const startupCalls = [];
__wastRegisterImport({IMPORTED_STRING_NAMESPACE:?}, {{}});
__wastRegisterImport("host", {{ record: (...values) => startupCalls.push(values) }});
"#
            ),
            compile_hook: Some(format!(
                "(bytes) => new WebAssembly.Module(bytes, {{ builtins: [\"js-string\"], importedStringConstants: {IMPORTED_STRING_NAMESPACE:?} }})"
            )),
            postlude: format!(
                r#"
const expected = {PROTECTED_STRINGS:?};
if (startupCalls.length !== 1) {{
  throw new Error(`expected one startup call, got ${{startupCalls.length}}`);
}}
for (const [index, value] of expected.entries()) {{
  if (startupCalls[0][index] !== value) {{
    throw new Error(`startup string ${{index}} was ${{JSON.stringify(startupCalls[0][index])}}, expected ${{JSON.stringify(value)}}`);
  }}
}}
"#
            ),
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
        "string_encryption_initializes_strings_before_start_v8",
        || {
            (|| -> Result<()> {
                let original = encode_wat(MODULE_SRC)?;
                check_startup(&original).context("original startup fixture failed")?;

                let transformed =
                    transform_module(MODULE_SRC).context("failed to transform startup fixture")?;
                wasmparser::Validator::new()
                    .validate_all(&transformed)
                    .context("wasmparser rejected the transformed startup module")?;
                check_startup(&transformed).context("transformed startup fixture failed")
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        },
    )
}
