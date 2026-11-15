import { test, expect } from "vite-plus/test";
import { parseConfig, parseSeed, seedHex, outputName, reportRows } from "../src/config.mjs";
const defaults = {
  capabilities: { minimum_required_support: "None" },
  force_visit: false,
  transformers: {
    call_graph: { enabled: false, seed: null },
    data_encryption_init: { enabled: true, seed: null },
    dump: { enabled: false, include_raw: true },
    function_index_remap: { enabled: true, seed: null },
    string_encryption: {
      enabled: true,
      seed: null,
      imported_js_string_namespace: "string_constants",
    },
    strip_debug: { enabled: true, strip_branch_hints: false },
  },
};
test("partial config imports merge defaults without mutating them", () => {
  const result = parseConfig('{"transformers":{"call_graph":{"enabled":true}}}', defaults);
  expect(result.transformers.call_graph.enabled).toBe(true);
  expect(result.transformers.strip_debug.enabled).toBe(true);
  expect(defaults.transformers.call_graph.enabled).toBe(false);
});
test("invalid and unknown config fields fail with their path", () => {
  for (const [value, path] of [
    [{ force_visit: "false" }, "force_visit"],
    [{ transformers: { unknown: {} } }, "unknown"],
    [{ capabilities: { minimum_required_support: "Browser" } }, "minimum_required_support"],
    [{ transformers: { call_graph: { seed: [1] } } }, "seed"],
    [{ transformers: { dump: null } }, "dump"],
  ])
    expect(() => parseConfig(JSON.stringify(value), defaults)).toThrow(new RegExp(path));
  expect(() => parseConfig("[]", defaults)).toThrow(/object/);
});
test("seeds preserve all 32 bytes and blank seeds use secure randomness", () => {
  const hex = "01ab".repeat(16);
  expect(seedHex(parseSeed(hex))).toBe(hex);
  expect(parseSeed("  ")).toBe(null);
  expect(() => parseSeed("ff")).toThrow(/64/);
});
test("download names preserve original stem and report rows retain repeated passes", () => {
  expect(outputName("sample.wasm")).toBe("sample.obfuscated.wasm");
  expect(outputName("sample.WASM")).toBe("sample.obfuscated.wasm");
  expect(
    reportRows({
      reports: {
        dump: [{ Dump: { dumped_sections: 2 } }, { Dump: { dumped_sections: 3 } }],
      },
    }).length,
  ).toBe(2);
});
