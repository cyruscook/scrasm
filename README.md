# Scrasm

Scrasm is a tool for obfuscating WebAssembly modules, making them more resistant to reverse engineering in order to protect intellectual property and prevent removal of software guardrails and licensing functionality.

I started writing this by hand in 2025 with the intention of commercialising it, but recent progressions in AI-assisted reverse engineering has convinced me that there is no credible long-term option for commercialisation of Scrasm. Therefore I'm releasing this as open source.

## Installation

```sh
cargo install scrasm --locked --bin scrasm
```

## Browser workbench

Scrasm also runs entirely in the browser using a WebAssembly build of the same Rust library. The workbench includes the full configuration, transformation reports, debug dumps, and downloads. See [site/README.md](site/README.md) for local preview, testing, and GitHub Pages deployment instructions.

## Features

* [Call graph obfuscation](src/process/transformers/call_graph) - this rewrites direct method invocation with dynamic runtime invocation to hinder static analysis callgraph reconstruction
* [Data encryption](src/process/transformers/data_encryption_init) - this XOR encrypts the WASM modules data sections (which will usually contain data such as strings, keys etc) and adds code to decrypt it on module initialisation. Quite complicated as it needs to handle both 32bit and 64bit memories and to avoid allocating large amounts of memory it decrypts the data in gradually decreasing segments, storing the XOR key in the remaining unused parts of memory.
* [Function Index Remap](src/process/transformers/function_index_remap) - this just shuffles the order of the module's functions to prevent any inference of source code structure
* [String Encryption](src/process/transformers/string_encryption) - similar to data encryption, but this handles strings from the [JS String Builtins proposal](https://github.com/WebAssembly/js-string-builtins/blob/main/proposals/js-string-builtins/Overview.md). It also uses an XOR key and decrypts on module initialisation
* [Strip Debug](src/process/transformers/strip_debug) - just removes any debug information or compiler metadata that might otherwise assist reverse engineers

Scrasm operates with a concept of ["Capabilities"](src/capabilities.rs) - essentially the caller specifies whether they need the outputted module to have compatibility with legacy or modern runtimes (or no compatiblity requirements at all). Scrasm processors will then automatically avoid creating dependencies on features that, for example, are only available in certain web browsers or only newer versions.

The most effort so far in developing Scrasm has not been the obfuscation features, but rather the capabilities system and an extremely extensive testsuite to gain strong confidence in its reliability. This makes it a good platform for safely experimenting with new features.

## Credits

Scrasm heavily depends on [wasmbin](https://github.com/RReverser/wasmbin), created by RReverser, for its low-level access to WASM bytecode.

As the primary goal of Scrasm was compatibility with a wide range of runtimes and WASM features, I've also integrated extensive examples of real-world WASM use into `tests/realworld/`, all of which I've attributed and provided the relevant license conditions.

## Tests

Initialize the WebAssembly specification tests before running the suites:

```sh
git submodule update --init --recursive
```

Use the commands below to run Scrasm's test suites

```sh
cargo test -- --color always --nocapture
cargo test --test transformers string_encryption
```

The string-encryption tests compile inline WAT fixtures and check validation, plaintext removal, and runtime behaviour in V8, including concatenating strings and passing the result to a host function.

## Config and Output Schema

Use the commands below to generate JSON schemas for Scrasm's input config and output formats.

```sh
cargo run --bin schema-gen -- config > scrasm-config.schema.json
cargo run --bin schema-gen -- output > scrasm-output.schema.json
```
