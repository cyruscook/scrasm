let engine;

self.onmessage = async ({ data }) => {
  try {
    if (data.type === "init") {
      engine = await import(/* @vite-ignore */ data.moduleUrl);
      await engine.default();
      self.postMessage({
        type: "ready",
        config: JSON.parse(engine.default_config()),
        configSchema: JSON.parse(engine.config_schema()),
        outputSchema: JSON.parse(engine.output_schema()),
      });
    } else if (data.type === "run") {
      if (!engine) throw new Error("The WASM engine is not ready.");
      const started = performance.now();
      const result = engine.obfuscate(data.bytes, data.config);
      try {
        const bytes = result.bytes;
        const report = JSON.parse(result.report);
        self.postMessage(
          {
            type: "result",
            bytes,
            report,
            elapsedMs: performance.now() - started,
          },
          [bytes.buffer],
        );
      } finally {
        result.free();
      }
    }
  } catch (error) {
    self.postMessage({
      type: "error",
      message: error instanceof Error ? error.message : String(error),
    });
  }
};
