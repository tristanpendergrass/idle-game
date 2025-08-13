# Quest Integration Guide

## Overview

The quest system integrates deeply with existing game systems while maintaining the separation of concerns established in the codebase. This guide details how quests interact with resources, coins, activities, and game state management.

## Resource System Integration

### Resource Requirements

Quests can require specific resources to start or progress:

```elm
-- Example quest that requires resources to begin
canStartQuest : Quest -> Game -> Bool
canStartQuest quest game =
    case quest.questKind of
        CraftSpells params ->
            -- Check if player has required materials
            hasRequiredResources params.requirements game.resources
        
        _ ->
            True

hasRequiredResources : ResourceRecord Int -> ResourceRecord Int -> Bool
hasRequiredResources required current =
    -- Implementation checks each resource requirement
    List.all (checkResource required current) allResources
```

### Resource Consumption

Resources are consumed following the established Effect system patterns:

```elm
-- Quest effects follow the same pattern as activity effects
type alias QuestEffect =
    { effect : EffectType
    , tags : List Tag
    , oneTimeStatus : OneTimeStatus
    }

-- Example quest completion effect
questCompletionEffects : Quest -> List Effect
questCompletionEffects quest =
    case quest.questKind of
        SpendResources params ->
            [ { effect = SpendResource 
                    { base = params.amount
                    , resource = params.targetResource
                    , preservationChance = Percent.float 0
                    , reducedBy = Nothing
                    }
              , tags = [ QuestTag quest.questKind ]
              , oneTimeStatus = OneTime.incomplete
              }
            ]
        
        _ ->
            []
```

### Resource Tracking

Quest progress tracks resource changes through the same mechanisms as activities:

```elm
updateQuestProgress : List Effect -> Quest -> Quest
updateQuestProgress effects quest =
    case quest.questKind of
        GatherResources params ->
            let
                resourcesGained = 
                    effects
                        |> List.filterMap extractResourceGain
                        |> List.filter (\(resource, _) -> resource == params.targetResource)
                        |> List.map Tuple.second
                        |> List.sum
                
                newProgress = 
                    case quest.progress of
                        ResourceGatherProgress current ->
                            ResourceGatherProgress (current + resourcesGained)
                        
                        _ ->
                            quest.progress
            in
            { quest | progress = newProgress }
        
        _ ->
            quest
```

## Coin System Integration

### Coin Requirements and Rewards

Quests integrate with the coin system through the established Coin module:

```elm
import IdleGame.Coin as Coin exposing (Coin)

-- Quest rewards follow coin system patterns
type alias QuestRewards =
    { coins : Maybe Coin
    , resources : ResourceRecord Int
    , experience : SkillRecord Xp
    , masteryXp : ActivityRecord Xp
    }

-- Example coin reward calculation
calculateCoinReward : Quest -> Game -> Maybe Coin
calculateCoinReward quest game =
    case quest.questKind of
        EarnCoins params ->
            -- Base reward scaled by player level
            let
                playerLevel = 
                    game.xp
                        |> getBySkill HerbGathering
                        |> Xp.level Xp.defaultSchedule
                
                baseReward = Coin.int 50
                scaledReward = Coin.multiplyInt playerLevel baseReward
            in
            Just scaledReward
        
        _ ->
            Nothing
```

### Coin Tracking

Quest progress tracks coin accumulation:

```elm
trackCoinProgress : Coin -> Quest -> Quest
trackCoinProgress coinChange quest =
    case quest.questKind of
        EarnCoins params ->
            case quest.progress of
                CoinEarnProgress current ->
                    let
                        newProgress = Coin.add current coinChange
                        
                        updatedProgress = 
                            if params.mustEarnNotPossess then
                                -- Only positive gains count
                                if Coin.toInt coinChange > 0 then
                                    CoinEarnProgress newProgress
                                else
                                    quest.progress
                            else
                                CoinEarnProgress newProgress
                    in
                    { quest | progress = updatedProgress }
                
                _ ->
                    quest
        
        _ ->
            quest
```

## Activity System Integration

### Activity Completion Tracking

Quests track activity completion through the game's activity system:

```elm
-- Quest progress updates when activities complete
onActivityComplete : Activity -> Quest -> Quest
onActivityComplete completedActivity quest =
    case quest.questKind of
        CompleteActivities params ->
            if List.member completedActivity params.activities then
                case quest.progress of
                    ActivityCompleteProgress count ->
                        { quest | progress = ActivityCompleteProgress (count + 1) }
                    
                    _ ->
                        quest
            else
                quest
        
        _ ->
            quest
```

### Activity Effect Integration

Quest effects are processed through the same system as activity effects:

```elm
-- Quest completion generates effects like activities
completeQuest : Quest -> Game -> (Game, List Effect)
completeQuest quest game =
    let
        rewardEffects = generateQuestRewardEffects quest
        
        updatedGame = 
            game
                |> updateQuestStatus quest.questKind QuestCompleted
        
        allEffects = rewardEffects
    in
    Effect.applyEffects allEffects updatedGame
```

