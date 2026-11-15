// Copyright (c) 2026 Scrasm contributors
// SPDX-License-Identifier: Apache-2.0
use std::fmt::Write as _;

use anyhow::{Result, bail};
use wast::{
    QuoteWat, WastDirective, WastExecute, WastInvoke, WastRet, Wat,
    core::{NanPattern, WastArgCore, WastRetCore},
    token::{F32, F64, Id},
};

use super::{JsRuntime, Script};

const HARNESS: &str = include_str!("./v8_harness.js");

pub(crate) fn harness() -> &'static str {
    HARNESS
}

pub(crate) fn convert_directives(src: &str, directives: Vec<WastDirective<'_>>) -> Result<Script> {
    let mut script = String::new();
    let mut blobs = Vec::new();

    for directive in directives {
        append_directive(&mut script, &mut blobs, src, directive)?;
    }

    Ok(Script {
        runtime: JsRuntime::V8,
        script,
        blobs,
    })
}

fn append_directive(
    script: &mut String,
    blobs: &mut Vec<(String, Vec<u8>)>,
    src: &str,
    directive: WastDirective<'_>,
) -> Result<()> {
    let line = directive.span().linecol_in(src).0 + 1;

    match directive {
        WastDirective::Module(mut module) => {
            let blob = push_quote_wat_blob(blobs, &mut module)?;
            writeln!(
                script,
                "__wastModule({line}, {}, {blob});",
                js_optional_id(module.name())?
            )
            .expect("write to String");
        }
        WastDirective::ModuleDefinition(mut module) => {
            let blob = push_quote_wat_blob(blobs, &mut module)?;
            writeln!(
                script,
                "__wastModuleDefinition({line}, {}, {blob});",
                js_optional_id(module.name())?
            )
            .expect("write to String");
        }
        WastDirective::ModuleInstance {
            instance, module, ..
        } => {
            writeln!(
                script,
                "__wastModuleInstance({line}, {}, {});",
                js_optional_id(instance)?,
                js_optional_id(module)?
            )
            .expect("write to String");
        }
        WastDirective::Register { name, module, .. } => {
            writeln!(
                script,
                "__wastRegister({line}, {}, {});",
                js_optional_id(module)?,
                js_string(name)?
            )
            .expect("write to String");
        }
        WastDirective::Invoke(invoke) => {
            writeln!(script, "{};", js_invoke_stmt(line, &invoke)?).expect("write to String");
        }
        WastDirective::AssertInvalid { mut module, .. } => {
            let blob = push_quote_wat_blob(blobs, &mut module)?;
            writeln!(script, "__wastAssertInvalid({line}, {blob});").expect("write to String");
        }
        WastDirective::AssertMalformed { mut module, .. } => match module.encode() {
            Ok(bytes) => {
                let blob = push_blob(blobs, bytes);
                writeln!(script, "__wastAssertMalformed({line}, {blob});").expect("write to String");
            }
            Err(_) => {
                writeln!(
                    script,
                    "// assert_malformed satisfied during encoding at line {line}"
                )
                .expect("write to String");
            }
        },
        WastDirective::AssertUnlinkable { mut module, .. } => {
            let blob = push_wat_blob(blobs, &mut module)?;
            writeln!(script, "__wastAssertUnlinkable({line}, {blob});").expect("write to String");
        }
        WastDirective::AssertTrap { exec, .. } => {
            writeln!(script, "{};", js_assert_exec("Trap", line, exec)?).expect("write to String");
        }
        WastDirective::AssertReturn { exec, results, .. } => {
            writeln!(
                script,
                "{};",
                js_assert_return(line, exec, js_expected_results(&results)?)?
            )
            .expect("write to String");
        }
        WastDirective::AssertExhaustion { call, .. } => {
            writeln!(
                script,
                "__wastAssertInvokeTrap({line}, {});",
                js_invoke(call)?
            )
            .expect("write to String");
        }
        WastDirective::AssertException { exec, .. } => {
            writeln!(script, "{};", js_assert_exec("Exception", line, exec)?).expect("write to String");
        }
        unsupported => bail!("unsupported WAST directive for V8 runner: {unsupported:?}"),
    }

    Ok(())
}

