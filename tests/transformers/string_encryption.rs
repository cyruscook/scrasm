use std::io::Cursor;

use anyhow::{Context, Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{
    MinimumRequiredSupport, ScrasmConfig, StringEncryptionDiagnostic, TransformerReport,
    TransformersConfig,
};
use wast2js::V8Options;

mod concat;
mod startup;

const IMPORTED_STRING_NAMESPACE: &str = "string_constants";
const PROTECTED_STRINGS: [&str; 2] = ["scrasm secret alpha", "emoji globe \u{2603} \u{1f30d}"];
const START_SENTINEL: i32 = 7;
const STRING_ENCRYPTION_SEED: [u8; 32] = [
    0x10, 0x32, 0x54, 0x76, 0x98, 0xba, 0xdc, 0xfe, 0x11, 0x33, 0x55, 0x77, 0x99, 0xbb, 0xdd, 0xff,
    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0,
];

const MODULE_SRC: &str = r#"
(module
  (global $first (import "string_constants" "scrasm secret alpha") (ref extern))
  (global $second (import "string_constants" "emoji globe ☃ 🌍") (ref extern))
  (global $started (mut i32) (i32.const 0))

  (func $init
    (global.set $started (i32.const 7))
  )
  (start $init)

  (func (export "first") (result (ref extern))
    (global.get $first)
  )
  (func (export "second") (result (ref extern))
    (global.get $second)
  )
  (func (export "started") (result i32)
    (global.get $started)
  )
)
"#;

fn encode_wat(src: &str) -> Result<Vec<u8>> {
    let enhance_error = |mut err: wast::Error| {
        err.set_text(src);
        err
    };

    let mut lexer = wast::lexer::Lexer::new(src);
    lexer.allow_confusing_unicode(true);
    let buffer = wast::parser::ParseBuffer::new_with_lexer(lexer).map_err(enhance_error)?;
    let mut wat = wast::parser::parse::<wast::Wat<'_>>(&buffer).map_err(enhance_error)?;
    wat.encode().map_err(Into::into)
}

fn transform_module(src: &str) -> Result<Vec<u8>> {
    let mut input = encode_wat(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = true;
    transformers.string_encryption.seed = Some(STRING_ENCRYPTION_SEED);
    transformers.string_encryption.imported_js_string_namespace =
        Some(IMPORTED_STRING_NAMESPACE.to_owned());
    transformers.function_index_remap.enabled = false;

    scrasm::with_config(ScrasmConfig {
        transformers,
        ..Default::default()
    })
    .scrasm(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(output)
}

fn transform_reports_with_support(
    src: &str,
    minimum_required_support: MinimumRequiredSupport,
) -> Result<Vec<TransformerReport>> {
    let mut input = encode_wat(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = false;
    transformers.string_encryption.enabled = true;
    transformers.string_encryption.seed = Some(STRING_ENCRYPTION_SEED);
    transformers.string_encryption.imported_js_string_namespace =
        Some(IMPORTED_STRING_NAMESPACE.to_owned());
    transformers.function_index_remap.enabled = false;

    let reports = scrasm::with_config(ScrasmConfig {
        capabilities: scrasm::CapabilitiesConfig {
            minimum_required_support,
        },
        transformers,
        ..Default::default()
    })
    .scrasm_with_reports(Cursor::new(&mut input), Cursor::new(&mut output))?;

    Ok(reports
        .get("string_encryption")
        .cloned()
        .unwrap_or_default())
}

fn contains_subsequence(haystack: &[u8], needle: &[u8]) -> bool {
    !needle.is_empty()
        && haystack
            .windows(needle.len())
            .any(|window| window == needle)
}

fn utf16le_bytes(input: &str) -> Vec<u8> {
    input
        .encode_utf16()
        .flat_map(|code_unit| code_unit.to_le_bytes())
        .collect()
}

fn run_v8_runtime_check(module: &[u8]) -> Result<()> {
    let output = super::support::run_wast2js_v8_module(
        module,
        &V8Options {
            prelude: format!(r#"__wastRegisterImport({IMPORTED_STRING_NAMESPACE:?}, {{}});"#),
            compile_hook: Some(format!(
                "(bytes) => new WebAssembly.Module(bytes, {{ builtins: [\"js-string\"], importedStringConstants: {:?} }})",
                IMPORTED_STRING_NAMESPACE
            )),
            postlude: format!(
                r#"
const instance = __wastGetInstance(null);
const expected = {expected_strings:?};

for (const [exportName, expectedValue] of [["first", expected[0]], ["second", expected[1]]]) {{
  const actualValue = instance.exports[exportName]();
  if (typeof actualValue !== "string") {{
    throw new Error(`${{exportName}} returned ${{typeof actualValue}}, expected string`);
  }}
  if (actualValue !== expectedValue) {{
    throw new Error(`${{exportName}} returned ${{JSON.stringify(actualValue)}}, expected ${{JSON.stringify(expectedValue)}}`);
  }}
}}

const started = instance.exports.started();
if (started !== {start_sentinel}) {{
  throw new Error(`started returned ${{started}}, expected {start_sentinel}`);
}}
"#,
                expected_strings = PROTECTED_STRINGS,
                start_sentinel = START_SENTINEL,
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

fn validation_trials() -> Vec<Trial> {
    vec![
        Trial::test(
            "string_encryption_skips_when_required_capabilities_are_missing",
            || {
                (|| -> Result<()> {
                    let reports =
                        transform_reports_with_support(MODULE_SRC, MinimumRequiredSupport::Legacy)?;

                    ensure!(reports.len() == 1, "expected one string_encryption report");
                    let Some(TransformerReport::StringEncryption(report)) = reports.first() else {
                        return Err(anyhow::anyhow!("missing string_encryption report"));
                    };
                    ensure!(
                        report.diagnostics
                            == [StringEncryptionDiagnostic::UnsupportedCapabilities {
                                capabilities: vec![
                                    "bulk_memory".to_owned(),
                                    "gc".to_owned(),
                                    "js_string_builtins".to_owned(),
                                ],
                            }],
                        "expected unsupported-capabilities diagnostic, got {:?}",
                        report.diagnostics
                    );

                    Ok(())
                })()
                .map_err(|err| Failed::from(format!("{err:#}")))
            },
        ),
        Trial::test("string_encryption_validates_output_module", || {
            (|| -> Result<()> {
                let transformed = transform_module(MODULE_SRC)
                    .context("failed to transform string-encryption fixture")?;

                wasmparser::Validator::new()
                    .validate_all(&transformed)
                    .context("wasmparser rejected the transformed module")?;

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        }),
    ]
}

fn plaintext_trials() -> Vec<Trial> {
    vec![Trial::test(
        "string_encryption_removes_plaintext_strings",
        || {
            (|| -> Result<()> {
                let transformed = transform_module(MODULE_SRC)
                    .context("failed to transform string-encryption fixture")?;

                ensure!(
                    !contains_subsequence(&transformed, IMPORTED_STRING_NAMESPACE.as_bytes()),
                    "transformed module still contains the protected import namespace"
                );

                for protected in PROTECTED_STRINGS {
                    ensure!(
                        !contains_subsequence(&transformed, protected.as_bytes()),
                        "transformed module still contains plaintext UTF-8 for {protected:?}"
                    );
                    let utf16 = utf16le_bytes(protected);
                    ensure!(
                        !contains_subsequence(&transformed, &utf16),
                        "transformed module still contains plaintext UTF-16LE for {protected:?}"
                    );
                }

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        },
    )]
}

fn v8_trials() -> Vec<Trial> {
    vec![Trial::test(
        "string_encryption_runtime_roundtrip_v8",
        move || {
            (|| -> Result<()> {
                let transformed = transform_module(MODULE_SRC)
                    .context("failed to transform string-encryption fixture")?;
                run_v8_runtime_check(&transformed)
                    .context("v8 rejected the transformed module or returned wrong values")?;

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        },
    )]
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(validation_trials()
        .into_iter()
        .chain(plaintext_trials())
        .chain(v8_trials())
        .chain(std::iter::once(concat::trial()))
        .chain(std::iter::once(startup::trial()))
        .collect())
}
