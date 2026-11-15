use std::{fs::read_to_string, path::Path};

use anyhow::Context;
use libtest_mimic::{Failed, Trial};
use wast::WastDirective;
use wast2js::{JsRuntime, Script, convert_directives};

#[path = "support/mod.rs"]
mod support;

fn prepare_script(
    path: &Path,
    src: &str,
    directives: Vec<WastDirective<'_>>,
) -> anyhow::Result<Script> {
    convert_directives(JsRuntime::V8, path, src, directives)
}

fn execute_prepared_script(prepared: Script) -> anyhow::Result<()> {
    let script = prepared.into_standalone_script()?;
    support::run_wasm_script(&[], &script, &[]).map(|_| ())
}

fn run_v8_test(init_res: anyhow::Result<()>, path: &Path, src: &str) -> anyhow::Result<()> {
    init_res?;

    let parsed = support::wast::parse_wast(path, src)?;
    let dump_root = std::env::temp_dir().join("scrasm-v8-dumps").join(path);
    let transformed = support::wast::transform_script(parsed.directives, &dump_root)?;
    let prepared = prepare_script(path, src, transformed.directives)?;
    execute_prepared_script(prepared)
}

fn v8_trials() -> anyhow::Result<Vec<Trial>> {
    let testsuite_root = Path::new("tests").join("testsuite");

    support::wast::testsuite_wast_files(&testsuite_root)?
        .into_iter()
        .map(|path| {
            let src = read_to_string(&path)
                .with_context(|| format!("Failed to read test from {:?}", path))?;

            let parsed = support::wast::parse_wast(&path, &src)?;
            let init_res =
                prepare_script(&path, &src, parsed.directives).and_then(execute_prepared_script);
            let test_ignored = init_res.is_err();

            Ok::<Trial, anyhow::Error>(
                Trial::test(path.display().to_string(), move || {
                    run_v8_test(init_res, &path, &src)
                        .map_err(|err| Failed::from(format!("{err:#}")))
                })
                .with_ignored_flag(test_ignored),
            )
        })
        .collect()
}

fn main() -> anyhow::Result<()> {
    let trials = v8_trials()?;
    let mut args = libtest_mimic::Arguments::from_args();
    if args.format.is_none() {
        args.format = Some(libtest_mimic::FormatSetting::Terse);
    }

    libtest_mimic::run(&args, trials).exit()
}
