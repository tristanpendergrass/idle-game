# Task: Create Quest UI Components and Tab

**Problem:** Players need a dedicated interface to view available quests, track their progress, and interact with the quest system. This requires creating UI components that display quest information and a new tab in the main navigation.

**Dependencies:** Task 1 (Define Quest System Data Model and Types)

**Plan:**
1. Add `Quests` to the Tab union type in IdleGame/Tab.elm
2. Add a case for `Quests` in the `getConfig` function with appropriate title and icon
3. Add quest tab handling to IdleGame/Views/Content.elm in the `renderContent` function case statement
4. Add quest tab to the drawer menu in IdleGame/Views/Drawer.elm (in the main menu list with Home, Backpack, Shop, Combat)
5. Examine existing UI patterns in Views/ directory, particularly Activity.elm for card-based layouts
6. Create a new Views/Quest.elm file with functions to render individual quest cards
7. Design quest card UI that shows: quest name, description, resource requirements, progress, and completion status
8. Add deposit/interaction buttons to quest cards for resource submission
9. Create a main quest list view that displays all available quests in a grid or list format
10. Create placeholder quest data (2-3 sample quests) at various completion stages: one unstarted, one partially completed with specific progress amounts, and one fully completed
11. Style quest cards to be visually distinct from activity cards while maintaining UI consistency
12. Add appropriate icons and visual indicators for quest progress and completion states
13. Write Playwright test cases to verify quest tab navigation and quest card display

**Success Criteria:**
- `Quests` tab added to Tab union type and getConfig function
- Quest tab appears in main navigation drawer
- Quest tab routing works in Content.elm
- Quest.elm view file created with quest card rendering functions
- Quest cards display all necessary information using placeholder data at different completion stages
- Quest UI is visually consistent with existing game design
- Quest cards are clearly distinguishable from activity cards
- Playwright tests pass verifying quest tab can be clicked and quest cards are displayed properly with different completion states
- Code compiles and UI renders without errors