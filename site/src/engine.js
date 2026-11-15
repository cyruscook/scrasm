export function createEngine({
  onStatus = () => {},
  workerFactory = () => new Worker(new URL("./worker.js", import.meta.url), { type: "module" }),
  moduleUrl,
} = {}) {
  let worker;
  let loading;
  let initialization;
  let pendingRun;
  let disposed = false;
  let generation = 0;

  function reset(error) {
    generation++;
    worker?.terminate();
    worker = undefined;
    loading = undefined;
    initialization?.reject(error);
    initialization = undefined;
    pendingRun?.reject(error);
    pendingRun = undefined;
  }

  function ready() {
    if (disposed) return Promise.reject(new Error("The engine has been disposed."));
    if (loading) return loading;
    onStatus("loading");
    loading = new Promise((resolve, reject) => {
      initialization = { resolve, reject };
    });
    const result = loading;
    try {
      worker = workerFactory();
      worker.onmessage = ({ data }) => {
        if (data.type === "ready") {
          initialization?.resolve(data);
          initialization = undefined;
          onStatus("ready");
        } else if (data.type === "result") {
          pendingRun?.resolve(data);
          pendingRun = undefined;
          onStatus("ready");
        } else if (data.type === "error") {
          const error = new Error(data.message);
          if (initialization) reset(error);
          else {
            pendingRun?.reject(error);
            pendingRun = undefined;
          }
          onStatus("error");
        }
      };
      worker.onerror = (event) => {
        event.preventDefault();
        reset(new Error(event.message || "The WASM engine stopped unexpectedly. Try again."));
        onStatus("error");
      };
      worker.onmessageerror = () => {
        reset(new Error("The browser could not read the engine response. Try again."));
        onStatus("error");
      };
      worker.postMessage({
        type: "init",
        moduleUrl: moduleUrl ?? new URL("wasm/scrasm_web.js", document.baseURI).href,
      });
    } catch (error) {
      reset(error);
      onStatus("error");
    }
    return result;
  }

  async function run(bytes, config) {
    if (pendingRun) throw new Error("An obfuscation is already running.");
    const startedGeneration = generation;
    await ready();
    if (startedGeneration !== generation) {
      throw new DOMException("Obfuscation cancelled.", "AbortError");
    }
    if (pendingRun) throw new Error("An obfuscation is already running.");
    return new Promise((resolve, reject) => {
      pendingRun = { resolve, reject };
      try {
        const copy = bytes.slice();
        worker.postMessage({ type: "run", bytes: copy, config: JSON.stringify(config) }, [
          copy.buffer,
        ]);
        onStatus("running");
      } catch (error) {
        pendingRun = undefined;
        reject(error);
        onStatus("error");
      }
    });
  }

  function cancel() {
    reset(new DOMException("Obfuscation cancelled. Your input is unchanged.", "AbortError"));
    onStatus("idle");
  }

  return {
    ready,
    run,
    cancel,
    dispose() {
      disposed = true;
      cancel();
    },
  };
}

export function sampleBytes() {
  const string = (value) => {
    const bytes = [...new TextEncoder().encode(value)];
    return [bytes.length, ...bytes];
  };
  const section = (id, bytes) => [id, bytes.length, ...bytes];
  const bodies = [
    [0, 32, 0, 32, 1, 106, 11],
    [0, 32, 0, 32, 1, 16, 0, 11],
    [0, 32, 0, 32, 1, 107, 11],
  ];
  return new Uint8Array([
    0,
    97,
    115,
    109,
    1,
    0,
    0,
    0,
    ...section(1, [1, 96, 2, 127, 127, 1, 127]),
    ...section(3, [3, 0, 0, 0]),
    ...section(5, [1, 0, 1]),
    ...section(7, [2, ...string("add"), 0, 1, ...string("memory"), 2, 0]),
    ...section(10, [bodies.length, ...bodies.flatMap((body) => [body.length, ...body])]),
    ...section(11, [1, 0, 65, 0, 11, ...string("Hello from Scrasm")]),
    ...section(0, [...string("scrasm-example"), ...string("Example source metadata")]),
  ]);
}
