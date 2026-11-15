use std::io::{Seek, Write};

use anyhow::{Context, Result};

pub fn write<W: Write + Seek>(writer: W, module: &wasmbin::Module) -> Result<()> {
    module.encode_into(writer).context("Serialisation error")?;
    Ok(())
}
