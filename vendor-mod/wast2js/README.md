# wast2js

Converter from `.wast` to `.js` test harnesses.

- Default target: SpiderMonkey jit-test output.
- V8 target: `wast2js --target v8 path/to/test.wast`.
- Library API: use `convert`, `convert_directives`, and `harness` with `JsRuntime`, then call `Script::into_standalone_script` when you want a self-contained file.

This is a modified Mozilla wast2js distribution with Scrasm V8 support.
See [NOTICE.md](NOTICE.md) and [Apache License 2.0](LICENSE-APACHE).
