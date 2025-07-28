# Task: Integrate Quest System with Main Game State and Rewards

**Problem:** The quest system needs to be integrated into the main game state management, including quest data persistence, progress tracking, and reward distribution when quests are completed.

**Dependencies:** Task 1 (Define Quest System Data Model and Types), Task 3 (Implement Quest Progress and Completion Logic), Task 4 (Design Sample Quests with Resource Requirements)

**Plan:**
1. Add quest-related fields to the Game type in Types.elm: `quests: QuestRecord Quest` (quest configs) and `questProgress: QuestRecord QuestProgress` (player progress tracking)
2. Add necessary fields to Game init
3. Add quest-related message types to FrontendMsg to handle quest interactions: `HandleQuestDepositClick QuestKind Resource Int` for deposit interactions and toast messages for quest completion notifications
4. Implement quest message handlers in the main game update function
5. Connect quest progress updates and completion rewards to the existing effect system (same system handles both resource costs and coin rewards)
6. Replace placeholder quests in the UI with real quest data from the game state
7. Test integration with existing game systems (resources, coins, effects)

**Success Criteria:**
- Quest data fields (`quests`, `questProgress`) are properly added to Game type
- Quest progress is tracked and persisted across game sessions
- Quest-related messages are handled correctly in game update logic
- Resource deposits properly update quest progress through existing effect system
- Quest completion triggers appropriate coin rewards via existing effect system
- Placeholder quests in UI are replaced with real quest data from game state
- Integration works seamlessly with existing game systems
- Code compiles without errors