# Scrasm browser workbench

A static GitHub Pages application that runs Scrasm compiled to WebAssembly, running in a dedicated worker.

## Local review

Requires [Vite+ (`vp`)](https://viteplus.dev/guide/) and stable Rust. Vite+ manages the pinned runtime and package manager declared in `package.json`. Install the WASM build tools once:

```sh
rustup target add wasm32-unknown-unknown
cargo install wasm-bindgen-cli --version 0.2.121 --locked
```

From this directory:

```sh
vp install --frozen-lockfile
vp run build:wasm
vp dev
```

Open the printed local URL. The example module works without selecting a file. Frontend changes reload automatically; after Rust changes rerun `vp run build:wasm` and refresh.

To test the production assets, including repository-relative paths:

```sh
vp run build
vp test --run
vp preview
```

`vp fmt` formats the site; `vp check` runs its static checks. `vp run build` compiles the Rust WASM engine and creates `dist/` with the frontend, worker, and WASM bundle. Build outputs and dependencies are ignored by Git. The version of the `wasm-bindgen` CLI must match the version pinned in `crates/scrasm-web/Cargo.toml`.

## Verification

```sh
cargo test --locked -p scrasm-web
vp check
vp test --run
```

The JavaScript tests require the generated WASM bundle. They cover actual obfuscation and execution, compatibility settings, reproducible seeds, report contents, debug dumps, malformed input/configuration, cancellation, and worker recovery.

With the development server running, reload the page and run this in the browser console to exercise stage progression, compatibility controls, editing, cancellation, errors, and reset:

```js
await (await import("/tests/browser-flow.js")).runFlowChecks();
```

The contrast check measures computed foreground/background colours against a 7:1 threshold. Run it with the desired stage, options, or dialog open:

```js
(await import("/tests/browser-contrast.js")).checkTextContrast();
```
