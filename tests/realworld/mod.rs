mod anubis;
#[path = "hyperquark-951679565/mod.rs"]
mod hyperquark_951679565;
mod libhydrogen;
mod moonbit_astexplorer_parser;
#[path = "../support/mod.rs"]
mod support;
mod wasure_kittygame;
mod wasure_threads;

use anyhow::Result;
fn main() -> Result<()> {
    let trials = vec![hyperquark_951679565::trials()?]
        .into_iter()
        .chain(anubis::trials()?)
        .chain(moonbit_astexplorer_parser::trials()?)
        .chain(libhydrogen::trials()?)
        .chain(wasure_kittygame::trials()?)
        .chain(wasure_threads::trials()?)
        .collect();

    let mut args = libtest_mimic::Arguments::from_args();
    if args.format.is_none() {
        args.format = Some(libtest_mimic::FormatSetting::Terse);
    }

    libtest_mimic::run(&args, trials).exit()
}