## Game State Integration

### Frontend/Backend Type Sharing

Quest types follow the shared type pattern established in Types.elm:

```elm
-- In Types.elm, quests are part of the Game record
type alias Game =
    { seed : Random.Seed
    , xp : SkillRecord Xp
    , mxp : ActivityRecord Xp
    , activity : Maybe ( Activity, Timer )
    , coin : Coin
    , resources : ResourceRecord Int
    , ownedShopUpgrades : ShopUpgradeRecord Bool
    , oneTimeStatuses : OneTime.OneTimeRecord Bool
    , spellAssignments : ActivityRecord (Maybe Resource)
    , activeQuests : QuestRecord (Maybe Quest) -- New field
    , completedQuests : List QuestKind -- Track completed quests
    }
```

### State Synchronization

Quest state synchronizes between frontend and backend:

```elm
-- Backend message handling
type ToBackend
    = -- existing messages...
    | StartQuest (Id GameId) QuestKind
    | CompleteQuest (Id GameId) QuestKind
    | AbandonQuest (Id GameId) QuestKind

-- Frontend message handling  
type FrontendMsg
    = -- existing messages...
    | HandleStartQuestClick QuestKind
    | HandleCompleteQuestClick QuestKind
    | HandleAbandonQuestClick QuestKind

-- Backend state updates
handleStartQuest : QuestKind -> Game -> Game
handleStartQuest questKind game =
    let
        newQuest = initializeQuest questKind
        
        updatedQuests = 
            setByQuest questKind (Just newQuest) game.activeQuests
    in
    { game | activeQuests = updatedQuests }
```

### Time Management

Quest timers integrate with the existing Timer system:

```elm
-- Quest timers follow the same pattern as activity timers
updateQuestTimers : Duration -> Game -> Game
updateQuestTimers deltaTime game =
    let
        updateQuestTimer : Maybe Quest -> Maybe Quest
        updateQuestTimer maybeQuest =
            case maybeQuest of
                Just quest ->
                    case quest.questKind of
                        TimedChallenge params ->
                            let
                                timeRemaining = 
                                    calculateTimeRemaining quest deltaTime
                            in
                            if Duration.inMilliseconds timeRemaining <= 0 then
                                -- Quest failed due to timeout
                                Nothing
                            else
                                Just { quest | timeStarted = Just (updateTimestamp quest deltaTime) }
                        
                        _ ->
                            Just quest
                
                Nothing ->
                    Nothing
        
        updatedQuests = 
            mapQuests updateQuestTimer game.activeQuests
    in
    { game | activeQuests = updatedQuests }
```

## UI Integration

### Modal System Integration

Quests integrate with the existing modal system:

```elm
-- Add quest modal to existing Modal type
type Modal
    = TimePassesModal Duration Posix TimePassesData
    | ShopResourceBuyModal Int Resource Coin
    | ShopResourceSellModal Int Resource Coin
    | SyllabusModal Skill
    | QuestDetailsModal Quest -- New quest modal
    | QuestRewardsModal Quest QuestRewards -- Quest completion modal

-- Quest UI follows established view patterns
viewQuestModal : Quest -> Html FrontendMsg
viewQuestModal quest =
    div [ class "modal-content" ]
        [ viewQuestHeader quest
        , viewQuestProgress quest
        , viewQuestRewards quest
        , viewQuestActions quest
        ]
```

### Tab Integration

Quests can be displayed in their own tab following the Tab system:

```elm
-- Add quest tab to existing Tab type
type Tab
    = HomeTab
    | InventoryTab  
    | ShopTab
    | QuestTab -- New quest tab

-- Quest view follows established content patterns
viewQuestTab : Game -> Html FrontendMsg
viewQuestTab game =
    div [ class "quest-container" ]
        [ viewActiveQuests game.activeQuests
        , viewAvailableQuests game
        , viewQuestHistory game.completedQuests
        ]
```

## Performance Considerations

### Memory Management

Quest state is managed efficiently following codebase patterns:

```elm
-- Only active quests are kept in memory
cleanupCompletedQuests : Game -> Game
cleanupCompletedQuests game =
    let
        (activeQuests, completedQuestKinds) =
            game.activeQuests
                |> extractCompletedQuests
        
        updatedGame =
            { game 
            | activeQuests = activeQuests
            , completedQuests = completedQuestKinds ++ game.completedQuests
            }
    in
    updatedGame
```

### Update Optimization

Quest updates are batched with existing game updates:

```elm
-- Quest progress updates are batched with other game state changes
updateGameWithQuests : List Effect -> Game -> Game
updateGameWithQuests effects game =
    game
        |> updateQuestProgress effects
        |> updateActivityProgress effects
        |> updateResourceState effects
        |> updateExperience effects
```

This integration approach ensures quest system functionality while maintaining the established architecture patterns and performance characteristics of the existing game systems.