# Task: Define Quest System Data Model and Types

**Problem:** The game needs a new quest system that allows players to deposit resources to make progress and complete quests for rewards. This requires defining the core data structures and types that will represent quests, their states, and requirements.

**Dependencies:** None

**Plan:**
1. Examine existing Activity and Resource types in the codebase to understand current patterns and naming conventions
2. Define a QuestKind union type following the codebase pattern (e.g., `QuestKind = GatherSupplies | StudyAncientTexts | ...`)
3. Create a Quest type that includes: kind, name, description, resource requirements, coin reward amount, and completion status
4. Define a QuestProgress type to track player progress on individual quests
5. Define quest-related union types for different quest states (Available, InProgress, Completed)
6. Add all quest-related types to the main Types.elm file in their own section for frontend/backend sharing
7. Create a new Quests.elm file with helper functions for quest type manipulation (checking completion, calculating progress percentages)
8. Ensure quest types integrate properly with the existing game state structure

**Success Criteria:** 
- QuestKind union type is defined following codebase conventions
- Quest and QuestProgress types are defined with all necessary fields
- Quest states are properly typed with union types
- Types are added to shared Types.elm in dedicated quest section
- Quests.elm file created with helper functions for common quest operations
- Code compiles without errors after type additions