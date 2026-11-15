import { createEngine, sampleBytes } from "./engine.js";
import {
  transforms,
  titles,
  parseConfig,
  parseSeed,
  seedHex,
  outputName,
  reportRows,
  humanize,
  bytesLabel,
} from "./config.mjs";

const $ = (id) => document.getElementById(id);
const node = (tag, className, text) => {
  const element = document.createElement(tag);
  if (className) element.className = className;
  if (text !== undefined) element.textContent = text;
  return element;
};
const state = {
  defaults: null,
  config: null,
  configSchema: null,
  outputSchema: null,
  file: null,
  result: null,
  busy: false,
  loadingFile: false,
  ready: false,
  revision: 0,
  activeStage: "module",
};
let fileRequest = 0;
let configImportRequest = 0;
const engine = createEngine({
  onStatus: (status) => {
    showStatus(
      state.loadingFile
        ? "Reading module…"
        : ({
            loading: "Loading Scrasm…",
            running: "Obfuscating module…",
          }[status] ?? ""),
    );
  },
});
const fields = new Map();
const compatibilityHints = {
  None: "Use any standardized feature. Existing module features are always preserved.",
  Modern: "Avoid features restricted to newer runtimes, unless already used by your module.",
  Legacy: "Avoid introducing newer features. This does not remove features already in your module.",
};

const stages = ["module", "config", "output"];

function showStatus(message) {
  $("engine-status").textContent = message;
  $("engine-status").hidden = !message;
}
function refreshStages() {
  for (const stage of stages) {
    const active = state.activeStage === stage;
    const trigger = $(`trigger-${stage}`);
    trigger.disabled =
      state.busy || (stage === "config" && !state.file) || (stage === "output" && !state.result);
    trigger.setAttribute("aria-expanded", String(active));
    trigger.setAttribute("aria-disabled", String(trigger.disabled || active));
    $(`panel-${stage}`).hidden = !active;
    $(`stage-${stage}`).classList.toggle("is-active", active);
  }
  $("summary-module").textContent = state.file
    ? `${state.file.name} · ${bytesLabel(state.file.bytes.byteLength)}`
    : "Choose a .wasm file";
  const enabled = state.config
    ? transforms.filter(([key]) => state.config.transformers[key].enabled).length
    : 0;
  const compatibility = state.config?.capabilities.minimum_required_support;
  $("summary-config").textContent = state.file
    ? `${enabled} transformations · ${compatibility === "None" ? "Unrestricted" : (compatibility ?? "Loading…")}`
    : "Select a module first";
  $("summary-output").textContent = state.result
    ? `${outputName(state.file.name)} · ${bytesLabel(state.result.bytes.byteLength)}`
    : state.busy
      ? "Processing…"
      : "No output yet";
  $("continue-config").hidden = !state.file;
}
function openStage(stage, focus = false) {
  if (state.busy || (stage === "config" && !state.file) || (stage === "output" && !state.result))
    return;
  state.activeStage = stage;
  refreshStages();
  if (focus) {
    $(`trigger-${stage}`).focus({ preventScroll: true });
    $(`trigger-${stage}`).scrollIntoView({
      block: "nearest",
      behavior: "instant",
    });
  }
}
function selectedCompatibility() {
  return document.querySelector('[name="compatibility"]:checked')?.value ?? "None";
}

function announce(text) {
  $("announcement").textContent = text;
}
function showError(message) {
  $("error").hidden = !message;
  $("error").textContent = message;
}
function download(data, name, type) {
  const url = URL.createObjectURL(new Blob([data], { type }));
  const link = node("a");
  link.href = url;
  link.download = name;
  document.body.append(link);
  link.click();
  link.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}
