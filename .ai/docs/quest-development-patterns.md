# Quest Development Patterns

## Adding New Quest Types

### Step 1: Define the Quest Kind

Add new variants to the `QuestKind` union type following the established pattern:

```elm
-- In IdleGame/Quest.elm or appropriate module
type QuestKind
    = GatherResources GatherResourcesParams
    | CraftSpells CraftSpellsParams
    -- ... existing types
    | NewQuestType NewQuestTypeParams -- New quest type

-- Define parameter type following naming convention
type alias NewQuestTypeParams =
    { requiredField : RequiredType
    , optionalField : Maybe OptionalType
    , listField : List ItemType
    }
```

### Step 2: Update QuestRecord

Extend the QuestRecord following the established record pattern:

```elm
type alias QuestRecord a =
    { gatherHerbs : a
    , learnBasicMagic : a
    -- ... existing quests
    , newQuestName : a -- Add new quest slot
    }

-- Update helper functions
questRecord : a -> QuestRecord a
questRecord a =
    { gatherHerbs = a
    , learnBasicMagic = a
    -- ... existing fields
    , newQuestName = a -- Initialize new field
    }

getByQuest : QuestKind -> QuestRecord a -> a
getByQuest kind data =
    case kind of
        GatherResources _ ->
            data.gatherHerbs
        -- ... existing cases
        NewQuestType _ ->
            data.newQuestName

setByQuest : QuestKind -> a -> QuestRecord a -> QuestRecord a  
setByQuest kind value data =
    case kind of
        GatherResources _ ->
            { data | gatherHerbs = value }
        -- ... existing cases
        NewQuestType _ ->
            { data | newQuestName = value }
```

### Step 3: Update Progress Tracking

Add progress tracking for the new quest type:

```elm
type QuestProgress
    = ResourceGatherProgress Int
    -- ... existing progress types
    | NewQuestProgress CustomProgressType -- Add new progress type

-- Update progress tracking logic
updateQuestProgress : List Effect -> Quest -> Quest
updateQuestProgress effects quest =
    case quest.questKind of
        -- ... existing cases
        NewQuestType params ->
            updateNewQuestProgress effects params quest
```

### Step 4: Implement Quest Logic

Create quest-specific logic following established patterns:

```elm
-- Quest initialization
initializeNewQuest : NewQuestTypeParams -> Quest
initializeNewQuest params =
    { questKind = NewQuestType params
    , progress = NewQuestProgress initialValue
    , status = QuestAvailable
    , timeStarted = Nothing
    , rewards = calculateNewQuestRewards params
    }

-- Progress calculation
updateNewQuestProgress : List Effect -> NewQuestTypeParams -> Quest -> Quest
updateNewQuestProgress effects params quest =
    let
        relevantEffects = 
            effects |> List.filter (isRelevantToNewQuest params)
        
        progressDelta = 
            relevantEffects |> List.map extractProgress |> List.sum
        
        updatedProgress =
            case quest.progress of
                NewQuestProgress current ->
                    NewQuestProgress (current + progressDelta)
                
                _ ->
                    quest.progress
    in
    { quest | progress = updatedProgress }

-- Completion check
isNewQuestComplete : NewQuestTypeParams -> QuestProgress -> Bool
isNewQuestComplete params progress =
    case progress of
        NewQuestProgress current ->
            current >= params.targetAmount
        
        _ ->
            False
```

## Naming Conventions

### Quest Types
- Use descriptive, action-oriented names: `GatherResources`, `CompleteActivities`
- Follow PascalCase for union type variants
- Include parameter suffix for parameter types: `GatherResourcesParams`

### Quest Instances  
- Use camelCase for quest record fields: `gatherHerbs`, `learnBasicMagic`
- Make names descriptive of the quest's purpose or theme
- Keep medical school theme context: `clinicalRotation`, `examPrep`

### Progress Types
- Follow pattern: `[QuestType]Progress`
- Use meaningful base types: `Int` for counts, `Duration` for time
- Custom progress types for complex tracking: `MultiObjectiveProgress`

### Functions
- Initialization: `initialize[QuestType] : Params -> Quest`
- Updates: `update[QuestType]Progress : Effects -> Params -> Quest -> Quest`
- Validation: `is[QuestType]Complete : Params -> Progress -> Bool`
- Effects: `[questType]CompletionEffects : Params -> List Effect`

## Testing Approaches

### Unit Tests

Create comprehensive unit tests for each quest type following established patterns:

```elm
-- QuestTests.elm
module QuestTests exposing (..)

import Test exposing (..)
import Expect
import IdleGame.Quest as Quest

questTests : Test
questTests =
    describe "Quest System"
        [ describe "NewQuestType"
            [ test "initializes with correct progress" <|
                \_ ->
                    let
                        params = { targetAmount = 10 }
                        quest = Quest.initializeNewQuest params
                    in
                    quest.progress
                        |> Expect.equal (Quest.NewQuestProgress 0)
            
            , test "updates progress correctly" <|
                \_ ->
                    let
                        params = { targetAmount = 10 }
                        quest = Quest.initializeNewQuest params
                        effects = [ createTestEffect 5 ]
                        updatedQuest = Quest.updateQuestProgress effects quest
                    in
                    case updatedQuest.progress of
                        Quest.NewQuestProgress progress ->
                            progress |> Expect.equal 5
                        
                        _ ->
                            Expect.fail "Wrong progress type"
            
            , test "detects completion correctly" <|
                \_ ->
                    let
                        params = { targetAmount = 10 }
                        progress = Quest.NewQuestProgress 10
                    in
                    Quest.isNewQuestComplete params progress
                        |> Expect.equal True
            ]
        ]
```