fn js_assert_exec(kind: &str, line: usize, exec: WastExecute<'_>) -> Result<String> {
    Ok(match exec {
        WastExecute::Invoke(invoke) => {
            format!("__wastAssertInvoke{kind}({line}, {})", js_invoke(invoke)?)
        }
        WastExecute::Get { module, global, .. } => format!(
            "__wastAssertGet{kind}({line}, {}, {})",
            js_optional_id(module)?,
            js_string(global)?
        ),
        WastExecute::Wat(mut module) => {
            let bytes = module.encode()?;
            format!("__wastAssertWat{kind}({line}, {})", js_blob_expr(&bytes)?)
        }
    })
}

fn js_assert_return(line: usize, exec: WastExecute<'_>, expected: String) -> Result<String> {
    Ok(match exec {
        WastExecute::Invoke(invoke) => {
            format!(
                "__wastAssertInvokeReturn({line}, {}, {expected})",
                js_invoke(invoke)?
            )
        }
        WastExecute::Get { module, global, .. } => format!(
            "__wastAssertGetReturn({line}, {}, {}, {expected})",
            js_optional_id(module)?,
            js_string(global)?
        ),
        WastExecute::Wat(mut module) => {
            let bytes = module.encode()?;
            format!("__wastAssertWatReturn({line}, {}, {expected})", js_blob_expr(&bytes)?)
        }
    })
}

fn js_invoke_stmt(line: usize, invoke: &WastInvoke<'_>) -> Result<String> {
    Ok(format!("__wastInvoke({line}, {})", js_invoke_ref(invoke)?))
}

fn js_invoke(invoke: WastInvoke<'_>) -> Result<String> {
    let args = invoke
        .args
        .into_iter()
        .map(js_arg)
        .collect::<Result<Vec<_>>>()?
        .join(", ");
    js_invoke_string(invoke.module, invoke.name, args)
}

fn js_invoke_ref(invoke: &WastInvoke<'_>) -> Result<String> {
    let args = invoke
        .args
        .iter()
        .map(js_arg_ref)
        .collect::<Result<Vec<_>>>()?
        .join(", ");
    js_invoke_string(invoke.module, invoke.name, args)
}

fn js_invoke_string<'a>(module: Option<Id<'a>>, name: &'a str, args: String) -> Result<String> {
    Ok(format!(
        "{{ module: {}, name: {}, args: [{}] }}",
        js_optional_id(module)?,
        js_string(name)?,
        args
    ))
}

fn js_arg(arg: wast::WastArg<'_>) -> Result<String> {
    let wast::WastArg::Core(arg) = arg else {
        bail!("unsupported WAST argument in V8 runner: {arg:?}");
    };
    js_arg_core(&arg)
}

fn js_arg_ref(arg: &wast::WastArg<'_>) -> Result<String> {
    let wast::WastArg::Core(arg) = arg else {
        bail!("unsupported WAST argument in V8 runner: {arg:?}");
    };
    js_arg_core(arg)
}

fn js_arg_core(arg: &WastArgCore<'_>) -> Result<String> {
    Ok(match arg {
        WastArgCore::I32(value) => format!("{{ type: \"i32\", value: \"{value}\" }}"),
        WastArgCore::I64(value) => format!("{{ type: \"i64\", value: \"{value}\" }}"),
        WastArgCore::F32(value) => format!("{{ type: \"f32\", bits: {} }}", value.bits),
        WastArgCore::F64(value) => format!("{{ type: \"f64\", bits: \"{}\" }}", value.bits),
        WastArgCore::RefNull(_) => "{ type: \"ref.null\" }".to_owned(),
        WastArgCore::RefExtern(value) => {
            format!("{{ type: \"ref.extern\", value: {value} }}")
        }
        unsupported => bail!("unsupported WAST argument in V8 runner: {unsupported:?}"),
    })
}

