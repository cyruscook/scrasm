# Call graph obfuscation

This transformer rewrites selected direct internal calls into indirect calls through a private table-backed dispatch layer.

The implementation is intentionally conservative. The main goal is to preserve module behaviour across runtimes, not to maximise obfuscation strength. If the transformer cannot prove that a module fits the supported subset, it skips the module instead of attempting a partial rewrite.

## What the transformer does

For each eligible internal callee:

1. It assigns the function to a private dispatch slot.
2. It groups eligible callees by function signature.
3. It generates one dispatcher helper per signature.
4. It rewrites direct `call` and `return_call` instructions to call the matching dispatcher, passing an encoded slot constant.
5. It populates the dispatch table eagerly using an active element segment.

The dispatcher decodes the slot and performs `call_indirect` with the callee's original function type.

In simplified form:

```wat
;; before
local.get 0
call $helper

;; after
local.get 0
i32.const <encoded-slot>
call $dispatcher_for_signature
```

The actual table stores the original functions, not wrappers around them.

## Why it works this way

This design keeps the runtime model simple:

- The dispatch table is fully populated at instantiation time, so there is no lazy state to initialise later.
- The pass does not wrap exports or rewrite entrypoints, which avoids changing externally visible behaviour.
- One dispatcher per signature keeps the `call_indirect` type immediate stable and avoids needing one helper per callee.
- Existing public table contents remain untouched when a module already has a local table. The transformer appends a private range above the existing minimum and targets that appended range only.

The slot constant is currently encoded as `absolute_slot ^ key`, with one XOR key per dispatcher. This is deliberately lightweight. It hides plain table indices at callsites without adding much runtime cost.

## When the transformer skips a module

The transformer is a no-op when any of the following is true:

- There are no eligible direct internal calls to rewrite.
- The module imports a table.
- The module defines more than one local table.
- The single local table is not a function-reference table.
- The single local table has a maximum that cannot accommodate the extra private slots.
- The single local table uses a table init expression, which the current implementation does not extend.

Imported tables are skipped because resizing them changes the module ABI, and reusing host-provided spare capacity is not safe. Multiple or non-function tables are skipped because v1 assumes one function table that Scrasm fully understands.

## When the transformer skips a function

A function is only used as an obfuscated callee when all of the following are true:

- It is locally defined.
- It is not exported.
- It is not the start function.
- Its reference is never taken.
- It is actually the target of a direct `call` or `return_call`.

"Reference is never taken" means the function does not appear in any element segment and does not appear in any `ref.func` instruction.

Exported functions are skipped because rewriting them safely would need either wrappers or stronger whole-module reasoning about all external entry paths. Address-taken functions are skipped because they may already participate in existing indirect-call behaviour, and v1 does not try to rewrite or duplicate that table state.

## Table handling

### Modules without a table

The transformer creates one local `funcref` table whose minimum is exactly the number of private dispatch slots. It then adds one active element segment at offset `0` containing the eligible functions in shuffled slot order.

### Modules with one local table

The transformer preserves the existing public range, increases the table minimum, and appends a new active element segment at offset `old_min`. Rewritten calls use absolute slot indices in that appended range.

This absolute-slot detail matters: the encoded slot constant refers to the actual table index, not to a private zero-based slot number.

## Rewrite scope

The transformer currently rewrites:

- `call`
- `return_call`

The transformer intentionally leaves these unchanged:

- `call_indirect`
- `return_call_indirect`
- `call_ref`
- `return_call_ref`
- `ref.func`

That keeps the pass local to direct internal calls and avoids having to reinterpret existing reference-taking or indirect-call behaviour.

## Configuration

```rust
#[derive(Clone, Copy, Debug, Default)]
pub struct CallGraphConfig {
    pub enabled: bool,
    pub seed: Option<[u8; 32]>,
}
```

- `enabled`: turns the pass on or off. Default is `false`.
- `seed`: controls slot shuffling and dispatcher XOR keys. If unset, randomness comes from the OS RNG.

## Code layout

- `mod.rs`: config and top-level orchestration
- `analyse.rs`: module/function eligibility checks and slot planning inputs
- `dispatch.rs`: dispatcher generation
- `rewrite.rs`: table updates and instruction rewriting

## Future iterations

Likely next steps for this transformer:

- Support a wider range of table layouts, especially more existing-table shapes.
- Strengthen slot encoding so callsites are less obviously table dispatch constants.
- Introduce more than one dispatch strategy, such as per-component or per-entrypoint partitioning.
- Rewrite additional call shapes where it can be proven safe.
- Consider wrapper-based handling for exported callees if the ABI and start-function consequences are explicitly managed.
- Add stronger analyses for modules with more complex existing table usage.

Possible but deliberately deferred ideas:

- Lazy table population.
- Call graph partitioning based on SCCs or entrypoints.
- Per-callee wrappers instead of storing original functions directly.

Those approaches may improve obfuscation, but they also introduce more correctness risk and runtime complexity than the current implementation.
