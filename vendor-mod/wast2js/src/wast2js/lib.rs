// Modified for Scrasm: runtime API and harness integration; see ../../NOTICE.md.
/* Copyright 2021 Mozilla Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
use std::{fmt::Write as _, path::Path};

use anyhow::{Result, bail};
use wast::{Wast, WastDirective, lexer::Lexer, parser::ParseBuffer};

#[allow(unreachable_patterns)]
mod spidermonkey;
mod spidermonkey_out;
mod v8;

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub enum JsRuntime {
    SpiderMonkey,
    V8,
}

#[derive(Clone, Debug, Default, Eq, PartialEq)]
pub struct V8Options {
    pub prelude: String,
    pub postlude: String,
    pub globals: Vec<V8Global>,
    pub compile_hook: Option<String>,
    pub instantiate_hook: Option<String>,
}

impl V8Options {
    pub fn is_empty(&self) -> bool {
        self.prelude.is_empty()
            && self.postlude.is_empty()
            && self.globals.is_empty()
            && self.compile_hook.is_none()
            && self.instantiate_hook.is_none()
    }
}

#[derive(Clone, Debug, Eq, PartialEq)]
pub enum V8Global {
    Blob { name: String, bytes: Vec<u8> },
    Js { name: String, value: String },
}

#[derive(Debug, Eq, PartialEq)]
pub struct Script {
    pub runtime: JsRuntime,
    pub script: String,
    pub blobs: Vec<(String, Vec<u8>)>,
}

impl Script {
    pub fn into_standalone_script(self) -> Result<String> {
        self.into_standalone_v8_script(&V8Options::default())
    }

    pub fn into_standalone_v8_script(self, options: &V8Options) -> Result<String> {
        if self.runtime != JsRuntime::V8 && !options.is_empty() {
            bail!("V8 options are only supported for V8 scripts");
        }

        let mut standalone = String::from(harness(self.runtime));
        if self.runtime == JsRuntime::V8 {
            for global in &options.globals {
                match global {
                    V8Global::Blob { name, bytes } => {
                        writeln!(standalone, "const {name} = {};", v8::js_blob_expr(bytes)?)
                            .expect("write to String");
                    }
                    V8Global::Js { name, value } => {
                        writeln!(standalone, "const {name} = {value};").expect("write to String");
                    }
                }
            }
        }
        for (name, bytes) in self.blobs {
            writeln!(standalone, "const {name} = {};", v8::js_blob_expr(&bytes)?).expect("write to String");
        }
        if self.runtime == JsRuntime::V8 {
            if let Some(compile_hook) = &options.compile_hook {
                writeln!(standalone, "__wastSetCompileHook({compile_hook});").expect("write to String");
            }
            if let Some(instantiate_hook) = &options.instantiate_hook {
                writeln!(standalone, "__wastSetInstantiateHook({instantiate_hook});")
                    .expect("write to String");
            }
            standalone.push_str(&options.prelude);
            if !options.prelude.is_empty() && !options.prelude.ends_with('\n') {
                standalone.push('\n');
            }
        }
        standalone.push_str(&self.script);
        if self.runtime == JsRuntime::V8 {
            standalone.push_str(&options.postlude);
            if !options.postlude.is_empty() && !options.postlude.ends_with('\n') {
                standalone.push('\n');
            }
        }
        Ok(standalone)
    }
}

pub fn harness(runtime: JsRuntime) -> &'static str {
    match runtime {
        JsRuntime::SpiderMonkey => spidermonkey::harness(),
        JsRuntime::V8 => v8::harness(),
    }
}

pub fn convert<P: AsRef<Path>>(runtime: JsRuntime, path: P, src: &str) -> Result<Script> {
    let path = path.as_ref();
    let mut lexer = Lexer::new(src);
    lexer.allow_confusing_unicode(matches!(runtime, JsRuntime::V8) || path.ends_with("names.wast"));

    let enhance_error = |mut err: wast::Error| {
        err.set_path(path);
        err.set_text(src);
        err
    };

    let buffer = ParseBuffer::new_with_lexer(lexer).map_err(enhance_error)?;
    let wast = wast::parser::parse::<Wast<'_>>(&buffer).map_err(enhance_error)?;
    convert_directives(runtime, path, src, wast.directives)
}

pub fn convert_directives<P: AsRef<Path>>(
    runtime: JsRuntime,
    path: P,
    src: &str,
    directives: Vec<WastDirective<'_>>,
) -> Result<Script> {
    match runtime {
        JsRuntime::SpiderMonkey => spidermonkey::convert_directives(path.as_ref(), src, directives),
        JsRuntime::V8 => v8::convert_directives(src, directives),
    }
}

#[cfg(test)]
mod tests {
    use super::{JsRuntime, V8Global, V8Options, convert, harness};

    #[test]
    fn spidermonkey_runtime_builds_standalone_script() {
        let src = "(module (func (export \"answer\") (result i32) i32.const 42))";
        let script = convert(JsRuntime::SpiderMonkey, "test.wast", src)
            .expect("conversion succeeds");
        assert_eq!(script.runtime, JsRuntime::SpiderMonkey);
        assert!(script.blobs.is_empty());

        let standalone = script
            .into_standalone_script()
            .expect("standalone script conversion succeeds");
        assert!(standalone.starts_with(harness(JsRuntime::SpiderMonkey)));
        assert!(standalone.contains("// test.wast"));
    }

    #[test]
    fn default_v8_options_preserve_standalone_output() {
        let src = "(module (func (export \"answer\") (result i32) i32.const 42))";
        let baseline = convert(JsRuntime::V8, "test.wast", src)
            .expect("conversion succeeds")
            .into_standalone_script()
            .expect("baseline standalone conversion succeeds");
        let with_options = convert(JsRuntime::V8, "test.wast", src)
            .expect("conversion succeeds")
            .into_standalone_v8_script(&V8Options::default())
            .expect("V8 standalone conversion succeeds");

        assert_eq!(with_options, baseline);
    }

    #[test]
    fn v8_standalone_script_emits_custom_setup() {
        let src = r#"
(module
  (import "env" "answer" (global $answer i32))
  (func (export "read") (result i32)
    global.get $answer))
(assert_return (invoke "read") (i32.const 7))
"#;
        let standalone = convert(JsRuntime::V8, "test.wast", src)
            .expect("conversion succeeds")
            .into_standalone_v8_script(&V8Options {
                prelude: "__wastRegisterImport(\"env\", { answer: new WebAssembly.Global({ value: \"i32\", mutable: false }, 7) });".into(),
                postlude: "postlude();".into(),
                globals: vec![
                    V8Global::Blob {
                        name: "fixture".into(),
                        bytes: vec![1, 2, 3],
                    },
                    V8Global::Js {
                        name: "postlude".into(),
                        value: "() => fixture.length".into(),
                    },
                ],
                compile_hook: Some("(bytes) => new WebAssembly.Module(bytes, { builtins: [\"js-string\"] })".into()),
                instantiate_hook: Some(
                    "(module, imports) => new WebAssembly.Instance(module, imports, { importedStringConstants: \"two-tier\" })".into(),
                ),
            })
            .expect("V8 standalone conversion succeeds");

        let fixture = standalone
            .find("const fixture = new Uint8Array([1, 2, 3]);")
            .expect("fixture blob emitted");
        let prelude_global = standalone
            .find("const postlude = () => fixture.length;")
            .expect("extra JS global emitted");
        let wasm_blob = standalone
            .find("const __wasm_0 = new Uint8Array([")
            .expect("generated wasm blob emitted");
        let compile_hook = standalone
            .find("__wastSetCompileHook((bytes) => new WebAssembly.Module(bytes, { builtins: [\"js-string\"] }));")
            .expect("compile hook emitted");
        let instantiate_hook = standalone
            .find("__wastSetInstantiateHook((module, imports) => new WebAssembly.Instance(module, imports, { importedStringConstants: \"two-tier\" }));")
            .expect("instantiate hook emitted");
        let prelude = standalone
            .find("__wastRegisterImport(\"env\", { answer: new WebAssembly.Global({ value: \"i32\", mutable: false }, 7) });")
            .expect("prelude emitted");
        let directive = standalone
            .rfind("__wastModule(")
            .expect("generated directive emitted");
        let postlude = standalone.rfind("postlude();").expect("postlude emitted");

        assert!(standalone.starts_with(harness(JsRuntime::V8)));
        assert!(fixture < prelude_global);
        assert!(prelude_global < wasm_blob);
        assert!(wasm_blob < compile_hook);
        assert!(compile_hook < instantiate_hook);
        assert!(instantiate_hook < prelude);
        assert!(prelude < directive);
        assert!(directive < postlude);
    }
}
