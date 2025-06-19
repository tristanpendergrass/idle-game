import { test, expect } from "@playwright/test";

test("shows Games text", async ({ page }) => {
  await page.goto("http://localhost:8000");
  await expect(page.getByText("Games")).toBeVisible();
});
