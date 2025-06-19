import { test } from '@playwright/test';
import { createAndEnterGame, navigateToTab, startActivity } from './utils';

test('start Gather Sage', async ({ page }) => {
  await createAndEnterGame(page);
  await navigateToTab(page, 'Herb Gathering');
  await startActivity(page, 'Gather Sage');
});
