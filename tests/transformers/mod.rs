use std::io::{Cursor, Write};

use scrasm::{ScrasmConfig, TransformersConfig};

mod call_graph;
mod data_encryption_init;
mod function_index_remap;
mod string_encryption;
mod strip_debug;
#[path = "../support/mod.rs"]
mod support;

pub fn module_to_text<B: AsRef<[u8]>, W: std::io::Write>(
    module: B,
    out: &mut W,
) -> anyhow::Result<()> {
    wasmprinter::Config::new().print(module.as_ref(), &mut wasmprinter::PrintIoWrite(out))
}

pub fn wat_to_module(src: &str) -> anyhow::Result<Vec<u8>> {
    let mut lexer = wast::lexer::Lexer::new(src);
    lexer.allow_confusing_unicode(true);
    let buffer = wast::parser::ParseBuffer::new_with_lexer(lexer)?;
    let mut wat = wast::parser::parse::<wast::Wat<'_>>(&buffer)?;
    wat.encode().map_err(Into::into)
}

pub fn process_module<'a, W: Write>(
    span: wast::token::Span,
    id: Option<wast::token::Id<'a>>,
    name: Option<wast::token::NameAnnotation<'a>>,
    mut module: wast::QuoteWat<'a>,
    out: &'a mut Vec<u8>,
    text_out: Option<&mut W>,
) -> anyhow::Result<wast::QuoteWat<'a>> {
    // Process the module using scrasm
    let mut raw_module = module.encode()?;
    scrasm::with_config(ScrasmConfig {
        transformers: TransformersConfig {
            ..Default::default()
        },
        ..Default::default()
    })
    .scrasm(Cursor::new(&mut raw_module), Cursor::new(&mut *out))?;

    if let Some(text_out) = text_out {
        module_to_text(&mut *out, text_out)?;
    }

    Ok(wast::QuoteWat::Wat(wast::Wat::Module(wast::core::Module {
        span,
        id,
        name,
        kind: wast::core::ModuleKind::Binary(vec![out]),
    })))
}

fn main() -> anyhow::Result<()> {
    let trials = strip_debug::trials()?
        .into_iter()
        .chain(call_graph::trials()?)
        .chain(data_encryption_init::trials()?)
        .chain(function_index_remap::trials()?)
        .chain(string_encryption::trials()?)
        .collect::<Vec<_>>();

    let mut args = libtest_mimic::Arguments::from_args();
    // Default to terse output as we have *a lot* of tests.
    if args.format.is_none() {
        args.format = Some(libtest_mimic::FormatSetting::Terse);
    }

    libtest_mimic::run(&args, trials).exit()
}
