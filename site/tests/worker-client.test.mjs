import { test, expect } from "vite-plus/test";
import { createEngine, sampleBytes } from "../src/engine.js";

function fixture() {
  const workers = [];
  const engine = createEngine({
    moduleUrl: "http://localhost/project/wasm/scrasm_web.js",
    workerFactory() {
      const worker = {
        messages: [],
        postMessage(message) {
          this.messages.push(message);
        },
        terminate() {
          this.terminated = true;
        },
        reply(data) {
          this.onmessage({ data });
        },
      };
      workers.push(worker);
      return worker;
    },
  });
  return { engine, workers };
}

test("initializes using the page-relative WASM URL and preserves input for reruns", async () => {
  const { engine, workers } = fixture();
  const loading = engine.ready();
  expect(workers[0].messages[0].moduleUrl).toBe("http://localhost/project/wasm/scrasm_web.js");
  workers[0].reply({
    type: "ready",
    config: {},
    configSchema: {},
    outputSchema: {},
  });
  await loading;
  const bytes = sampleBytes();
  const running = engine.run(bytes, {});
  await Promise.resolve();
  const request = workers[0].messages.at(-1);
  expect(request.type).toBe("run");
  expect(request.bytes.buffer).not.toBe(bytes.buffer);
  workers[0].reply({
    type: "result",
    bytes: request.bytes,
    report: { reports: {} },
    elapsedMs: 1,
  });
  expect((await running).bytes.length).toBe(bytes.length);
  engine.dispose();
});

test("cancel terminates work, rejects the pending run, and permits a fresh worker", async () => {
  const { engine, workers } = fixture();
  const loading = engine.ready();
  workers[0].reply({ type: "ready", config: {} });
  await loading;
  const running = engine.run(sampleBytes(), {});
  await Promise.resolve();
  const rejected = expect(running).rejects.toMatchObject({ name: "AbortError" });
  engine.cancel();
  await rejected;
  expect(workers[0].terminated).toBe(true);
  const reloading = engine.ready();
  workers[1].reply({ type: "ready", config: {} });
  await reloading;
  engine.dispose();
});

test("worker crashes reject work and allow recovery", async () => {
  const { engine, workers } = fixture();
  const loading = engine.ready();
  const rejected = expect(loading).rejects.toThrow(/engine failed/i);
  workers[0].onerror({ message: "engine failed", preventDefault() {} });
  await rejected;
  const retry = engine.ready();
  workers[1].reply({ type: "ready", config: {} });
  await retry;
  engine.dispose();
});

test("cancelling immediately after run rejects with AbortError", async () => {
  const { engine, workers } = fixture();
  const loading = engine.ready();
  workers[0].reply({ type: "ready", config: {} });
  await loading;
  const running = engine.run(sampleBytes(), {});
  const rejected = expect(running).rejects.toMatchObject({ name: "AbortError" });
  engine.cancel();
  await rejected;
  engine.dispose();
});

test("example is an executable module", async () => {
  const { instance } = await WebAssembly.instantiate(sampleBytes());
  expect(instance.exports.add(19, 23)).toBe(42);
});
