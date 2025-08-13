# Quest Types Reference

## QuestKind Union Type

The `QuestKind` union type defines all available quest types in the game. Following the codebase convention of using descriptive union variants without ID fields, each quest kind directly represents its type.

```elm
type QuestKind
    = GatherResources GatherResourcesParams
    | CraftSpells CraftSpellsParams
    | ReachSkillLevel ReachSkillLevelParams
    | CompleteActivities CompleteActivitiesParams
    | EarnCoins EarnCoinsParams
    | SpendResources SpendResourcesParams
    | TimedChallenge TimedChallengeParams
```

### Quest Type Definitions

#### GatherResources
Requires player to collect specific amounts of resources.

**Parameters:**
```elm
type alias GatherResourcesParams =
    { targetResource : Resource
    , amount : Int
    , timeLimit : Maybe Duration
    }
```

**Example Usage:**
- "Gather 10 Sage herbs"
- "Collect 5 Parchment within 30 minutes"
- "Obtain 20 Nettle for herbology research"

#### CraftSpells
Tasks player with creating magical spells through crafting activities.

**Parameters:**
```elm
type alias CraftSpellsParams =
    { spellType : Resource -- SpellHerbSense, SpellBloom, etc.
    , quantity : Int
    , requiredSkillLevel : Maybe Int
    }
```

**Example Usage:**
- "Craft 3 Herb Sense spells"
- "Create 1 Bloom spell (requires Wild Magic level 2)"
- "Master spellcrafting by making 5 different spell types"

#### ReachSkillLevel
Challenges player to advance their skills to specific levels.

**Parameters:**
```elm
type alias ReachSkillLevelParams =
    { skill : Skill
    , targetLevel : Int
    , timeLimit : Maybe Duration
    }
```

**Example Usage:**
- "Reach Herb Gathering level 5"
- "Advance Wild Magic to level 3 within 1 hour"
- "Master all skills to level 10"

#### CompleteActivities
Requires completing specific activities a certain number of times.

**Parameters:**
```elm
type alias CompleteActivitiesParams =
    { activities : List Activity
    , completionsNeeded : Int
    , anyActivity : Bool -- If true, any from the list counts
    }
```

**Example Usage:**
- "Complete Gather Sage 5 times"
- "Finish any gathering activity 10 times"
- "Complete both Craft Spell activities once each"

#### EarnCoins
Tasks player with accumulating a specific amount of coins.

**Parameters:**
```elm
type alias EarnCoinsParams =
    { targetAmount : Coin
    , mustEarnNotPossess : Bool -- If true, spending coins doesn't reduce progress
    , timeLimit : Maybe Duration
    }
```

**Example Usage:**
- "Earn 100 coins"
- "Accumulate 500 coins without spending"
- "Generate 50 coins within 20 minutes"

#### SpendResources
Requires player to spend or consume specific resources.

**Parameters:**
```elm
type alias SpendResourcesParams =
    { targetResource : Resource
    , amount : Int
    , specificActivity : Maybe Activity -- If specified, must spend on this activity
    }
```

**Example Usage:**
- "Spend 20 Parchment on any activity"
- "Use 5 Sage specifically for Craft Spell activities"
- "Consume 100 total resources of any type"

#### TimedChallenge
Combines multiple objectives within a strict time limit.

**Parameters:**
```elm
type alias TimedChallengeParams =
    { objectives : List QuestObjective
    , timeLimit : Duration
    , failOnTimeout : Bool
    }
```

## Quest Record Type

The main quest data structure that tracks individual quest instances:

```elm
type alias Quest =
    { questKind : QuestKind
    , progress : QuestProgress
    , status : QuestStatus
    , timeStarted : Maybe Posix
    , rewards : QuestRewards
    }
```

### Field Descriptions

**questKind**: Defines the specific type and parameters of the quest.

**progress**: Tracks completion progress for the quest.

**status**: Current state of the quest (Available, InProgress, Completed, Failed).

**timeStarted**: Timestamp when quest was initiated (Nothing if not started).

**rewards**: Rewards granted upon successful completion.

## QuestProgress Type

Tracks completion progress for different quest types:

```elm
type QuestProgress
    = ResourceGatherProgress Int -- Amount collected so far
    | ActivityCompleteProgress Int -- Number of completions
    | SkillLevelProgress Xp -- Current XP toward target level
    | CoinEarnProgress Coin -- Amount earned toward target
    | MultiObjectiveProgress (List ObjectiveProgress) -- For complex quests
    | NoProgress -- For quests that are instantly checkable
```

## QuestStatus Type

Represents the current state of a quest:

```elm
type QuestStatus
    = QuestAvailable -- Can be started
    | QuestInProgress -- Currently active
    | QuestCompleted Posix -- Completed at timestamp
    | QuestFailed String -- Failed with reason
```

## QuestRewards Type

Defines rewards granted upon quest completion:

```elm
type alias QuestRewards =
    { coins : Maybe Coin
    , resources : ResourceRecord Int
    , experience : SkillRecord Xp
    , masteryXp : ActivityRecord Xp
    , unlocks : List QuestUnlock -- Special unlocks like new quest types
    }
```

## QuestRecord Pattern

Following the codebase convention, quests are managed through a record pattern for type-safe access:

```elm
type alias QuestRecord a =
    { gatherHerbs : a
    , learnBasicMagic : a
    , firstSpellcraft : a
    , skillMastery : a
    , resourceManagement : a
    , timeChallenge : a
    }

-- Helper functions follow the established pattern:
getByQuest : QuestKind -> QuestRecord a -> a
setByQuest : QuestKind -> a -> QuestRecord a -> QuestRecord a
questRecord : a -> QuestRecord a
```

## Medical School Theme Examples

### Introductory Quests
- **"First Day Orientation"**: Gather 5 Sage and 3 Parchment
- **"Basic Herbology"**: Complete Gather Sage activity 3 times
- **"Spell Theory"**: Craft 1 Herb Sense spell

### Intermediate Quests
- **"Advanced Studies"**: Reach Herb Gathering level 5
- **"Research Project"**: Spend 50 Parchment on spell crafting
- **"Lab Practical"**: Earn 200 coins from activities

### Advanced Quests
- **"Comprehensive Exam"**: Complete 10 different activities
- **"Thesis Defense"**: Reach level 10 in any skill
- **"Clinical Challenge"**: Complete multiple objectives within time limit

### Special Event Quests
- **"Study Group"**: Collaborative objectives (future feature)
- **"Finals Week"**: Intense time-limited challenges
- **"Summer Research"**: Long-term seasonal objectives

This type system provides flexibility for diverse quest mechanics while maintaining type safety and following established codebase patterns.