# Task: Implement Quest Progress and Completion Logic

**Problem:** The quest system needs core mechanics to track player progress when resources are deposited, detect when quests are completed, and handle state transitions between different quest phases.

**Dependencies:** Task 1 (Define Quest System Data Model and Types), Task 2 (Create Quest UI Components and Tab)

**Plan:**
1. Create quest progress tracking functions in Quests.elm to calculate completion percentages
2. Leverage existing resource deposit validation in the codebase (don't reinvent the wheel)
3. Create quest completion detection logic that determines when requirements are fully met
4. Implement quest progress update functions that modify quest state when resources are deposited (quest state transitions happen automatically as resources are deposited)
5. Create reward application logic that converts the coin reward amount from quest config to gainCoin effect when quest is completed

**Success Criteria:**
- Quest progress calculation functions work correctly with various resource amounts
- Existing resource deposit validation is properly utilized
- Quest completion detection accurately identifies when requirements are met
- Quest progress updates correctly modify quest state automatically as resources are deposited
- Quest completion rewards are converted from coin reward amount to gainCoin effect and applied correctly
- Code compiles without errors