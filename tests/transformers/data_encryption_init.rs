use std::io::Cursor;

use anyhow::{Result, ensure};
use libtest_mimic::{Failed, Trial};
use scrasm::{
    DataEncryptionInitDiagnostic, MinimumRequiredSupport, ScrasmConfig, TransformerReport,
    TransformersConfig,
};

fn transform_reports_with_support(
    src: &str,
    minimum_required_support: MinimumRequiredSupport,
) -> Result<Vec<TransformerReport>> {
    let mut input = super::wat_to_module(src)?;
    let mut output = Vec::new();

    let mut transformers = TransformersConfig::default();
    transformers.dump.enabled = false;
    transformers.data_encryption_init.enabled = true;
    transformers.data_encryption_init.seed = Some([0x5a; 32]);
    transformers.string_encryption.enabled = false;
    transformers.call_graph.enabled = false;
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
        .get("data_encryption_init")
        .cloned()
        .unwrap_or_default())
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(vec![Trial::test(
        "data_encryption_init_skips_when_bulk_memory_capability_is_missing",
        || {
            (|| -> Result<()> {
                let reports = transform_reports_with_support(
                    r#"
(module
  (memory 1)
  (data (i32.const 0) "secret")
)
"#,
                    MinimumRequiredSupport::Legacy,
                )?;

                ensure!(
                    reports.len() == 1,
                    "expected one data_encryption_init report"
                );
                let Some(TransformerReport::DataEncryptionInit(report)) = reports.first() else {
                    return Err(anyhow::anyhow!("missing data_encryption_init report"));
                };
                ensure!(
                    report.diagnostics
                        == [DataEncryptionInitDiagnostic::UnsupportedCapabilities {
                            capabilities: vec!["bulk_memory".to_owned()],
                        }],
                    "expected unsupported-capabilities diagnostic, got {:?}",
                    report.diagnostics
                );

                Ok(())
            })()
            .map_err(|err| Failed::from(format!("{err:#}")))
        },
    )])
}
