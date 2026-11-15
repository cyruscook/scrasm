use std::{
    fs::File,
    io::{BufReader, BufWriter},
    path::Path,
};

use anyhow::Context;
use serde::{Serialize, de::DeserializeOwned};

pub fn read_json_file<T>(path: &Path) -> anyhow::Result<T>
where
    T: DeserializeOwned,
{
    let file =
        File::open(path).with_context(|| format!("failed to open JSON file {}", path.display()))?;
    let reader = BufReader::new(file);
    serde_json::from_reader(reader)
        .with_context(|| format!("failed to decode JSON file {}", path.display()))
}

pub fn write_json_file<T>(path: &Path, value: &T) -> anyhow::Result<()>
where
    T: Serialize,
{
    let file = File::create(path)
        .with_context(|| format!("failed to create JSON file {}", path.display()))?;
    let writer = BufWriter::new(file);
    serde_json::to_writer_pretty(writer, value)
        .with_context(|| format!("failed to encode JSON file {}", path.display()))
}

pub fn write_json_stdout<T>(value: &T) -> anyhow::Result<()>
where
    T: Serialize,
{
    serde_json::to_writer_pretty(std::io::stdout(), value)
        .context("failed to encode JSON to stdout")?;
    println!();
    Ok(())
}
