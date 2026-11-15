use std::io::{Read, Seek};

use anyhow::{Context, Result};

pub fn parse<R: Read + Seek>(mut reader: R) -> Result<wasmbin::Module> {
    let m = wasmbin::Module::decode_from(&mut reader).with_context(
        #[allow(clippy::expect_used)]
        || {
            format!(
                "Parsing error at offset 0x{:08X}",
                reader
                    .stream_position()
                    .expect("failed to retrieve stream position")
            )
        },
    )?;
    Ok(m)
}
