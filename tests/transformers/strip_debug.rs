use std::io::Cursor;

use anyhow::{Context, Result, anyhow, bail};
use libtest_mimic::Trial;
use scrasm::{ScrasmConfig, StripDebugConfig};
use wasmbin::{
    builtins::Blob,
    io::{Decode, Encode},
    sections::{CustomSection, NameSubSection, RawCustomSection, Section},
    visit::Visit,
};

use crate::wat_to_module;

fn process_module(src: &[u8], out: &mut Vec<u8>) -> Result<()> {
    scrasm::with_config(ScrasmConfig {
        transformers: scrasm::TransformersConfig {
            strip_debug: StripDebugConfig {
                enabled: true,
                strip_branch_hints: false,
            },
            function_index_remap: scrasm::FunctionIndexRemapConfig {
                enabled: false,
                seed: None,
            },
            ..Default::default()
        },
        ..Default::default()
    })
    .scrasm(Cursor::new(src), Cursor::new(&mut *out))?;
    Ok(())
}

fn check_no_custom_sections(src: &[u8]) -> Result<()> {
    let module = wasmbin::Module::decode(&mut Cursor::new(src))
        .context("Could not decode testcase module")?;

    module
        .visit(|item: &CustomSection| bail!("found a custom section: {item:?}"))
        .map_err(|e| anyhow!("{e:?}"))?;
    module
        .visit(|item: &RawCustomSection| bail!("found a raw custom section: {item:?}"))
        .map_err(|e| anyhow!("{e:?}"))?;

    Ok(())
}

fn raw_custom_section_trials() -> Result<Vec<Trial>> {
    let modules = vec![wasmbin::Module {
        sections: vec![
            Section::Custom(Blob::from(CustomSection::Other(RawCustomSection {
                name: "debug_info".to_string(),
                data: vec![0, 1, 2, 3, 4, 5].into(),
            }))),
            Section::Custom(Blob::from(CustomSection::Name(
                vec![NameSubSection::Module(Blob::from(
                    "module_name".to_string(),
                ))]
                .into(),
            ))),
        ],
    }];
    modules
        .into_iter()
        .enumerate()
        .map(|(i, m)| {
            let mut w = Vec::new();
            m.encode(&mut Cursor::new(&mut w)).map(|_| {
                Trial::test(format!("raw-custom-section-{i}"), move || {
                    check_no_custom_sections(&w).err().unwrap();
                    let mut out = Vec::new();
                    process_module(&w, &mut out).context("failed to process module with scrasm")?;
                    Ok(check_no_custom_sections(&out)?)
                })
                .with_ignored_flag(false)
            })
        })
        .collect::<Result<Vec<_>, _>>()
        .context("encoding testcase")
}

fn custom_anot_trials() -> Result<Vec<Trial>> {
    let modules = vec![wat_to_module(
        r#"
        (module
          (type $t (func))
          (@custom "my-section1" "contents-bytes1")
          (@custom "my-section2" "more-contents-bytes0")
          (@custom "my-section1" "contents-bytes2")
          (@custom "my-section2" (before global) "more-contents-bytes1")
          (@custom "my-section2" (after func) "more-contents-bytes2")
          (@custom "my-section2" (after func) "more-contents-bytes3")
          (@custom "my-section2" (before global) "more-contents-bytes4")
          (func)
          (@custom "my-section2" "more-contents-bytes5")

          (global $g i32 (i32.const 0))
          (@custom "my-section3")
          (@custom "my-section4" "" "1" "" "2" "3" "")
          (@custom "")
        )
        "#,
    )?];
    Ok(modules
        .into_iter()
        .enumerate()
        .map(|(i, wasm)| {
            Trial::test(format!("custom-annot-{i}"), move || {
                check_no_custom_sections(&wasm).err().unwrap();
                let mut out = Vec::new();
                process_module(&wasm, &mut out).context("failed to process module with scrasm")?;
                check_no_custom_sections(&out)?;
                Ok(())
            })
            .with_ignored_flag(false)
        })
        .collect::<Vec<_>>())
}

fn branch_hint_trials() -> Result<Vec<Trial>> {
    let modules = vec![wat_to_module(
        r#"
        (module
          (type (;0;) (func (param i32)))
          (memory (;0;) 1 1)
          (func $dummy)
          (func $test1 (type 0)
            (local i32)
            local.get 1
            local.get 0
            i32.eq
            (@metadata.code.branch_hint "\00" ) if
              return
            end
            return
          )
          (func $test2 (type 0)
            (local i32)
            local.get 1
            local.get 0
            i32.eq
            (@metadata.code.branch_hint "\01" ) if
              return
            end
            return
          )
          (func (export "nested") (param i32 i32) (result i32)
            (@metadata.code.branch_hint "\00")
            (if (result i32) (local.get 0)
              (then
                (if (local.get 1) (then (call $dummy) (block) (nop)))
                (if (local.get 1) (then) (else (call $dummy) (block) (nop)))
                (@metadata.code.branch_hint "\01")
                (if (result i32) (local.get 1)
                  (then (call $dummy) (i32.const 9))
                  (else (call $dummy) (i32.const 10))
                )
              )
              (else
                (if (local.get 1) (then (call $dummy) (block) (nop)))
                (@metadata.code.branch_hint "\00")
                (if (local.get 1) (then) (else (call $dummy) (block) (nop)))
                (if (result i32) (local.get 1)
                  (then (call $dummy) (i32.const 10))
                  (else (call $dummy) (i32.const 11))
                )
              )
            )
          )
        )
        "#,
    )?];
    Ok(modules
        .into_iter()
        .enumerate()
        .map(|(i, wasm)| {
            Trial::test(format!("branch-hint-{i}"), move || {
                check_no_custom_sections(&wasm).err().unwrap();
                let mut out = Vec::new();
                process_module(&wasm, &mut out).context("failed to process module with scrasm")?;
                // Branch hints should NOT have been removed
                check_no_custom_sections(&out).err().unwrap();
                Ok(())
            })
            .with_ignored_flag(false)
        })
        .collect::<Vec<_>>())
}

fn name_anot_trials() -> Result<Vec<Trial>> {
    let modules = vec![
        wat_to_module(
            r#"
            (module (@name "Modül"))
            "#,
        )?,
        wat_to_module(
            r#"
            (module $moduel (@name "Modül"))
            "#,
        )?,
        wat_to_module(
            r#"
            (module
              (type $t (func))
              (func (@name "λ") (type $t))
              (func $lambda (@name "λ") (type $t))
            )
            "#,
        )?,
        wat_to_module(
            r#"
            (module
              (type $t (func))
              (tag (@name "θ") (type $t))
              (tag $theta (@name "θ") (type $t))
            )
            "#,
        )?,
    ];
    Ok(modules
        .into_iter()
        .enumerate()
        .map(|(i, wasm)| {
            Trial::test(format!("name-annot-{i}"), move || {
                check_no_custom_sections(&wasm).err().unwrap();
                let mut out = Vec::new();
                process_module(&wasm, &mut out).context("failed to process module with scrasm")?;
                check_no_custom_sections(&out)?;
                Ok(())
            })
            .with_ignored_flag(false)
        })
        .collect::<Vec<_>>())
}

pub fn trials() -> Result<Vec<Trial>> {
    Ok(raw_custom_section_trials()?
        .into_iter()
        .chain(custom_anot_trials()?)
        .chain(branch_hint_trials()?)
        .chain(name_anot_trials()?)
        .collect())
}
