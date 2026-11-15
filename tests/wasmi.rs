use std::{fs::read_to_string, path::Path};

use anyhow::Context;
use libtest_mimic::{Failed, Trial};

#[path = "support/mod.rs"]
mod support;

fn run_test(
    init_res: anyhow::Result<()>,
    path: &Path,
    tmp_out_root: &Path,
    src: &str,
    config: &wasmi::Config,
) -> anyhow::Result<()> {
    init_res?;

    let dump_root = tmp_out_root.join(path);
    let parsed = support::wast::parse_wast(path, src)?;
    let transformed = support::wast::transform_script(parsed.directives, &dump_root)?;

    let mut runner = wasmi_wast::WastRunner::new(config);
    runner
        .register_spectest(false)
        .with_context(|| format!("failed to register spectest for path {path:?}"))?;

    for directive in transformed.directives {
        let span = directive.span();
        runner.process_directive(directive).with_context(|| {
            let (line, col) = span.linecol_in(src);
            format!(
                "failed directive for {} at {}:{}:{col}",
                path.to_string_lossy(),
                path.to_string_lossy(),
                line + 1
            )
        })?;
    }

    Ok(())
}

fn wasmi_trials() -> anyhow::Result<Vec<Trial>> {
    let testsuite_root = Path::new("tests").join("testsuite");
    let tmp_out_root = std::env::temp_dir();

    support::wast::testsuite_wast_files(&testsuite_root)?
        .into_iter()
        .map(|path| {
            let tmp_out_root = tmp_out_root.clone();
            let src = read_to_string(&path)
                .with_context(|| format!("Failed to read test from {:?}", path))?;

            let mut config = wasmi::Config::default();
            config.compilation_mode(wasmi::CompilationMode::Eager);
            config.wasm_multi_memory(false);

            let execute = |config: &wasmi::Config, path: &Path, src: &str| {
                let mut runner = wasmi_wast::WastRunner::new(config);
                runner
                    .register_spectest(false)
                    .with_context(|| format!("failed to register spectest for path {path:?}"))?;
                runner.process_directives(&path.to_string_lossy(), src)?;
                Ok::<(), anyhow::Error>(())
            };

            let init_res = execute(&config, &path, &src);
            let test_ignored = init_res.is_err();

            Ok::<Trial, anyhow::Error>(
                Trial::test(path.display().to_string(), move || {
                    run_test(init_res, &path, &tmp_out_root, &src, &config)
                        .map_err(|err| Failed::from(format!("{err:?}")))
                })
                .with_ignored_flag(test_ignored),
            )
        })
        .collect()
}

fn main() -> anyhow::Result<()> {
    let trials = wasmi_trials()?;
    let mut args = libtest_mimic::Arguments::from_args();
    if args.format.is_none() {
        args.format = Some(libtest_mimic::FormatSetting::Terse);
    }

    libtest_mimic::run(&args, trials).exit()
}
