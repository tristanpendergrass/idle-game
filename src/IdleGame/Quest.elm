module IdleGame.Quest exposing
    ( calculateProgress
    , canCompleteQuest
    , hasRequiredResources
    , isQuestComplete
    , validateResourceDeposit
    , transitionQuestStatus
    , initQuestProgress
    , initQuestStatus
    )

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Kinds exposing (..)
import Types exposing (QuestProgress, QuestStatus(..))


{-| Initialize quest progress for all quests
-}
initQuestProgress : QuestRecord QuestProgress
initQuestProgress =
    questRecord { depositedResources = resourceRecord 0 }


{-| Initialize quest status for all quests (all start as Available)
-}
initQuestStatus : QuestRecord QuestStatus
initQuestStatus =
    questRecord Available


{-| Check if a quest is complete based on deposited resources vs requirements
-}
isQuestComplete : Quest -> QuestProgress -> Bool
isQuestComplete quest progress =
    let
        requirements = getQuestStats quest |> .resourceRequirements
        deposited = progress.depositedResources
    in
    allResources
        |> List.all
            (\resource ->
                let
                    required = getByResource resource requirements
                    depositedAmount = getByResource resource deposited
                in
                depositedAmount >= required
            )


{-| Calculate progress percentage for a quest (0.0 to 1.0)
-}
calculateProgress : Quest -> QuestProgress -> Float
calculateProgress quest progress =
    let
        requirements = getQuestStats quest |> .resourceRequirements
        deposited = progress.depositedResources
        
        totalRequired =
            allResources
                |> List.map (\resource -> getByResource resource requirements)
                |> List.sum
                
        totalDeposited =
            allResources
                |> List.map (\resource -> 
                    let
                        required = getByResource resource requirements
                        depositedAmount = getByResource resource deposited
                    in
                    min required depositedAmount
                )
                |> List.sum
    in
    if totalRequired == 0 then
        1.0
    else
        toFloat totalDeposited / toFloat totalRequired


{-| Check if player has enough resources to complete the quest
-}
hasRequiredResources : Quest -> ResourceRecord Int -> Bool
hasRequiredResources quest playerResources =
    let
        requirements = getQuestStats quest |> .resourceRequirements
    in
    allResources
        |> List.all
            (\resource ->
                let
                    required = getByResource resource requirements
                    playerAmount = getByResource resource playerResources
                in
                playerAmount >= required
            )


{-| Check if a quest can be completed (has required resources deposited)
-}
canCompleteQuest : Quest -> QuestProgress -> Bool
canCompleteQuest quest progress =
    isQuestComplete quest progress


{-| Validate that a resource deposit is valid for a quest
-}
validateResourceDeposit : Quest -> Resource -> Int -> QuestProgress -> Bool
validateResourceDeposit quest resource amount progress =
    let
        requirements = getQuestStats quest |> .resourceRequirements
        required = getByResource resource requirements
        alreadyDeposited = getByResource resource progress.depositedResources
        newTotal = alreadyDeposited + amount
    in
    amount > 0 && newTotal <= required


{-| Transition quest status based on game state
-}
transitionQuestStatus : Quest -> QuestProgress -> QuestStatus -> QuestStatus
transitionQuestStatus quest progress currentStatus =
    case currentStatus of
        Available ->
            -- Can start if any resources have been deposited
            let
                totalDeposited = 
                    allResources
                        |> List.map (\resource -> getByResource resource progress.depositedResources)
                        |> List.sum
            in
            if totalDeposited > 0 then
                InProgress
            else
                Available

        InProgress ->
            -- Can complete if all requirements are met
            if isQuestComplete quest progress then
                Completed
            else
                InProgress

        Completed ->
            -- Once completed, stays completed
            Completed