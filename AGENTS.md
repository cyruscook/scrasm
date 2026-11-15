# Scrasm

Scrasm is an obfuscator for WebAssembly (WASM). It processes WASM modules and applies various transformations to make the code more difficult to understand while preserving its functionality. The transformations include renaming functions and variables, reordering code, and inserting dummy instructions.

It is critical that Scrasm is fast and efficient, as it may be used on large WASM modules. The obfuscation process should not significantly increase the size of a module or degrade its performance.

The most important aspect of Scrasm is that it should never break a WASM module. The obfuscated module must still be valid and executable, and it should produce the same output as the original module when run.

WASM modules can be run in a wide variety of environments, including browsers, Node.js, and standalone runtimes, so Scrasm must ensure that the obfuscated code is compatible with all of these environments. Not all environments support all WASM features, so we avoid using newer features, like 64bit memory, unless they are already used in the original module. All transformers should use the capabilities input to determine which features are available to use.

# Development lifecycle

Follow a test-driven development (TDD) approach. When implementing new features, write tests that define the expected behaviour first. When fixing bugs, add new regression tests that reproduce the bug before implementing the fix.

# Rust coding guidelines

* Prioritize code correctness and clarity. Speed and efficiency are secondary priorities unless otherwise specified.
* Do not write organizational or comments that summarize the code. Comments should only be written in order to explain "why" the code is written in some way in the case there is a reason that is tricky / non-obvious.
* Avoid creating large, oversized files. Prefer to split code into multiple smaller files and modules for better organization and readability.
* Avoid using functions that panic like `unwrap()`, instead use mechanisms like `?` to propagate errors.
* Be careful with operations like indexing which may panic if the indexes are out of bounds.
* Never silently discard errors with `let _ =` on fallible operations. Always handle errors appropriately.
* Use Cow<'_, T> when a function may or may not need to allocate
* Borrow (&T) by default; take ownership only when you need to store or consume
* Never clone to satisfy the borrow checker without understanding the root cause
* Accept &str over String, &[T] over Vec<T> in function parameters
* Use impl Into<String> for constructors that need to own a String
* Prefer iterator chains for transformations; use loops for complex control flow.
