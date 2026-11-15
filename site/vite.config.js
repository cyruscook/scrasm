import { defineConfig } from "vite-plus";

export default defineConfig({
  base: "./",
  server: { host: "127.0.0.1" },
  preview: { host: "127.0.0.1" },
  worker: { format: "es" },
  build: { target: "es2022" },
  test: { include: ["tests/*.test.mjs"] },
  fmt: { ignorePatterns: ["dist/**", "public/wasm/**"] },
  lint: {
    ignorePatterns: ["dist/**", "public/wasm/**"],
    jsPlugins: [{ name: "vite-plus", specifier: "vite-plus/oxlint-plugin" }],
    rules: { "vite-plus/prefer-vite-plus-imports": "error" },
    options: { typeAware: true, typeCheck: true },
  },
});
