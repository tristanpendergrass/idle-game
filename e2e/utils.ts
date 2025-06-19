import { Page, expect } from '@playwright/test';

export async function createAndEnterGame(page: Page) {
  await page.goto('http://localhost:8000');
  await page.getByRole('button', { name: 'New Game' }).click();
  await page.getByRole('button', { name: 'Game 1' }).click();
  await expect(
    page.getByRole('navigation').getByText('Home')
  ).toBeVisible();
}

export async function navigateToTab(page: Page, tabName: string) {
  // Drawer control is a label acting as a button.
  const drawerToggle = page
    .getByRole('navigation')
    .locator('label.drawer-button[for="drawer"]');
  if (await drawerToggle.isVisible()) {
    await drawerToggle.click();
  }
  await page.getByText(tabName).click();
  await expect(
    page.getByRole('navigation').getByText(tabName)
  ).toBeVisible();
}

export async function startActivity(page: Page, activityName: string) {
  await page.getByRole('heading', { level: 2, name: activityName }).first().click();
  await expect(
    page.getByRole('heading', { level: 2, name: activityName }).nth(1)
  ).toBeVisible();
}
