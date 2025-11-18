import { test, expect } from "@playwright/test";
import { createAndEnterGame, navigateToTab, startActivity } from "./utils";

test("start Gather Sage", async ({ page }) => {
  await createAndEnterGame(page);
  await navigateToTab(page, "Herb Gathering");
  await startActivity(page, "Gather Sage");
});

test("switch tab and reload page", async ({ page }) => {
  await createAndEnterGame(page);
  await navigateToTab(page, "Herb Gathering");
  await page.reload();
  await expect(
    page.getByRole("navigation").getByText("Herb Gathering")
  ).toBeVisible();
});
