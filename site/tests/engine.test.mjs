import { test, expect } from "vite-plus/test";
import { readFile } from "node:fs/promises";
import init, {
  config_schema,
  default_config,
  obfuscate,
  output_schema,
} from "../public/wasm/scrasm_web.js";

await init({
  module_or_path: await readFile(new URL("../public/wasm/scrasm_web_bg.wasm", import.meta.url)),
});

const encoder = new TextEncoder();
const plaintext = "scrasm browser test data";
const reportNames = [
  "call_graph",
  "data_encryption_init",
  "dump",
  "function_index_remap",
  "string_encryption",
  "strip_debug",
];

function leb(value) {
  const result = [];
  do {
    const byte = value & 127;
    value >>>= 7;
    result.push(byte | (value ? 128 : 0));
  } while (value);
  return result;
}

function string(value) {
  const bytes = [...encoder.encode(value)];
  return [...leb(bytes.length), ...bytes];
}

function section(id, bytes) {
  return [id, ...leb(bytes.length), ...bytes];
}

function fixture({ invalidLocal = false } = {}) {
  const bodies = [
    [0, 0x20, invalidLocal ? 7 : 0, 0x20, 1, 0x6a, 0x0b],
    [0, 0x20, 0, 0x20, 1, 0x10, 0, 0x0b],
    [0, 0x20, 0, 0x20, 1, 0x6b, 0x0b],
  ];
  return Uint8Array.from([
    0,
    97,
    115,
    109,
    1,
    0,
    0,
    0,
    ...section(1, [1, 0x60, 2, 0x7f, 0x7f, 1, 0x7f]),
    ...section(3, [3, 0, 0, 0]),
    ...section(5, [1, 0, 1]),
    ...section(7, [2, ...string("add"), 0, 1, ...string("memory"), 2, 0]),
    ...section(10, [bodies.length, ...bodies.flatMap((body) => [...leb(body.length), ...body])]),
    ...section(11, [1, 0, 0x41, 0, 0x0b, ...string(plaintext)]),
    ...section(0, [...string("scrasm-test-debug"), ...string("private source metadata")]),
    ...section(0, [...string("metadata.code.branch_hint"), 0]),
  ]);
}

function config() {
  return JSON.parse(default_config());
}

function run(bytes, options = config()) {
  const result = obfuscate(bytes, JSON.stringify(options));
  try {
    return { bytes: result.bytes, report: JSON.parse(result.report) };
  } finally {
    result.free();
  }
}

function pass(report, name) {
  const [entry] = report.reports[name];
  return Object.values(entry)[0];
}

test("publishes the core defaults and both schemas", () => {
  const defaults = config();
  expect(defaults.capabilities.minimum_required_support).toBe("None");
  expect(defaults.transformers.call_graph.enabled).toBe(false);
  expect(defaults.transformers.dump.enabled).toBe(false);
  expect(defaults.transformers.string_encryption.imported_js_string_namespace).toBe(
    "string_constants",
  );
  expect(Object.keys(defaults.transformers).sort()).toStrictEqual(reportNames);
  expect(JSON.parse(config_schema()).title).toBe("ScrasmConfig");
  expect(JSON.parse(output_schema()).title).toBe("ScrasmJsonOutput");
});

for (const minimum of ["Legacy", "Modern", "None"]) {
  test(`preserves function results and initialized memory with ${minimum} compatibility`, async () => {
    const options = config();
    options.capabilities.minimum_required_support = minimum;
    options.transformers.call_graph.enabled = true;
    const original = fixture();
    const { bytes, report } = run(original, options);
    expect(WebAssembly.validate(bytes)).toBeTruthy();
    const { instance: before } = await WebAssembly.instantiate(original);
    const { instance: after } = await WebAssembly.instantiate(bytes);
    for (const [a, b] of [
      [0, 0],
      [20, 22],
      [-2147483648, -1],
      [123456, -9999],
    ]) {
      expect(after.exports.add(a, b)).toBe(before.exports.add(a, b));
    }
    expect(new Uint8Array(after.exports.memory.buffer, 0, plaintext.length)).toStrictEqual(
      new Uint8Array(before.exports.memory.buffer, 0, plaintext.length),
    );
    expect(Object.keys(report.reports).sort()).toStrictEqual(reportNames);
    expect(report.reports.dump.length).toBe(2);
    expect(pass(report, "function_index_remap").remapped_function_count >= 3).toBeTruthy();
    if (minimum !== "Legacy") {
      expect(pass(report, "call_graph").rewritten_callee_count > 0).toBeTruthy();
      expect(pass(report, "data_encryption_init").encrypted_data_segment_count).toBe(1);
      expect(Buffer.from(bytes).includes(Buffer.from(plaintext))).toBe(false);
    }
  });
}

