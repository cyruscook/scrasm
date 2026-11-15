use clap::{Parser, ValueEnum};

#[derive(Clone, Copy, Debug, Eq, PartialEq, ValueEnum)]
enum SchemaTarget {
    Config,
    Output,
}

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(value_enum)]
    target: SchemaTarget,
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();
    match args.target {
        SchemaTarget::Config => scrasm::json::write_json_stdout(&scrasm::config_json_schema()),
        SchemaTarget::Output => scrasm::json::write_json_stdout(&scrasm::output_json_schema()),
    }
}
