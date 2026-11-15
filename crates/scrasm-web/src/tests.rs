use std::error::Error;

use serde_json::Value;

use super::{config_schema, default_config, output_schema, process};

fn wasm(source: &str) -> Result<Vec<u8>, Box<dyn Error>> {
    let buffer = wast::parser::ParseBuffer::new(source)?;
    let mut module = wast::parser::parse::<wast::Wat<'_>>(&buffer)?;
    Ok(module.encode()?)
}

#[test]
fn exposes_native_defaults_and_schemas() -> Result<(), Box<dyn Error>> {
    assert_eq!(
        serde_json::from_str::<Value>(&default_config()?)?,
        serde_json::to_value(scrasm::ScrasmConfig::default())?
    );
    assert_eq!(
        serde_json::from_str::<Value>(&config_schema()?)?["title"],
        "ScrasmConfig"
    );
    assert_eq!(
        serde_json::from_str::<Value>(&output_schema()?)?["title"],
        "ScrasmJsonOutput"
    );
    Ok(())
}

#[test]
fn preserves_execution_and_returns_complete_reports() -> Result<(), Box<dyn Error>> {
    let input = wasm("(module (func (export \"answer\") (result i32) i32.const 42))")?;
    let result = process(&input, &default_config()?)?;
    let engine = wasmi::Engine::default();
    let module = wasmi::Module::new(&engine, &result.bytes[..])?;
    let mut store = wasmi::Store::new(&engine, ());
    let instance = wasmi::Linker::new(&engine).instantiate_and_start(&mut store, &module)?;
    let answer = instance.get_typed_func::<(), i32>(&store, "answer")?;
    assert_eq!(answer.call(&mut store, ())?, 42);
    let report: Value = serde_json::from_str(&result.report)?;
    let reports = report["reports"].as_object().ok_or("missing reports")?;
    assert_eq!(reports.len(), 6);
    assert_eq!(
        report["reports"]["dump"]
            .as_array()
            .ok_or("missing dump reports")?
            .len(),
        2
    );
    Ok(())
}

#[test]
fn rejects_malformed_and_invalid_modules() {
    for input in [
        b"not wasm".as_slice(),
        b"\0asm\x01\0\0\0\x01\x02\x01\xff".as_slice(),
    ] {
        assert!(process(input, "{}").is_err());
    }
}

#[test]
fn rejects_invalid_configuration() -> Result<(), Box<dyn Error>> {
    let input = wasm("(module)")?;
    for config in [
        "{",
        r#"{"force_visit":"true"}"#,
        r#"{"capabilities":{"minimum_required_support":"unknown"}}"#,
        r#"{"force_visi":true}"#,
        r#"{"transformers":{"dump":{"enable":true}}}"#,
        "{} {}",
    ] {
        assert!(process(&input, config).is_err());
    }
    Ok(())
}

#[test]
fn captures_both_module_dumps_in_reports() -> Result<(), Box<dyn Error>> {
    let input = wasm("(module (func (export \"answer\") (result i32) i32.const 42))")?;
    let result = process(
        &input,
        r#"{"transformers":{"dump":{"enabled":true,"include_raw":false}}}"#,
    )?;
    let report: Value = serde_json::from_str(&result.report)?;
    let dumps = report["reports"]["dump"]
        .as_array()
        .ok_or("missing dumps")?;
    for dump in dumps {
        let output = dump["Dump"]["output"]
            .as_str()
            .ok_or("missing dump output")?;
        assert!(output.contains("Dumping module:"));
        assert!(output.contains("Dumped"));
    }
    Ok(())
}
