// Copyright (c) 2026 Scrasm contributors
// SPDX-License-Identifier: Apache-2.0
const __wastState = {
  current: null,
  instances: new Map(),
  definitions: new Map(),
  registry: Object.create(null),
};

const __scratch = new ArrayBuffer(8);
const __view = new DataView(__scratch);

function __wastFail(line, message) {
  throw new Error(`line ${line}: ${message}`);
}

const __wastHooks = {
  compile(bytes) {
    return new WebAssembly.Module(bytes);
  },
  instantiate(module, imports) {
    return new WebAssembly.Instance(module, imports);
  },
};

function __wastSetCompileHook(hook) {
  __wastHooks.compile = hook;
}

function __wastSetInstantiateHook(hook) {
  __wastHooks.instantiate = hook;
}

function __wastCompile(bytes) {
  return __wastHooks.compile(bytes);
}

function __wastInstantiate(bytes) {
  const module = __wastCompile(bytes);
  return __wastHooks.instantiate(module, __wastState.registry, bytes);
}

function __wastExposeInstance(name, instance) {
  if (name !== null) {
    __wastState.instances.set(name, instance);
    __wastState.registry[name] = instance.exports;
  }
  __wastState.current = instance;
}

function __wastGetInstance(name) {
  if (name === null) {
    if (!__wastState.current) {
      throw new Error("missing current instance");
    }
    return __wastState.current;
  }
  const instance = __wastState.instances.get(name);
  if (!instance) {
    throw new Error(`missing instance ${name}`);
  }
  return instance;
}

function __wastModule(line, name, bytes) {
  __wastExposeInstance(name, __wastInstantiate(bytes));
}

function __wastModuleDefinition(line, name, bytes) {
  __wastCompile(bytes);
  if (name !== null) {
    __wastState.definitions.set(name, bytes);
  }
}

function __wastModuleInstance(line, instanceName, moduleName) {
  if (moduleName === null) {
    __wastFail(line, "module instance directive requires a named module");
  }
  const bytes = __wastState.definitions.get(moduleName);
  if (!bytes) {
    __wastFail(line, `missing named module ${moduleName}`);
  }
  __wastExposeInstance(instanceName, __wastInstantiate(bytes));
}

function __wastRegister(line, name, asName) {
  const instance = __wastGetInstance(name);
  __wastState.registry[asName] = instance.exports;
}

function __wastRegisterImport(name, value) {
  __wastState.registry[name] = value;
}

function __wastF32(bits) {
  __view.setUint32(0, Number(bits), true);
  return __view.getFloat32(0, true);
}

function __wastF64(bits) {
  __view.setBigUint64(0, BigInt(bits), true);
  return __view.getFloat64(0, true);
}

function __wastF32Bits(value) {
  __view.setFloat32(0, value, true);
  return __view.getUint32(0, true);
}

function __wastF64Bits(value) {
  __view.setFloat64(0, value, true);
  return __view.getBigUint64(0, true);
}

function __wastArg(spec) {
  switch (spec.type) {
    case "i32":
      return Number(BigInt.asIntN(32, BigInt(spec.value)));
    case "i64":
      return BigInt.asIntN(64, BigInt(spec.value));
    case "f32":
      return __wastF32(spec.bits);
    case "f64":
      return __wastF64(spec.bits);
    case "ref.null":
      return null;
    case "ref.extern":
      return spec.value;
    default:
      throw new Error(`unsupported argument type ${spec.type}`);
  }
}

function __wastRunInvoke(line, spec) {
  const instance = __wastGetInstance(spec.module);
  const func = instance.exports[spec.name];
  if (typeof func !== "function") {
    __wastFail(line, `export ${spec.name} is not callable`);
  }
  const result = func(...spec.args.map(__wastArg));
  return Array.isArray(result) ? result : (result === undefined ? [] : [result]);
}

function __wastRunGet(line, moduleName, field) {
  const instance = __wastGetInstance(moduleName);
  const value = instance.exports[field];
  if (value instanceof WebAssembly.Global) {
    return [value.value];
  }
  return [value];
}

function __wastRunWat(line, bytes) {
  __wastInstantiate(bytes);
  return [];
}

function __wastInvoke(line, spec) {
  __wastRunInvoke(line, spec);
}

function __wastMatchF32(value, pattern) {
  const bits = __wastF32Bits(value);
  switch (pattern.kind) {
    case "canonical_nan":
      return (bits & 0x7fffffff) === 0x7fc00000;
    case "arithmetic_nan":
      return (bits & 0x7f800000) === 0x7f800000 && (bits & 0x00400000) === 0x00400000;
    case "value":
      return bits === Number(pattern.bits);
  }
  return false;
}