fn js_expected_results(results: &[WastRet<'_>]) -> Result<String> {
    let results = results.iter().map(js_result).collect::<Result<Vec<_>>>()?.join(", ");
    Ok(format!("[{results}]"))
}

fn js_result(result: &WastRet<'_>) -> Result<String> {
    let WastRet::Core(result) = result else {
        bail!("unsupported WAST ret result in V8 runner: {result:?}");
    };
    js_result_core(result)
}

fn js_result_core(result: &WastRetCore<'_>) -> Result<String> {
    Ok(match result {
        WastRetCore::I32(value) => format!("{{ type: \"i32\", value: \"{value}\" }}"),
        WastRetCore::I64(value) => format!("{{ type: \"i64\", value: \"{value}\" }}"),
        WastRetCore::F32(pattern) => {
            format!("{{ type: \"f32\", pattern: {} }}", js_f32_pattern(pattern)?)
        }
        WastRetCore::F64(pattern) => {
            format!("{{ type: \"f64\", pattern: {} }}", js_f64_pattern(pattern)?)
        }
        WastRetCore::RefNull(_) => "{ type: \"ref.null\" }".to_owned(),
        WastRetCore::RefExtern(Some(value)) => {
            format!("{{ type: \"ref.extern\", value: {value} }}")
        }
        WastRetCore::RefExtern(None) => "{ type: \"ref.null\" }".to_owned(),
        WastRetCore::RefFunc(_) => "{ type: \"ref.func\" }".to_owned(),
        WastRetCore::Either(cases) => format!(
            "{{ type: \"either\", cases: [{}] }}",
            cases.iter().map(js_result_core).collect::<Result<Vec<_>>>()?.join(", ")
        ),
        unsupported => bail!("unsupported WAST ret core result in V8 runner: {unsupported:?}"),
    })
}

fn js_f32_pattern(pattern: &NanPattern<F32>) -> Result<String> {
    Ok(match pattern {
        NanPattern::CanonicalNan => "{ kind: \"canonical_nan\" }".to_owned(),
        NanPattern::ArithmeticNan => "{ kind: \"arithmetic_nan\" }".to_owned(),
        NanPattern::Value(value) => format!("{{ kind: \"value\", bits: {} }}", value.bits),
    })
}

fn js_f64_pattern(pattern: &NanPattern<F64>) -> Result<String> {
    Ok(match pattern {
        NanPattern::CanonicalNan => "{ kind: \"canonical_nan\" }".to_owned(),
        NanPattern::ArithmeticNan => "{ kind: \"arithmetic_nan\" }".to_owned(),
        NanPattern::Value(value) => format!("{{ kind: \"value\", bits: \"{}\" }}", value.bits),
    })
}

fn push_quote_wat_blob(blobs: &mut Vec<(String, Vec<u8>)>, module: &mut QuoteWat<'_>) -> Result<String> {
    Ok(push_blob(blobs, module.encode()?))
}

fn push_wat_blob(blobs: &mut Vec<(String, Vec<u8>)>, module: &mut Wat<'_>) -> Result<String> {
    match module {
        Wat::Module(_) => Ok(push_blob(blobs, module.encode()?)),
        Wat::Component(_) => bail!("component-model WAST is not supported by the V8 runner"),
    }
}

fn push_blob(blobs: &mut Vec<(String, Vec<u8>)>, bytes: Vec<u8>) -> String {
    let name = format!("__wasm_{}", blobs.len());
    blobs.push((name.clone(), bytes));
    name
}

pub(crate) fn js_blob_expr(bytes: &[u8]) -> Result<String> {
    let values = bytes
        .iter()
        .map(|byte| byte.to_string())
        .collect::<Vec<_>>()
        .join(", ");
    Ok(format!("new Uint8Array([{values}])"))
}

fn js_optional_id(id: Option<Id<'_>>) -> Result<String> {
    match id {
        Some(id) => js_string(id.name()),
        None => Ok("null".to_owned()),
    }
}

fn js_string(value: &str) -> Result<String> {
    serde_json::to_string(value).map_err(Into::into)
}

#[cfg(test)]
mod tests {
    use crate::{JsRuntime, convert, harness};

    #[test]
    fn converts_modules_registers_and_assertions() {
        let src = r#"
(module $lib
  (func (export "one") (result i32)
    i32.const 1))
(register "lib" $lib)
(module
  (import "lib" "one" (func $one (result i32)))
  (func (export "call_one") (result i32)
    call $one))
(assert_return (invoke "call_one") (i32.const 1))
"#;

        let script = convert(JsRuntime::V8, "test.wast", src).expect("conversion succeeds");
        assert_eq!(script.runtime, JsRuntime::V8);
        assert_eq!(script.blobs.len(), 2);
        assert!(script.script.contains("__wastModule("));
        assert!(script.script.contains("__wastRegister("));
        assert!(script.script.contains("__wastAssertInvokeReturn("));
        assert!(script.script.contains("\"call_one\""));
    }

    #[test]
    fn standalone_script_includes_harness_and_blob_bindings() {
        let src = "(module (func (export \"answer\") (result i32) i32.const 42))";
        let script = convert(JsRuntime::V8, "test.wast", src)
            .expect("conversion succeeds")
            .into_standalone_script()
            .expect("standalone script conversion succeeds");

        assert!(script.starts_with(harness(JsRuntime::V8)));
        assert!(script.contains("const __wasm_0 = new Uint8Array(["));
        assert!(script.contains("__wastModule("));
    }
}
