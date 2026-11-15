export async function runFlowChecks() {
  const by = (id) => document.getElementById(id);
  const check = (condition, message) => {
    if (!condition) throw new Error(message);
  };
  const until = async (predicate) => {
    for (let i = 0; i < 100; i++) {
      if (predicate()) return;
      await new Promise((resolve) => setTimeout(resolve, 30));
    }
    throw new Error("Timed out waiting for the interface.");
  };
  const active = () =>
    ["module", "config", "output"].filter((stage) => !by(`panel-${stage}`).hidden).join(",");
  const selectFile = (bytes, name) => {
    const transfer = new DataTransfer();
    transfer.items.add(new File([bytes], name, { type: "application/wasm" }));
    by("file-input").files = transfer.files;
    by("file-input").dispatchEvent(new Event("change", { bubbles: true }));
  };
  check(by("panel-module"), "The three-stage accordion must exist.");
  await until(() => !by("edit-json").disabled);
  check(active() === "module", "Start with only Module expanded.");
  check(by("engine-status").hidden, "Hide successful engine initialization.");
  by("example").click();
  await until(() => active() === "config");
  check(
    by("summary-module").textContent.includes("example.wasm"),
    "Retain the filename in the collapsed stage.",
  );
  const legacy = document.querySelector("[name=compatibility][value=Legacy]");
  legacy.checked = true;
  legacy.dispatchEvent(new Event("input", { bubbles: true }));
  by("edit-json").click();
  check(
    JSON.parse(by("config-json").value).capabilities.minimum_required_support === "Legacy",
    "Compatibility choices must update configuration.",
  );
  by("config-json").value = '{"capabilities":{"minimum_required_support":"Modern"}}';
  by("apply-config").click();
  check(
    document.querySelector("[name=compatibility][value=Modern]").checked,
    "JSON must update compatibility choices.",
  );
  by("trigger-module").click();
  document.dispatchEvent(
    new KeyboardEvent("keydown", {
      key: "Enter",
      ctrlKey: true,
      bubbles: true,
    }),
  );
  await new Promise((resolve) => setTimeout(resolve, 100));
  check(active() === "module", "The run shortcut must not execute a hidden configuration stage.");
  by("continue-config").click();
  by("run").click();
  await until(() => active() === "output");
  check(!by("result").hidden, "Only advance to Output after a successful run.");
  by("trigger-config").click();
  check(active() === "config", "Allow revisiting Configuration.");
  check(
    !by("trigger-output").disabled,
    "Keep a valid previous result accessible while reviewing settings.",
  );
  by("enable-call_graph").click();
  check(
    by("trigger-output").disabled && by("result").hidden,
    "Changing settings invalidates the previous output.",
  );
  by("run").click();
  by("cancel").click();
  await until(() => !by("run").hidden);
  check(
    active() === "config" && by("error").hidden,
    "Cancellation returns to editable Configuration without an error.",
  );
  by("trigger-module").click();
  selectFile(Uint8Array.of(0, 97, 115, 109, 1, 0, 0, 0, 1), "invalid.wasm");
  await until(() => active() === "config");
  by("run").click();
  await until(() => !by("error").hidden);
  check(
    active() === "config" && by("trigger-output").disabled,
    "A processing error must retain Configuration and block stale Output.",
  );
  by("trigger-module").click();
  by("remove-file").click();
  check(
    active() === "module" && by("trigger-config").disabled && by("trigger-output").disabled,
    "Removing the module resets progression.",
  );
  return { passed: 14 };
}
