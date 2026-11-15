use std::{
    fs::{File, OpenOptions},
    io::{BufReader, BufWriter},
    path::PathBuf,
};

use anyhow::Context;
use clap::Parser;
use scrasm::{ScrasmConfig, ScrasmJsonOutput};

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    input_file: PathBuf,

    #[arg(short, long)]
    output_file: PathBuf,

    #[arg(long)]
    config_json: Option<PathBuf>,

    #[arg(long)]
    result_json: Option<PathBuf>,
}

fn load_config(args: &Args) -> anyhow::Result<ScrasmConfig> {
    Ok(match &args.config_json {
        Some(path) => scrasm::json::read_json_file(path)?,
        None => ScrasmConfig::default(),
    })
}

fn write_result_json(
    path: Option<&PathBuf>,
    reports: scrasm::TransformerReportsByName,
) -> anyhow::Result<()> {
    let output = ScrasmJsonOutput { reports };
    if let Some(path) = path {
        scrasm::json::write_json_file(path, &output)
    } else {
        scrasm::json::write_json_stdout(&output)
    }
}

pub fn main() -> anyhow::Result<()> {
    let args = Args::parse();
    let input_path = &args.input_file;
    let output_path = &args.output_file;

    let inp = {
        let inp = File::open(input_path)
            .with_context(|| format!("failed to open input file {}", input_path.display()))?;
        BufReader::new(inp)
    };
    let out = {
        let out = OpenOptions::new()
            .create(true)
            .truncate(true)
            .write(true)
            .open(output_path)
            .with_context(|| format!("failed to open output file {}", output_path.display()))?;
        BufWriter::new(out)
    };

    let reports = scrasm::with_config(load_config(&args)?).scrasm_with_reports(inp, out)?;
    if args.result_json.is_some() {
        write_result_json(args.result_json.as_ref(), reports)?;
    }

    Ok(())
}