function downloadJson(value, name) {
  download(`${JSON.stringify(value, null, 2)}\n`, name, "application/json");
}
function refreshActions() {
  const valid = $("config-form").checkValidity();
  $("run").disabled = !state.ready || !state.file || state.busy || state.loadingFile || !valid;
  $("run").hidden = state.busy;
  $("cancel").hidden = !state.busy;
  $("config-fields").disabled = !state.ready || state.busy;
  for (const id of ["edit-json", "reset-config"]) $(id).disabled = !state.ready || state.busy;
  $("export-config").disabled = !state.ready || state.busy || !valid;
  for (const id of ["drop-zone", "remove-file", "example"]) $(id).disabled = state.busy;
  $("output-badge").textContent = state.busy
    ? "Processing"
    : state.result
      ? "Complete"
      : state.file
        ? "Ready to process"
        : "Awaiting module";
  $("output-badge").classList.toggle("complete", Boolean(state.result));
  refreshStages();
}
function invalidate(message) {
  state.revision++;
  state.result = null;
  $("report-json").textContent = "";
  $("result").hidden = true;
  $("output-empty").hidden = false;
  $("empty-title").textContent = "No output";
  $("empty-description").textContent = message || "Run Scrasm to generate output.";
  if (state.activeStage === "output") state.activeStage = state.file ? "config" : "module";
  refreshActions();
}
function optionLabel(text, input, description) {
  const label = node("label", "option-label");
  label.append(node("span", "", text), input);
  if (description) label.append(node("small", "field-hint", description));
  return label;
}
function buildTransformRows() {
  for (const [key, title, description] of transforms) {
    const row = node("div", "transform-row");
    const main = node("div", "transform-main");
    const toggle = node("input", "switch-input");
    toggle.type = "checkbox";
    toggle.id = `enable-${key}`;
    const label = node("label", "transform-label");
    label.htmlFor = toggle.id;
    const labelText = node("span");
    labelText.append(
      node("span", "transform-title", title),
      node("span", "transform-description", description),
    );
    label.append(labelText, toggle);
    main.append(label);
    row.append(main);
    const details = node("details", "transform-options");
    const summary = node("summary", "", "Options");
    summary.setAttribute("aria-label", `${title} options`);
    details.append(summary);
    const options = node("div", "options-body");
    const controls = { enabled: toggle };
    if (key !== "strip_debug") {
      const seed = node("input", "seed-input");
      seed.type = "text";
      seed.placeholder = "Random on each run";
      seed.autocomplete = "off";
      seed.spellcheck = false;
      const hint = optionLabel(
        "Random seed",
        seed,
        "Optional · 64 hexadecimal characters (32 bytes).",
      );
      const error = node("span", "seed-error");
      error.id = `seed-error-${key}`;
      error.hidden = true;
      error.setAttribute("aria-live", "polite");
      seed.setAttribute("aria-describedby", error.id);
      hint.append(error);
      options.append(hint);
      controls.seed = seed;
      controls.seedError = error;
    } else {
      const strip = node("input");
      strip.type = "checkbox";
      const stripLabel = node("label", "checkbox-row");
      stripLabel.append(strip, node("span", "", "Strip branch hints"));
      options.append(stripLabel);
      controls.strip_branch_hints = strip;
    }
    if (key === "string_encryption") {
      const namespace = node("input");
      namespace.type = "text";
      namespace.autocomplete = "off";
      namespace.spellcheck = false;
      options.append(optionLabel("Imported string namespace", namespace));
      controls.imported_js_string_namespace = namespace;
      const noNamespace = node("input");
      noNamespace.type = "checkbox";
      const nullLabel = node("label", "checkbox-row");
      nullLabel.append(noNamespace, node("span", "", "No string namespace (null)"));
      options.append(nullLabel);
      controls.nullNamespace = noNamespace;
      options.append(
        node(
          "p",
          "field-hint",
          "Must match your module’s importedStringConstants compile option. An empty string and null are different values.",
        ),
      );
    }
    if (key === "call_graph")
      options.append(
        node(
          "p",
          "field-hint",
          "Adds an indirect dispatch layer. Disabled by default because it may affect runtime performance.",
        ),
      );
    details.append(options);
    row.append(details);
    $("transform-list").append(row);
    fields.set(key, controls);
  }
}
function syncForm() {
  for (const radio of document.querySelectorAll('[name="compatibility"]')) {
    radio.checked = radio.value === state.config.capabilities.minimum_required_support;
  }
  $("compatibility-hint").textContent = compatibilityHints[selectedCompatibility()];
  for (const [key, controls] of fields) {
    const config = state.config.transformers[key];
    controls.enabled.checked = config.enabled;
    if (controls.seed) {
      controls.seed.value = seedHex(config.seed);
      controls.seed.setCustomValidity("");
      controls.seed.removeAttribute("aria-invalid");
      controls.seedError.hidden = true;
    }
    if (controls.strip_branch_hints)
      controls.strip_branch_hints.checked = config.strip_branch_hints;
    if (controls.imported_js_string_namespace) {
      controls.imported_js_string_namespace.value = config.imported_js_string_namespace ?? "";
      controls.nullNamespace.checked = config.imported_js_string_namespace === null;
      controls.imported_js_string_namespace.disabled = controls.nullNamespace.checked;
    }
  }
  $("force-visit").checked = state.config.force_visit;
  $("dump-enabled").checked = state.config.transformers.dump.enabled;
  $("dump-raw").checked = state.config.transformers.dump.include_raw;
  $("enabled-count").textContent =
    `${transforms.filter(([key]) => state.config.transformers[key].enabled).length} of ${transforms.length} enabled`;
  refreshActions();
}
function readForm() {
  const next = structuredClone(state.config);
  next.capabilities.minimum_required_support = selectedCompatibility();
  for (const [key, controls] of fields) {
    next.transformers[key].enabled = controls.enabled.checked;
    if (controls.seed) {
      try {
        next.transformers[key].seed = parseSeed(controls.seed.value);
        controls.seed.setCustomValidity("");
        controls.seed.removeAttribute("aria-invalid");
        controls.seedError.hidden = true;
      } catch (error) {
        controls.seed.setCustomValidity(error.message);
        controls.seed.setAttribute("aria-invalid", "true");
        controls.seedError.textContent = error.message;
        controls.seedError.hidden = false;
      }
    }
    if (controls.strip_branch_hints)
      next.transformers[key].strip_branch_hints = controls.strip_branch_hints.checked;
    if (controls.imported_js_string_namespace) {
      next.transformers[key].imported_js_string_namespace = controls.nullNamespace.checked
        ? null
        : controls.imported_js_string_namespace.value;
      controls.imported_js_string_namespace.disabled = controls.nullNamespace.checked;
    }
  }
  next.force_visit = $("force-visit").checked;
  next.transformers.dump = {
    enabled: $("dump-enabled").checked,
    include_raw: $("dump-raw").checked,
  };
  state.config = next;
  $("compatibility-hint").textContent = compatibilityHints[selectedCompatibility()];
  $("enabled-count").textContent =
    `${transforms.filter(([key]) => next.transformers[key].enabled).length} of ${transforms.length} enabled`;
  invalidate("Configuration changed. Run Scrasm to generate output with these settings.");
  showError("");
}
async function selectFile(file) {
  if (state.busy || !file) return;
  const request = ++fileRequest;
  state.loadingFile = true;
  refreshActions();
  showStatus("Reading module…");
  showError("");
  try {
    const bytes = new Uint8Array(await file.arrayBuffer());
    if (request !== fileRequest) return;
    if (
      bytes.length < 8 ||
      bytes[0] !== 0 ||
      bytes[1] !== 97 ||
      bytes[2] !== 115 ||
      bytes[3] !== 109
    )
      throw new Error(
        "This file is not a WebAssembly binary. Choose a compiled .wasm module; WAT text is not supported.",
      );
    state.file = { name: file.name, bytes };
    $("file-name").textContent = file.name;
    $("file-hint").textContent = "WebAssembly binary";
    $("file-action").textContent = "Replace file ↗";
    $("file-size").textContent =
      `${bytesLabel(bytes.byteLength)} · ${bytes.byteLength.toLocaleString()} bytes`;
    $("file-detail").hidden = false;
    $("drop-zone").classList.add("has-file");
    invalidate();
    openStage("config", true);
    announce(`${file.name} selected. ${bytesLabel(bytes.byteLength)}.`);
  } catch (error) {
    if (request === fileRequest)
      showError(error.message || "Unable to read this file. Please choose it again.");
  } finally {
    if (request === fileRequest) {
      state.loadingFile = false;
      refreshActions();
      showStatus(state.ready ? "" : "Loading Scrasm…");
    }
  }
  $("file-input").value = "";
}
function removeFile() {
  fileRequest++;
  state.loadingFile = false;
  state.file = null;
  state.activeStage = "module";
  $("file-name").textContent = "Choose a WebAssembly module";
  $("file-hint").textContent = "or drop a .wasm file here";
  $("file-action").textContent = "Browse files ↗";
  $("file-detail").hidden = true;
  $("drop-zone").classList.remove("has-file");
  invalidate();
  showError("");
  $("drop-zone").focus();
}
function diagnosticText(diagnostic) {
  if (typeof diagnostic === "string") return humanize(diagnostic);
  return Object.entries(diagnostic)
    .map(
      ([name, detail]) =>
        `${humanize(name)}${
          Object.keys(detail).length
            ? `: ${Object.entries(detail)
                .map(
                  ([key, value]) =>
                    `${humanize(key).toLowerCase()} ${Array.isArray(value) ? value.join(", ") : value}`,
                )
                .join("; ")}`
            : ""
        }`,
    )
    .join(". ");
}
function renderReport(report) {
  const list = $("report-list");
  list.replaceChildren();
  for (const row of reportRows(report)) {
    const details = node("details", "report-row");
    const diagnostics = row.diagnostics ?? [];
    const disabled = diagnostics.includes("Disabled");
    const metrics = Object.entries(row).filter(
      ([key, value]) => !["name", "index"].includes(key) && typeof value === "number",
    );
    const changed = metrics.some(([, value]) => value > 0);
    const heading = node("summary");
    const title = node(
      "span",
      "report-name",
      `${titles[row.name] ?? humanize(row.name)}${row.name === "dump" ? (row.index === 0 ? " · Before" : " · After") : ""}`,
    );
    const status = node(
      "span",
      `report-status ${disabled ? "muted" : changed ? "changed" : "muted"}`,
      disabled
        ? "Disabled"
        : changed
          ? row.name === "dump"
            ? "Captured"
            : "Applied"
          : "No change",
    );
    heading.append(title, status, node("span", "report-chevron", "+"));
    details.append(heading);
    const body = node("div", "report-details");
    const stats = node("dl", "pass-metrics");
    for (const [key, value] of metrics) {
      const item = node("div");
      item.append(node("dt", "", humanize(key)), node("dd", "mono", value.toLocaleString()));
      stats.append(item);
    }
    if (metrics.length) body.append(stats);
    for (const diagnostic of diagnostics)
      body.append(node("p", "diagnostic", diagnosticText(diagnostic)));
    if (row.output !== undefined) {
      const downloadDump = node("button", "text-button", "Download module dump ↓");
      downloadDump.type = "button";
      downloadDump.addEventListener("click", () =>
        download(row.output, `scrasm-${row.index === 0 ? "before" : "after"}.txt`, "text/plain"),
      );
      body.append(downloadDump);
      const dump = node("pre", "dump-output");
      dump.tabIndex = 0;
      dump.setAttribute("aria-label", "Module structure dump");
      details.addEventListener("toggle", () => {
        if (details.open && !dump.textContent) dump.textContent = row.output;
      });
      body.append(dump);
    }
    details.append(body);
    list.append(details);
  }
}
function showResult(result) {
  state.result = result;
  $("output-empty").hidden = true;
  $("result").hidden = false;
  $("result-name").textContent = outputName(state.file.name);
  $("original-size").textContent = bytesLabel(state.file.bytes.byteLength);
  $("output-size").textContent = bytesLabel(result.bytes.byteLength);
  const percentage =
    ((result.bytes.byteLength - state.file.bytes.byteLength) / state.file.bytes.byteLength) * 100;
  $("size-change").textContent =
    `${percentage > 0 ? "+" : ""}${percentage.toLocaleString(undefined, { maximumFractionDigits: 1 })}%`;
  $("elapsed").textContent =
    result.elapsedMs < 1000
      ? `${Math.max(1, Math.round(result.elapsedMs))} ms`
      : `${(result.elapsedMs / 1000).toFixed(2)} s`;
  renderReport(result.report);
  $("report-json").textContent = "";
  setOutputView(false);
  announce(
    `Processing complete. Output ${bytesLabel(result.bytes.byteLength)}. Download is ready.`,
  );
}
async function run() {
  if ($("run").disabled || state.busy || state.activeStage !== "config") return;
  showError("");
  state.busy = true;
  state.result = null;
  const revision = state.revision;
  const moveFocus =
    document.activeElement === $("run") || document.documentElement.dataset.input === "keyboard";
  $("result").hidden = true;
  $("output-empty").hidden = false;
  $("empty-title").textContent = "Obfuscating your module…";
  $("empty-description").textContent = "Processing…";
  refreshActions();
  if (moveFocus) $("cancel").focus();
  try {
    const result = await engine.run(state.file.bytes, state.config);
    if (revision === state.revision) showResult(result);
  } catch (error) {
    if (error.name === "AbortError")
      invalidate("Processing cancelled. Your module and configuration are ready for another run.");
    else {
      invalidate("No output was generated. Check the error and try again.");
      showError(error.message || String(error));
    }
  } finally {
    state.busy = false;
    refreshActions();
    if (state.result) openStage("output", true);
    else if (moveFocus) $("run").focus();
  }
}
function setOutputView(json) {
  if (json && state.result && !$("report-json").textContent)
    $("report-json").textContent = JSON.stringify(state.result.report, null, 2);
  $("json-view").hidden = !json;
  $("report-view").hidden = json;
  $("view-report").setAttribute("aria-pressed", String(!json));
  $("view-json").setAttribute("aria-pressed", String(json));
}
async function initialize() {
  $("retry").hidden = true;
  showError("");
  try {
    const metadata = await engine.ready();
    state.defaults = metadata.config;
    state.config = structuredClone(metadata.config);
    state.configSchema = metadata.configSchema;
    state.outputSchema = metadata.outputSchema;
    state.ready = true;
    syncForm();
    showStatus("");
  } catch (error) {
    state.ready = false;
    showError(`The Scrasm engine could not load. ${error.message || error}`);
    showStatus("");
    $("retry").hidden = false;
    refreshActions();
  }
}

