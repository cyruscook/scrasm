use std::{
    fs::{OpenOptions, read_dir},
    io::{Cursor, Write},
    path::{Path, PathBuf},
};

use anyhow::{Context, bail};
use scrasm::{ScrasmConfig, TransformersConfig};
use wast::{
    QuoteWat, Wast, WastDirective, WastExecute, Wat,
    core::{Module as CoreModule, ModuleKind},
    lexer::Lexer,
    parser::ParseBuffer,
    token::{Id, NameAnnotation, Span},
};

pub struct ScriptTransform<'a> {
    pub directives: Vec<WastDirective<'a>>,
    pub module_rewrites: Vec<Option<Vec<u8>>>,
}

pub fn module_to_text<B: AsRef<[u8]>, W: Write>(module: B, out: &mut W) -> anyhow::Result<()> {
    wasmprinter::Config::new().print(module.as_ref(), &mut wasmprinter::PrintIoWrite(out))
}

pub fn parse_wast<'a>(path: &Path, src: &'a str) -> anyhow::Result<Wast<'a>> {
    let mut lexer = Lexer::new(src);
    lexer.allow_confusing_unicode(true);

    let enhance_error = |mut err: wast::Error| {
        err.set_path(path);
        err.set_text(src);
        err
    };

    let buffer = Box::new(ParseBuffer::new_with_lexer(lexer).map_err(enhance_error)?);
    let buffer = Box::leak(buffer);
    wast::parser::parse::<Wast<'_>>(buffer)
        .map_err(enhance_error)
        .map_err(Into::into)
}

pub fn testsuite_wast_files(root: &Path) -> anyhow::Result<Vec<PathBuf>> {
    let mut test_files = Vec::new();
    for entry in read_dir(root).with_context(|| format!("Failed to read tests from {root:?}"))? {
        let path = entry?.path();
        if path.extension().is_some_and(|ext| ext == "wast") {
            test_files.push(path);
        }
    }
    test_files.sort();
    Ok(test_files)
}

pub fn transform_script<'a>(
    directives: Vec<WastDirective<'a>>,
    dump_root: &Path,
) -> anyhow::Result<ScriptTransform<'a>> {
    std::fs::create_dir_all(dump_root)?;

    let mut transform = ScriptTransform {
        directives: Vec::with_capacity(directives.len()),
        module_rewrites: Vec::new(),
    };
    let mut next_dump_index = 0usize;

    for directive in directives {
        transform.directives.push(transform_directive(
            directive,
            dump_root,
            &mut next_dump_index,
            &mut transform.module_rewrites,
        )?);
    }

    Ok(transform)
}

fn transform_directive<'a>(
    directive: WastDirective<'a>,
    dump_root: &Path,
    next_dump_index: &mut usize,
    module_rewrites: &mut Vec<Option<Vec<u8>>>,
) -> anyhow::Result<WastDirective<'a>> {
    Ok(match directive {
        WastDirective::Module(module) => {
            let (module, bytes) = transform_quote_wat(
                module.span(),
                module.name(),
                None,
                module,
                dump_root,
                next_dump_index,
            )?;
            module_rewrites.push(Some(bytes));
            WastDirective::Module(module)
        }
        WastDirective::ModuleDefinition(module) => {
            let (module, bytes) = transform_quote_wat(
                module.span(),
                module.name(),
                None,
                module,
                dump_root,
                next_dump_index,
            )?;
            module_rewrites.push(Some(bytes));
            WastDirective::ModuleDefinition(module)
        }
        WastDirective::AssertInvalid {
            span,
            module,
            message,
        } => {
            module_rewrites.push(None);
            WastDirective::AssertInvalid {
                span,
                module,
                message,
            }
        }
        WastDirective::AssertMalformed {
            span,
            module,
            message,
        } => {
            module_rewrites.push(None);
            WastDirective::AssertMalformed {
                span,
                module,
                message,
            }
        }
        WastDirective::AssertUnlinkable {
            span,
            module,
            message,
        } => {
            let (module, bytes) = transform_wat(
                module.span(),
                None,
                None,
                module,
                dump_root,
                next_dump_index,
            )?;
            module_rewrites.push(Some(bytes));
            WastDirective::AssertUnlinkable {
                span,
                module,
                message,
            }
        }
        WastDirective::AssertTrap {
            span,
            exec,
            message,
        } => WastDirective::AssertTrap {
            span,
            exec: transform_execute(exec, dump_root, next_dump_index, module_rewrites)?,
            message,
        },
        WastDirective::AssertReturn {
            span,
            exec,
            results,
        } => WastDirective::AssertReturn {
            span,
            exec: transform_execute(exec, dump_root, next_dump_index, module_rewrites)?,
            results,
        },
        WastDirective::AssertException { span, exec } => WastDirective::AssertException {
            span,
            exec: transform_execute(exec, dump_root, next_dump_index, module_rewrites)?,
        },
        WastDirective::AssertSuspension {
            span,
            exec,
            message,
        } => WastDirective::AssertSuspension {
            span,
            exec: transform_execute(exec, dump_root, next_dump_index, module_rewrites)?,
            message,
        },
        WastDirective::Thread(thread) => {
            let directives = thread
                .directives
                .into_iter()
                .map(|directive| {
                    transform_directive(directive, dump_root, next_dump_index, module_rewrites)
                })
                .collect::<anyhow::Result<Vec<_>>>()?;
            WastDirective::Thread(wast::WastThread {
                directives,
                ..thread
            })
        }
        other => other,
    })
}

