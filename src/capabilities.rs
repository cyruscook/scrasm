use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use ts_rs::TS;
use wasmbin::{
    Module,
    instructions::Instruction,
    sections::{DataInit, Element, payload},
    types::{CompositeType, RefType},
    visit::Visit,
};

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
pub enum MinimumRequiredSupport {
    // No minimum required support - use any standardised WASM features
    None,
    // Requires support for somewhat older but recent runtimes
    Modern,
    // Requires support for older runtimes
    Legacy,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, JsonSchema, TS)]
#[serde(default)]
pub struct CapabilitiesConfig {
    pub minimum_required_support: MinimumRequiredSupport,
}

impl Default for CapabilitiesConfig {
    fn default() -> Self {
        Self {
            minimum_required_support: MinimumRequiredSupport::None,
        }
    }
}

#[allow(unused, clippy::struct_excessive_bools)]
pub struct Capabilities {
    /// <https://github.com/WebAssembly/exception-handling/blob/master/proposals/exception-handling/Exceptions.md>
    exception_handling: bool,
    /// <https://github.com/WebAssembly/extended-const/blob/master/proposals/extended-const/Overview.md>
    extended_constant_expressions: bool,
    /// <https://github.com/WebAssembly/memory64/blob/main/proposals/memory64/Overview.md>
    memory_64: bool,
    /// <https://github.com/WebAssembly/multi-memory/blob/main/proposals/multi-memory/Overview.md>
    multiple_memories: bool,
    /// <https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md>
    reference_types: bool,
    /// <https://github.com/WebAssembly/bulk-memory-operations/blob/master/proposals/bulk-memory-operations/Overview.md>
    bulk_memory: bool,
    /// <https://github.com/WebAssembly/tail-call/blob/main/proposals/tail-call/Overview.md>
    tail_call: bool,
    /// <https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md>
    gc: bool,
    /// <https://github.com/WebAssembly/js-string-builtins/blob/main/proposals/js-string-builtins/Overview.md>
    js_string_builtins: bool,
}

pub fn get_capabilities_for_module(config: CapabilitiesConfig, module: &Module) -> Capabilities {
    Capabilities {
        exception_handling: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::Modern | MinimumRequiredSupport::None
        ) || module.find_std_section::<payload::Exception>().is_some(),
        extended_constant_expressions: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::Modern | MinimumRequiredSupport::None
        ) || module
            .find_std_section::<payload::Global>()
            .and_then(|global_section| {
                global_section
                    .try_contents()
                    .map(|globals| {
                        globals.iter().any(|global| {
                            global.init.iter().any(|inst| {
                                matches!(
                                    inst,
                                    Instruction::I32Add
                                        | Instruction::I32Sub
                                        | Instruction::I32Mul
                                        | Instruction::I64Add
                                        | Instruction::I64Sub
                                        | Instruction::I64Mul
                                )
                            })
                        })
                    })
                    .ok()
            })
            .unwrap_or(false),
        memory_64: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::None
        ) || module
            .find_std_section::<payload::Memory>()
            .and_then(|mem_section| {
                mem_section
                    .try_contents()
                    .map(|mems| mems.iter().any(|mem| mem.limits.is_64))
                    .ok()
            })
            .unwrap_or(false),
        multiple_memories: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::None
        ) || module
            .find_std_section::<payload::Memory>()
            .and_then(|mem_section| mem_section.try_contents().map(|mems| mems.len() > 1).ok())
            .unwrap_or(false),
        reference_types: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::Modern | MinimumRequiredSupport::None
        ) || module_uses_reference_types(module),
        bulk_memory: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::Modern | MinimumRequiredSupport::None
        ) || module_uses_bulk_memory(module),
        tail_call: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::None
        ) || module_uses_tail_call(module),
        gc: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::None
        ) || module_uses_gc(module),
        js_string_builtins: matches!(
            config.minimum_required_support,
            MinimumRequiredSupport::None
        ) || module_uses_js_string_builtins(module),
    }
}

fn module_uses_reference_types(module: &Module) -> bool {
    module.visit(|_: &RefType| false).is_err()
}

fn module_uses_bulk_memory(module: &Module) -> bool {
    if module.find_std_section::<payload::DataCount>().is_some() {
        return true;
    }

    if module
        .visit(|instruction: &Instruction| {
            !matches!(
                instruction,
                Instruction::Misc(
                    wasmbin::instructions::Misc::MemoryInit { .. }
                        | wasmbin::instructions::Misc::DataDrop(_)
                        | wasmbin::instructions::Misc::MemoryCopy { .. }
                        | wasmbin::instructions::Misc::MemoryFill(_)
                        | wasmbin::instructions::Misc::TableInit { .. }
                        | wasmbin::instructions::Misc::ElemDrop(_)
                        | wasmbin::instructions::Misc::TableCopy { .. }
                )
            )
        })
        .is_err()
    {
        return true;
    }

    if module
        .visit(|data_init: &DataInit| {
            !matches!(
                data_init,
                DataInit::Passive | DataInit::ActiveWithMemory { .. }
            )
        })
        .is_err()
    {
        return true;
    }

    module
        .visit(|element: &Element| {
            !matches!(
                element,
                Element::PassiveWithFuncs { .. }
                    | Element::ActiveWithTableAndFuncs { .. }
                    | Element::DeclarativeWithFuncs { .. }
                    | Element::PassiveWithExprs { .. }
                    | Element::ActiveWithTableAndExprs { .. }
                    | Element::DeclarativeWithExprs { .. }
            )
        })
        .is_err()
}

fn module_uses_tail_call(module: &Module) -> bool {
    module
        .visit(|instruction: &Instruction| {
            !matches!(
                instruction,
                Instruction::ReturnCall(_)
                    | Instruction::ReturnCallIndirect(_)
                    | Instruction::ReturnCallRef(_)
            )
        })
        .is_err()
}

fn module_uses_gc(module: &Module) -> bool {
    if module
        .visit(|instruction: &Instruction| {
            !matches!(
                instruction,
                Instruction::RefAsNonNull | Instruction::RefTypeOp(_)
            )
        })
        .is_err()
    {
        return true;
    }

    module
        .visit(|composite_type: &CompositeType| {
            !matches!(
                composite_type,
                CompositeType::Array(_) | CompositeType::Struct(_)
            )
        })
        .is_err()
}

fn module_uses_js_string_builtins(module: &Module) -> bool {
    module
        .find_std_section::<payload::Import>()
        .and_then(|import_section| import_section.try_contents().ok())
        .map(|imports| {
            imports
                .iter()
                .any(|import| import.path.module.as_str() == "wasm:js-string")
        })
        .unwrap_or(false)
}

#[allow(dead_code)]
impl Capabilities {
    #[must_use]
    pub const fn exception_handling(&self) -> bool {
        self.exception_handling
    }

    #[must_use]
    pub const fn extended_constant_expressions(&self) -> bool {
        self.extended_constant_expressions
    }

    #[must_use]
    pub const fn memory_64(&self) -> bool {
        self.memory_64
    }

    #[must_use]
    pub const fn multiple_memories(&self) -> bool {
        self.multiple_memories
    }

    #[must_use]
    pub const fn reference_types(&self) -> bool {
        self.reference_types
    }

    #[must_use]
    pub const fn bulk_memory(&self) -> bool {
        self.bulk_memory
    }

    #[must_use]
    pub const fn tail_call(&self) -> bool {
        self.tail_call
    }

    #[must_use]
    pub const fn gc(&self) -> bool {
        self.gc
    }

    #[must_use]
    pub const fn js_string_builtins(&self) -> bool {
        self.js_string_builtins
    }
}