test("disabling all passes leaves the module byte-for-byte unchanged", () => {
  const options = config();
  for (const transformer of Object.values(options.transformers)) transformer.enabled = false;
  const original = fixture();
  const { bytes, report } = run(original, options);
  expect(bytes).toStrictEqual(original);
  for (const name of reportNames)
    expect(pass(report, name).diagnostics).toStrictEqual(["Disabled"]);
});

test("explicit independent seeds make output repeatable", () => {
  const options = config();
  options.transformers.call_graph.enabled = true;
  let seedByte = 0;
  for (const transformer of Object.values(options.transformers)) {
    if ("seed" in transformer) transformer.seed = Array(32).fill(++seedByte);
  }
  const first = run(fixture(), options);
  const second = run(fixture(), options);
  expect(first).toStrictEqual(second);
});

test("strip_branch_hints controls preservation and diagnostics", () => {
  const options = config();
  const preserved = run(fixture(), options);
  expect(
    WebAssembly.Module.customSections(
      new WebAssembly.Module(preserved.bytes),
      "metadata.code.branch_hint",
    ).length,
  ).toBe(1);
  expect(
    pass(preserved.report, "strip_debug").diagnostics.some(
      (item) => item.PreservedBranchHints?.count === 1,
    ),
  ).toBeTruthy();
  options.transformers.strip_debug.strip_branch_hints = true;
  const stripped = run(fixture(), options);
  expect(
    WebAssembly.Module.customSections(
      new WebAssembly.Module(stripped.bytes),
      "metadata.code.branch_hint",
    ).length,
  ).toBe(0);
  expect(pass(stripped.report, "strip_debug").removed_custom_sections).toBe(2);
});

for (const includeRaw of [false, true]) {
  test(`returns both complete textual dumps with include_raw=${includeRaw}`, () => {
    const options = config();
    options.force_visit = true;
    options.transformers.dump = { enabled: true, include_raw: includeRaw };
    const { report } = run(fixture(), options);
    expect(report.reports.dump.length).toBe(2);
    for (const entry of report.reports.dump) {
      const dump = entry.Dump;
      expect(dump.dumped_sections > 0).toBeTruthy();
      expect(dump.output.length > 100).toBeTruthy();
      expect(dump.output).toMatch(/Type|Function|Memory/);
      expect(dump.diagnostics).toStrictEqual([]);
    }
    expect(report.reports.dump[0].Dump.output).not.toBe(report.reports.dump[1].Dump.output);
  });
}

test("nullable namespace is passed through with its diagnostic", () => {
  const options = config();
  options.transformers.string_encryption.imported_js_string_namespace = null;
  const { report } = run(fixture(), options);
  expect(
    pass(report, "string_encryption").diagnostics.includes("MissingImportedJsStringNamespace"),
  ).toBeTruthy();
});

test("rejects malformed files and invalid instructions without poisoning the engine", () => {
  for (const bytes of [
    new Uint8Array(),
    Uint8Array.of(1, 2, 3),
    fixture().subarray(0, 20),
    fixture({ invalidLocal: true }),
  ]) {
    expect(() => run(bytes)).toThrow();
  }
  expect(WebAssembly.validate(run(fixture()).bytes)).toBeTruthy();
});

test("rejects malformed configuration and unknown fields instead of silently using defaults", () => {
  for (const value of [
    "{",
    "null",
    '{"force_visit":"yes"}',
    '{"transformers":{"call_graph":{"seed":[1]}}}',
    '{"transformers":{"call_graph":{"seed":' + JSON.stringify(Array(32).fill(256)) + "}}}",
    '{"capabilities":{"minimum_required_support":"Browser"}}',
    '{"transformers":{"typo":{"enabled":true}}}',
  ]) {
    expect(() => obfuscate(fixture(), value)).toThrow();
  }
  expect(WebAssembly.validate(run(fixture()).bytes)).toBeTruthy();
});
