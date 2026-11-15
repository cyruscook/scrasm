export const transforms = [
  ["strip_debug", "Strip debug information", "Remove names, debug data and compiler metadata."],
  ["data_encryption_init", "Encrypt data", "Encrypt data segments; decrypt at initialization."],
  ["function_index_remap", "Shuffle functions", "Reorder functions to obscure source structure."],
  ["string_encryption", "Encrypt JS strings", "Encrypt imported JavaScript string constants."],
  ["call_graph", "Obfuscate call graph", "Replace direct calls with indirect dispatch."],
];
export const titles = Object.fromEntries([
  ...transforms.map(([key, title]) => [key, title]),
  ["dump", "Module dump"],
]);
export function parseSeed(value) {
  const hex = value.trim();
  if (!hex) return null;
  if (!/^[a-f\d]{64}$/i.test(hex))
    throw new Error(
      "Enter exactly 64 hexadecimal characters (32 bytes), or leave blank for a random seed.",
    );
  return Array.from({ length: 32 }, (_, index) =>
    parseInt(hex.slice(index * 2, index * 2 + 2), 16),
  );
}
export function seedHex(value) {
  return value?.map((byte) => byte.toString(16).padStart(2, "0")).join("") ?? "";
}
export function parseConfig(text, defaults) {
  const value = JSON.parse(text);
  const object = (value) => value !== null && typeof value === "object" && !Array.isArray(value);
  const merge = (input, base, path) => {
    if (!object(input)) throw new Error(`${path || "Configuration"} must be an object.`);
    const result = structuredClone(base);
    for (const [key, entry] of Object.entries(input)) {
      const name = path ? `${path}.${key}` : key;
      if (!Object.hasOwn(base, key)) throw new Error(`Unknown option: ${name}.`);
      if (object(base[key])) result[key] = merge(entry, base[key], name);
      else if (key === "seed") {
        if (
          entry !== null &&
          (!Array.isArray(entry) ||
            entry.length !== 32 ||
            !entry.every((n) => Number.isInteger(n) && n >= 0 && n <= 255))
        )
          throw new Error(`${name} must be null or an array of exactly 32 bytes (0–255).`);
        result[key] = entry;
      } else if (key === "minimum_required_support") {
        if (!["None", "Modern", "Legacy"].includes(entry))
          throw new Error(`${name} must be None, Modern, or Legacy.`);
        result[key] = entry;
      } else if (key === "imported_js_string_namespace") {
        if (entry !== null && typeof entry !== "string")
          throw new Error(`${name} must be a string or null.`);
        result[key] = entry;
      } else {
        if (typeof entry !== typeof base[key])
          throw new Error(`${name} must be ${typeof base[key]}.`);
        result[key] = entry;
      }
    }
    return result;
  };
  return merge(value, defaults, "");
}
export const outputName = (name) => `${name.replace(/\.wasm$/i, "")}.obfuscated.wasm`;
export function reportRows(report) {
  return Object.entries(report.reports ?? report).flatMap(([name, passes]) =>
    passes.map((pass, index) => ({ name, index, ...Object.values(pass)[0] })),
  );
}
export function humanize(value) {
  return value
    .replace(/([a-z])([A-Z])/g, "$1 $2")
    .replaceAll("_", " ")
    .replace(/^./, (letter) => letter.toUpperCase());
}
export function bytesLabel(size) {
  if (size < 1024) return `${size.toLocaleString()} B`;
  const unit = size < 1024 ** 2 ? "KB" : "MB";
  return `${(size / (unit === "KB" ? 1024 : 1024 ** 2)).toLocaleString(undefined, { maximumFractionDigits: 2 })} ${unit}`;
}
