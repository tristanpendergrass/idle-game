import { defineConfig } from "@playwright/test";

export default defineConfig({
  webServer: {
    command: "lamdera live",
    port: 8000,
    timeout: 120 * 1000,
    reuseExistingServer: !process.env.CI,
  },
  testDir: "e2e",
});