for (const stage of stages) {
  $(`trigger-${stage}`).addEventListener("click", () => openStage(stage));
  $(`trigger-${stage}`).addEventListener("keydown", (event) => {
    const available = stages
      .map((name) => $(`trigger-${name}`))
      .filter((trigger) => !trigger.disabled);
    const index = available.indexOf(event.currentTarget);
    let target;
    if (event.key === "ArrowDown") target = available[(index + 1) % available.length];
    if (event.key === "ArrowUp")
      target = available[(index - 1 + available.length) % available.length];
    if (event.key === "Home") target = available[0];
    if (event.key === "End") target = available.at(-1);
    if (target) {
      event.preventDefault();
      target.focus();
    }
  });
}
$("continue-config").addEventListener("click", () => openStage("config", true));
buildTransformRows();
refreshStages();
$("config-form").addEventListener("submit", (event) => event.preventDefault());
$("config-form").addEventListener("input", readForm);
$("drop-zone").addEventListener("click", () => $("file-input").click());
$("file-input").addEventListener("change", (event) => selectFile(event.target.files[0]));
$("remove-file").addEventListener("click", removeFile);
$("example").addEventListener("click", () =>
  selectFile(new File([sampleBytes()], "example.wasm", { type: "application/wasm" })),
);
let dragDepth = 0;
$("drop-zone").addEventListener("dragenter", (event) => {
  event.preventDefault();
  if (!state.busy) {
    dragDepth++;
    $("drop-zone").classList.add("drag-over");
  }
});
$("drop-zone").addEventListener("dragover", (event) => {
  event.preventDefault();
  event.dataTransfer.dropEffect = state.busy ? "none" : "copy";
});
$("drop-zone").addEventListener("dragleave", () => {
  dragDepth--;
  if (dragDepth <= 0) $("drop-zone").classList.remove("drag-over");
});
$("drop-zone").addEventListener("drop", async (event) => {
  event.preventDefault();
  dragDepth = 0;
  $("drop-zone").classList.remove("drag-over");
  if (event.dataTransfer.files.length > 1) {
    showError("Choose one WebAssembly module at a time.");
    return;
  }
  await selectFile(event.dataTransfer.files[0]);
});
window.addEventListener("dragover", (event) => event.preventDefault());
window.addEventListener("drop", (event) => event.preventDefault());
$("run").addEventListener("click", run);
$("cancel").addEventListener("click", () => engine.cancel());
$("retry").addEventListener("click", initialize);
$("reset-config").addEventListener("click", () => {
  state.config = structuredClone(state.defaults);
  syncForm();
  invalidate("Defaults restored. Run Scrasm to generate new output.");
  showError("");
  announce("Scrasm defaults restored.");
});
$("export-config").addEventListener("click", () =>
  downloadJson(state.config, "scrasm-config.json"),
);
$("edit-json").addEventListener("click", () => {
  configImportRequest++;
  $("config-json").value = JSON.stringify(state.config, null, 2);
  $("json-error").hidden = true;
  $("config-dialog").showModal();
});
$("apply-config").addEventListener("click", () => {
  try {
    state.config = parseConfig($("config-json").value, state.defaults);
    syncForm();
    invalidate("Configuration updated. Run Scrasm to generate new output.");
    showError("");
    $("config-dialog").close();
    announce("Configuration applied.");
  } catch (error) {
    $("json-error").textContent = error.message;
    $("json-error").hidden = false;
    $("config-json").focus();
  }
});
$("import-config").addEventListener("click", () => $("config-file").click());
$("config-file").addEventListener("change", async (event) => {
  const file = event.target.files[0];
  if (!file) return;
  const request = ++configImportRequest;
  try {
    const contents = await file.text();
    if (request !== configImportRequest || !$("config-dialog").open) return;
    $("config-json").value = contents;
    $("json-error").hidden = true;
  } catch (error) {
    $("json-error").textContent = `Unable to read configuration: ${error.message}`;
    $("json-error").hidden = false;
  }
  event.target.value = "";
});
$("config-json").addEventListener("input", () => {
  configImportRequest++;
});
$("config-dialog").addEventListener("close", () => {
  configImportRequest++;
});
$("download-output-schema").addEventListener("click", () =>
  downloadJson(state.outputSchema, "scrasm-output.schema.json"),
);
$("download-schema").addEventListener("click", () =>
  downloadJson(state.configSchema, "scrasm-config.schema.json"),
);
$("download-wasm").addEventListener("click", () => {
  if (state.result) download(state.result.bytes, outputName(state.file.name), "application/wasm");
});
$("download-report").addEventListener("click", () => {
  if (state.result) downloadJson(state.result.report, "scrasm-result.json");
});
$("view-report").addEventListener("click", () => setOutputView(false));
$("view-json").addEventListener("click", () => setOutputView(true));
$("copy-report").addEventListener("click", async () => {
  try {
    await navigator.clipboard.writeText(JSON.stringify(state.result.report, null, 2));
    $("copy-report").textContent = "Copied";
    announce("Report copied to clipboard.");
    setTimeout(() => {
      $("copy-report").textContent = "Copy JSON";
    }, 1800);
  } catch {
    announce("Clipboard unavailable. Use Download report to save the full JSON.");
    $("copy-report").textContent = "Use download instead";
  }
});
if (!/Mac|iPhone|iPad/.test(navigator.platform)) $("shortcut").textContent = "Ctrl ↵";
document.addEventListener("keydown", async (event) => {
  document.documentElement.dataset.input = "keyboard";
  if ((event.metaKey || event.ctrlKey) && event.key === "Enter" && !$("config-dialog").open) {
    event.preventDefault();
    await run();
  }
});
document.addEventListener("pointerdown", () => {
  document.documentElement.dataset.input = "pointer";
});

await initialize();