fn transform_execute<'a>(
    execute: WastExecute<'a>,
    dump_root: &Path,
    next_dump_index: &mut usize,
    module_rewrites: &mut Vec<Option<Vec<u8>>>,
) -> anyhow::Result<WastExecute<'a>> {
    Ok(match execute {
        WastExecute::Wat(module) => {
            let (module, bytes) = transform_wat(
                module.span(),
                None,
                None,
                module,
                dump_root,
                next_dump_index,
            )?;
            module_rewrites.push(Some(bytes));
            WastExecute::Wat(module)
        }
        other => other,
    })
}

fn transform_quote_wat<'a>(
    span: Span,
    id: Option<Id<'a>>,
    name: Option<NameAnnotation<'a>>,
    mut module: QuoteWat<'a>,
    dump_root: &Path,
    next_dump_index: &mut usize,
) -> anyhow::Result<(QuoteWat<'a>, Vec<u8>)> {
    let mut raw_module = module.encode()?;
    let mut out = Vec::new();

    scrasm::with_config(ScrasmConfig {
        transformers: TransformersConfig {
            ..Default::default()
        },
        ..Default::default()
    })
    .scrasm(Cursor::new(&mut raw_module), Cursor::new(&mut out))?;

    dump_module_text(dump_root, next_dump_index, &out)?;

    let leaked = Box::leak(out.clone().into_boxed_slice());

    Ok((
        QuoteWat::Wat(Wat::Module(CoreModule {
            span,
            id,
            name,
            kind: ModuleKind::Binary(vec![leaked]),
        })),
        out,
    ))
}

fn transform_wat<'a>(
    span: Span,
    id: Option<Id<'a>>,
    name: Option<NameAnnotation<'a>>,
    mut module: Wat<'a>,
    dump_root: &Path,
    next_dump_index: &mut usize,
) -> anyhow::Result<(Wat<'a>, Vec<u8>)> {
    match module {
        Wat::Module(_) => {
            let mut raw_module = module.encode()?;
            let mut out = Vec::new();

            scrasm::with_config(ScrasmConfig {
                transformers: TransformersConfig {
                    ..Default::default()
                },
                ..Default::default()
            })
            .scrasm(Cursor::new(&mut raw_module), Cursor::new(&mut out))?;

            dump_module_text(dump_root, next_dump_index, &out)?;

            let leaked = Box::leak(out.clone().into_boxed_slice());

            Ok((
                Wat::Module(CoreModule {
                    span,
                    id,
                    name,
                    kind: ModuleKind::Binary(vec![leaked]),
                }),
                out,
            ))
        }
        Wat::Component(_) => {
            bail!("component-model WAST directives are not supported by this test harness")
        }
    }
}

fn dump_module_text(
    dump_root: &Path,
    next_dump_index: &mut usize,
    module: &[u8],
) -> anyhow::Result<()> {
    let dump_path = dump_root.join(format!("{:04}.wasm", *next_dump_index));
    *next_dump_index += 1;

    module_to_text(
        module,
        &mut OpenOptions::new()
            .write(true)
            .create(true)
            .truncate(true)
            .open(dump_path)?,
    )
}