function __wastMatchF64(value, pattern) {
  const bits = __wastF64Bits(value);
  switch (pattern.kind) {
    case "canonical_nan":
      return (bits & 0x7fffffffffffffffn) === 0x7ff8000000000000n;
    case "arithmetic_nan":
      return (bits & 0x7ff0000000000000n) === 0x7ff0000000000000n &&
        (bits & 0x0008000000000000n) === 0x0008000000000000n;
    case "value":
      return bits === BigInt(pattern.bits);
  }
  return false;
}

function __wastMatchResult(value, expected) {
  switch (expected.type) {
    case "i32":
      return (Number(value) >>> 0) === Number(BigInt.asUintN(32, BigInt(expected.value)));
    case "i64":
      return typeof value === "bigint" &&
        BigInt.asUintN(64, value) === BigInt.asUintN(64, BigInt(expected.value));
    case "f32":
      return typeof value === "number" && __wastMatchF32(value, expected.pattern);
    case "f64":
      return typeof value === "number" && __wastMatchF64(value, expected.pattern);
    case "ref.null":
      return value === null;
    case "ref.extern":
      return value === expected.value;
    case "ref.func":
      return typeof value === "function";
    case "either":
      return expected.cases.some(candidate => __wastMatchResult(value, candidate));
    default:
      throw new Error(`unsupported expected result type ${expected.type}`);
  }
}

function __wastAssertResults(line, actual, expected) {
  if (actual.length !== expected.length) {
    __wastFail(line, `expected ${expected.length} result(s), found ${actual.length}`);
  }
  for (let i = 0; i < expected.length; i++) {
    if (!__wastMatchResult(actual[i], expected[i])) {
      __wastFail(line, `result ${i} mismatch`);
    }
  }
}

function __wastAssertThrown(line, thunk, kind) {
  try {
    thunk();
  } catch (_error) {
    return;
  }
  __wastFail(line, `expected ${kind}`);
}

function __wastAssertInvokeReturn(line, spec, expected) {
  __wastAssertResults(line, __wastRunInvoke(line, spec), expected);
}

function __wastAssertGetReturn(line, moduleName, field, expected) {
  __wastAssertResults(line, __wastRunGet(line, moduleName, field), expected);
}

function __wastAssertWatReturn(line, bytes, expected) {
  __wastAssertResults(line, __wastRunWat(line, bytes), expected);
}

function __wastAssertInvokeTrap(line, spec) {
  __wastAssertThrown(line, () => __wastRunInvoke(line, spec), "trap");
}

function __wastAssertGetTrap(line, moduleName, field) {
  __wastAssertThrown(line, () => __wastRunGet(line, moduleName, field), "trap");
}

function __wastAssertWatTrap(line, bytes) {
  __wastAssertThrown(line, () => __wastRunWat(line, bytes), "trap");
}

function __wastAssertInvokeException(line, spec) {
  __wastAssertThrown(line, () => __wastRunInvoke(line, spec), "exception");
}

function __wastAssertGetException(line, moduleName, field) {
  __wastAssertThrown(line, () => __wastRunGet(line, moduleName, field), "exception");
}

function __wastAssertWatException(line, bytes) {
  __wastAssertThrown(line, () => __wastRunWat(line, bytes), "exception");
}

function __wastAssertInvalid(line, bytes) {
  __wastAssertThrown(line, () => __wastCompile(bytes), "invalid module");
}

function __wastAssertMalformed(line, bytes) {
  __wastAssertThrown(line, () => __wastCompile(bytes), "malformed module");
}

function __wastAssertUnlinkable(line, bytes) {
  __wastAssertThrown(line, () => __wastInstantiate(bytes), "unlinkable module");
}

const spectest = {
  print() {},
  print_i32(_value) {},
  print_i64(_value) {},
  print_f32(_value) {},
  print_f64(_value) {},
  print_i32_f32(_a, _b) {},
  print_f64_f64(_a, _b) {},
  memory: new WebAssembly.Memory({ initial: 1, maximum: 2 }),
  table: new WebAssembly.Table({ initial: 10, maximum: 20, element: "anyfunc" }),
  global_i32: new WebAssembly.Global({ value: "i32", mutable: false }, 666),
  global_i64: new WebAssembly.Global({ value: "i64", mutable: false }, 666n),
  global_f32: new WebAssembly.Global({ value: "f32", mutable: false }, __wastF32(0x4426a666)),
  global_f64: new WebAssembly.Global({ value: "f64", mutable: false }, __wastF64("4653144502051863213")),
};

__wastState.registry.spectest = spectest;