### Integration Tests

Test quest integration with game systems:

```elm
integrationTests : Test  
integrationTests =
    describe "Quest Integration"
        [ test "quest completion updates game state" <|
            \_ ->
                let
                    game = Game.createTest
                    quest = createTestQuest
                    (updatedGame, effects) = Quest.completeQuest quest game
                in
                updatedGame.completedQuests
                    |> List.member quest.questKind
                    |> Expect.equal True
        
        , test "quest rewards are applied correctly" <|
            \_ ->
                let
                    game = Game.createTest
                    quest = createCoinRewardQuest 100
                    (updatedGame, _) = Quest.completeQuest quest game
                in
                Coin.toInt updatedGame.coin
                    |> Expect.equal 100
        ]
```

### Performance Tests

Add quest-specific performance tests:

```elm
-- In PerfTesting directory
questPerformanceTests : Test
questPerformanceTests =
    describe "Quest Performance"
        [ test "multiple quest updates complete within time limit" <|
            \_ ->
                let
                    game = createGameWithManyQuests
                    effects = createManyEffects
                    startTime = Time.millisToPosix 0
                    
                    (_, duration) = 
                        measureTime (\_ -> Quest.updateAllQuests effects game)
                in
                Duration.inMilliseconds duration
                    |> Expect.lessThan 100 -- Should complete in <100ms
        ]
```

## Performance Considerations

### Efficient Progress Tracking

```elm
-- Batch quest updates instead of individual updates
updateAllQuests : List Effect -> Game -> Game
updateAllQuests effects game =
    let
        updateSingleQuest maybeQuest =
            case maybeQuest of
                Just quest ->
                    quest
                        |> updateQuestProgress effects
                        |> checkQuestCompletion
                        |> Just
                
                Nothing ->
                    Nothing
    in
    { game | activeQuests = mapQuests updateSingleQuest game.activeQuests }
```

### Memory Management

```elm
-- Limit number of active quests to prevent memory bloat
maxActiveQuests : Int
maxActiveQuests = 5

-- Clean up completed quests periodically
cleanupQuests : Game -> Game
cleanupQuests game =
    let
        activeCount = countActiveQuests game.activeQuests
    in
    if activeCount > maxActiveQuests then
        archiveOldestCompletedQuests game
    else
        game
```

### Lazy Evaluation

```elm
-- Only calculate quest progress for relevant effects
updateQuestProgress : List Effect -> Quest -> Quest  
updateQuestProgress effects quest =
    let
        relevantEffects = 
            effects
                |> List.filter (isEffectRelevantToQuest quest)
    in
    if List.isEmpty relevantEffects then
        quest
    else
        applyEffectsToQuest relevantEffects quest
```

## Medical School Theme Guidelines

### Quest Naming
- Use medical terminology appropriately: "Clinical Rotation", "Lab Practicum"
- Reference educational milestones: "First Year Completion", "Boards Preparation"  
- Include institutional elements: "Dean's Challenge", "Study Group Formation"

### Quest Progression
- Follow medical school timeline: Pre-clinical → Clinical → Specialization
- Include realistic challenges: Time management, resource allocation, skill development
- Reward academic achievement: Knowledge points, skill advancement, recognition

### Quest Categories
- **Academic**: Course completion, exam preparation, research projects
- **Clinical**: Patient interactions, diagnostic challenges, treatment planning  
- **Professional**: Ethics scenarios, continuing education, certification
- **Social**: Study groups, mentoring, peer collaboration

### Example Quest Themes

```elm
-- Early game quests introduce basic concepts
beginnerQuests : List QuestKind
beginnerQuests =
    [ GatherResources { targetResource = Parchment, amount = 5, timeLimit = Nothing } -- "Textbook Collection"
    , CompleteActivities { activities = [GatherSage], completionsNeeded = 3, anyActivity = False } -- "Basic Herbology"
    , ReachSkillLevel { skill = HerbGathering, targetLevel = 2, timeLimit = Nothing } -- "Foundations Mastery"
    ]

-- Advanced quests require mastery and resource management  
advancedQuests : List QuestKind
advancedQuests = 
    [ TimedChallenge { objectives = multipleObjectives, timeLimit = Duration.hours 2, failOnTimeout = True } -- "Comprehensive Exam"
    , EarnCoins { targetAmount = Coin.int 1000, mustEarnNotPossess = True, timeLimit = Just (Duration.days 7) } -- "Research Grant"
    , CraftSpells { spellType = SpellBloom, quantity = 10, requiredSkillLevel = Just 5 } -- "Advanced Spellwork"
    ]
```

This development pattern ensures consistency with the existing codebase architecture while providing flexibility for diverse quest mechanics that enhance the medical school idle game experience.