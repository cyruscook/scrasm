#![allow(dead_code)]

use std::{pin::pin, sync::Once};

use anyhow::{Result, anyhow, bail};
use wast2js::{JsRuntime, Script, V8Options};

pub mod wast;
pub struct JsRunOutput {
    pub stdout: String,
    pub stderr: String,
}

pub fn run_wasm_script(
    module: &[u8],
    script: &str,
    extra_globals: &[(&str, &[u8])],
) -> Result<JsRunOutput> {
    init_v8();

    let isolate = &mut v8::Isolate::new(Default::default());
    isolate.set_microtasks_policy(v8::MicrotasksPolicy::Explicit);

    v8::scope!(let scope, isolate);
    let context = v8::Context::new(scope, Default::default());
    let scope = &mut v8::ContextScope::new(scope, context);

    let modbytes = wasm_bytes(scope, module)?;
    set_global(scope, "__wasm_bytes", modbytes.into())?;
    for (name, val) in extra_globals {
        let valb = wasm_bytes(scope, val)?;
        set_global(scope, name, valb.into())?;
    }
    eval(
        scope,
        r#"
globalThis.__stdout = "";
globalThis.__stderr = "";
"#,
    )
    .map_err(|err| anyhow!(err))?;

    {
        v8::tc_scope!(let tc, scope);
        if let Err(err) = eval(tc, script) {
            let exception = tc
                .exception()
                .map(|value| value.to_rust_string_lossy(tc))
                .unwrap_or(err);
            let message = tc
                .message()
                .map(|message| message.get(tc).to_rust_string_lossy(tc))
                .unwrap_or_else(|| exception.clone());
            let stack = tc
                .stack_trace()
                .map(|stack| stack.to_rust_string_lossy(tc))
                .unwrap_or_default();
            let detail = if stack.is_empty() {
                message
            } else {
                format!("{message}\n{stack}")
            };
            bail!("{detail}");
        }
    }
    scope.perform_microtask_checkpoint();

    Ok(JsRunOutput {
        stdout: read_global_string(scope, "__stdout")?,
        stderr: read_global_string(scope, "__stderr")?,
    })
}

pub fn run_wast2js_v8_script(script: Script, options: &V8Options) -> Result<JsRunOutput> {
    let standalone = script.into_standalone_v8_script(options)?;
    run_wasm_script(&[], &standalone, &[])
}

pub fn run_wast2js_v8_module(module: &[u8], options: &V8Options) -> Result<JsRunOutput> {
    run_wast2js_v8_script(
        Script {
            runtime: JsRuntime::V8,
            script: "__wastModule(0, null, __wasm_0);\n".to_owned(),
            blobs: vec![("__wasm_0".to_owned(), module.to_vec())],
        },
        options,
    )
}

fn init_v8() {
    static INIT: Once = Once::new();
    INIT.call_once(|| {
        v8::V8::set_flags_from_string("--experimental-wasm-stringref");
        v8::V8::initialize_platform(v8::new_unprotected_default_platform(0, false).make_shared());
        v8::V8::initialize();
    });
}

fn wasm_bytes<'s>(
    scope: &mut v8::PinScope<'s, '_>,
    module: &[u8],
) -> Result<v8::Local<'s, v8::Uint8Array>> {
    let backing_store = v8::ArrayBuffer::new_backing_store_from_vec(module.to_vec()).make_shared();
    let buffer = v8::ArrayBuffer::with_backing_store(scope, &backing_store);
    v8::Uint8Array::new(scope, buffer, 0, module.len())
        .ok_or_else(|| anyhow!("failed to create Uint8Array for wasm bytes"))
}

fn set_global(
    scope: &mut v8::PinScope<'_, '_>,
    name: &str,
    value: v8::Local<'_, v8::Value>,
) -> Result<()> {
    let key = v8::String::new(scope, name).ok_or_else(|| anyhow!("invalid global name: {name}"))?;
    scope
        .get_current_context()
        .global(scope)
        .set(scope, key.into(), value)
        .ok_or_else(|| anyhow!("failed to set global {name}"))?;
    Ok(())
}

fn eval<'s>(
    scope: &mut v8::PinScope<'s, '_>,
    code: &str,
) -> Result<v8::Local<'s, v8::Value>, String> {
    let scope = &mut pin!(v8::EscapableHandleScope::new(scope));
    let scope = &mut scope.as_mut().init();
    let source =
        v8::String::new(scope, code).ok_or_else(|| "failed to allocate source".to_owned())?;
    let script = v8::Script::compile(scope, source, None)
        .ok_or_else(|| "failed to compile script".to_owned())?;
    let value = script
        .run(scope)
        .ok_or_else(|| "script execution failed".to_owned())?;
    Ok(scope.escape(value))
}

fn read_global_string(scope: &mut v8::PinScope<'_, '_>, name: &str) -> Result<String> {
    let key = v8::String::new(scope, name).ok_or_else(|| anyhow!("invalid global name: {name}"))?;
    let value = scope
        .get_current_context()
        .global(scope)
        .get(scope, key.into())
        .ok_or_else(|| anyhow!("failed to read global {name}"))?;

    if value.is_undefined() {
        return Ok(String::new());
    }

    let value = value
        .to_string(scope)
        .ok_or_else(|| anyhow!("global {name} was not coercible to string"))?;
    Ok(value.to_rust_string_lossy(scope))
}
