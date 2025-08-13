module IdleGame.Quest_test exposing (..)

import Expect exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Kinds exposing (..)
import IdleGame.Quest as Quest
import Test exposing (..)
import Types exposing (QuestProgress, QuestStatus(..))


-- Helper functions for testing
aboutEqualFloat : Float -> Float -> Expectation
aboutEqualFloat =
    within (Absolute 0.001)


-- Helper to create QuestProgress with specific resource amounts
createQuestProgress : Int -> QuestProgress
createQuestProgress amount =
    { depositedResources = resourceRecord amount }


-- Helper to create custom resource record
createCustomResourceRecord : Int -> Int -> Int -> Int -> ResourceRecord Int
createCustomResourceRecord herbs bandages potions reagents =
    { herbs = herbs
    , bandages = bandages
    , potions = potions
    , reagents = reagents
    }


questSystemTest : Test
questSystemTest =
    describe "Quest System"
        [ questKindTest
        , questRecordTest
        , questHelperFunctionsTest
        , questProgressTest
        , questCompletionTest
        , questResourceValidationTest
        , questStatusTransitionTest
        , questIntegrationTest
        , questEdgeCasesTest
        ]


questKindTest : Test
questKindTest =
    describe "QuestKind operations"
        [ test "allQuests contains expected quest types" <|
            \_ ->
                allQuests
                    |> List.length
                    |> Expect.equal 6
        , test "getByQuest works for first quest" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            testRecord =
                                questRecord "test value"
                        in
                        getByQuest firstQuest testRecord
                            |> Expect.equal "test value"

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "setByQuest works correctly" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            initialRecord =
                                questRecord 0

                            updatedRecord =
                                setByQuest firstQuest 42 initialRecord
                        in
                        getByQuest firstQuest updatedRecord
                            |> Expect.equal 42

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "questRecord creates record with default value for all quests" <|
            \_ ->
                let
                    record =
                        questRecord 100
                in
                allQuests
                    |> List.map (\quest -> getByQuest quest record)
                    |> List.all ((==) 100)
                    |> Expect.equal True
        ]


questRecordTest : Test
questRecordTest =
    describe "Quest record operations"
        [ test "mapQuests applies function to all quest values" <|
            \_ ->
                let
                    initialRecord =
                        questRecord 10

                    mappedRecord =
                        mapQuests (\x -> x * 2) initialRecord
                in
                allQuests
                    |> List.map (\quest -> getByQuest quest mappedRecord)
                    |> List.all ((==) 20)
                    |> Expect.equal True
        , test "getQuestStats returns valid stats for all quests" <|
            \_ ->
                allQuests
                    |> List.map getQuestStats
                    |> List.map .name
                    |> List.all (\name -> String.length name > 0)
                    |> Expect.equal True
        , test "quest stats have valid resource requirements" <|
            \_ ->
                allQuests
                    |> List.map getQuestStats
                    |> List.map .resourceRequirements
                    |> List.all (\requirements ->
                        allResources
                            |> List.map (\resource -> getByResource resource requirements)
                            |> List.all (\amount -> amount >= 0)
                    )
                    |> Expect.equal True
        ]


questHelperFunctionsTest : Test
questHelperFunctionsTest =
    describe "Quest helper functions"
        [ test "initQuestProgress creates progress records with empty resources" <|
            \_ ->
                let
                    progress = Quest.initQuestProgress
                in
                allQuests
                    |> List.map (\quest -> getByQuest quest progress)
                    |> List.all (\qp -> 
                        allResources
                            |> List.map (\resource -> getByResource resource qp.depositedResources)
                            |> List.all ((==) 0)
                    )
                    |> Expect.equal True
        , test "initQuestStatus creates status records with Available status" <|
            \_ ->
                let
                    statuses = Quest.initQuestStatus
                in
                allQuests
                    |> List.map (\quest -> getByQuest quest statuses)
                    |> List.all ((==) Available)
                    |> Expect.equal True
        ]


questProgressTest : Test
questProgressTest =
    describe "Quest progress calculations"
        [ test "calculateProgress returns 0 for no deposited resources" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            emptyProgress = createQuestProgress 0
                        in
                        Quest.calculateProgress firstQuest emptyProgress
                            |> Expect.equal 0.0

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "calculateProgress returns value between 0 and 1" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            partialProgress = createQuestProgress 50
                        in
                        Quest.calculateProgress firstQuest partialProgress
                            |> (\progress ->
                                    Expect.all
                                        [ \p -> Expect.atLeast 0.0 p
                                        , \p -> Expect.atMost 1.0 p
                                        ]
                                        progress
                               )

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "calculateProgress returns 1.0 for fully satisfied requirements" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            abundantProgress = createQuestProgress 10000
                        in
                        Quest.calculateProgress firstQuest abundantProgress
                            |> Expect.equal 1.0

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "calculateProgress handles empty requirements" <|
            \_ ->
                -- Test with quest that might have no requirements
                case allQuests of
                    firstQuest :: _ ->
                        let
                            questStats = getQuestStats firstQuest
                            hasRequirements = 
                                allResources
                                    |> List.map (\resource -> getByResource resource questStats.resourceRequirements)
                                    |> List.sum
                                    |> (\total -> total > 0)
                            
                            progress = createQuestProgress 0
                        in
                        if hasRequirements then
                            Quest.calculateProgress firstQuest progress
                                |> Expect.equal 0.0
                        else
                            Quest.calculateProgress firstQuest progress
                                |> Expect.equal 1.0

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]


questCompletionTest : Test
questCompletionTest =
    describe "Quest completion checking"
        [ test "isQuestComplete returns False for insufficient resources" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            emptyProgress = createQuestProgress 0
                        in
                        Quest.isQuestComplete firstQuest emptyProgress
                            |> Expect.equal False

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "isQuestComplete returns True for sufficient resources" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            abundantProgress = createQuestProgress 10000
                        in
                        Quest.isQuestComplete firstQuest abundantProgress
                            |> Expect.equal True

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "canCompleteQuest works with exact resource requirements" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            questStats = getQuestStats firstQuest
                            exactProgress = { depositedResources = questStats.resourceRequirements }
                        in
                        Quest.canCompleteQuest firstQuest exactProgress
                            |> Expect.equal True

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "hasRequiredResources checks player resources correctly" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            questStats = getQuestStats firstQuest
                            abundantPlayerResources = resourceRecord 10000
                            emptyPlayerResources = resourceRecord 0
                        in
                        Expect.all
                            [ \_ -> Quest.hasRequiredResources firstQuest abundantPlayerResources
                                |> Expect.equal True
                            , \_ -> Quest.hasRequiredResources firstQuest emptyPlayerResources
                                |> Expect.equal False
                            ]
                            ()

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]


questResourceValidationTest : Test
questResourceValidationTest =
    describe "Quest resource validation"
        [ test "validateResourceDeposit allows valid deposits" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        case allResources of
                            firstResource :: _ ->
                                let
                                    emptyProgress = createQuestProgress 0
                                in
                                Quest.validateResourceDeposit firstQuest firstResource 10 emptyProgress
                                    |> Expect.equal True

                            [] ->
                                Expect.fail "Expected at least one resource"

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "validateResourceDeposit rejects negative amounts" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        case allResources of
                            firstResource :: _ ->
                                let
                                    emptyProgress = createQuestProgress 0
                                in
                                Quest.validateResourceDeposit firstQuest firstResource -5 emptyProgress
                                    |> Expect.equal False

                            [] ->
                                Expect.fail "Expected at least one resource"

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "validateResourceDeposit rejects zero amounts" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        case allResources of
                            firstResource :: _ ->
                                let
                                    emptyProgress = createQuestProgress 0
                                in
                                Quest.validateResourceDeposit firstQuest firstResource 0 emptyProgress
                                    |> Expect.equal False

                            [] ->
                                Expect.fail "Expected at least one resource"

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "validateResourceDeposit rejects deposits exceeding requirements" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        case allResources of
                            firstResource :: _ ->
                                let
                                    questStats = getQuestStats firstQuest
                                    required = getByResource firstResource questStats.resourceRequirements
                                    
                                    -- Create progress with maximum allowed deposit
                                    maxProgress = { depositedResources = questStats.resourceRequirements }
                                in
                                -- Try to deposit more when already at max
                                Quest.validateResourceDeposit firstQuest firstResource 1 maxProgress
                                    |> Expect.equal False

                            [] ->
                                Expect.fail "Expected at least one resource"

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]


questStatusTransitionTest : Test
questStatusTransitionTest =
    describe "Quest status transitions"
        [ test "Available to InProgress when resources deposited" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            progressWithResources = createQuestProgress 50
                        in
                        Quest.transitionQuestStatus firstQuest progressWithResources Available
                            |> Expect.equal InProgress

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "Available stays Available with no resources" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            emptyProgress = createQuestProgress 0
                        in
                        Quest.transitionQuestStatus firstQuest emptyProgress Available
                            |> Expect.equal Available

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "InProgress to Completed when requirements met" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            completeProgress = createQuestProgress 10000
                        in
                        Quest.transitionQuestStatus firstQuest completeProgress InProgress
                            |> Expect.equal Completed

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "InProgress stays InProgress when requirements not met" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            partialProgress = createQuestProgress 50
                        in
                        Quest.transitionQuestStatus firstQuest partialProgress InProgress
                            |> Expect.equal InProgress

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "Completed stays Completed" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            anyProgress = createQuestProgress 0
                        in
                        Quest.transitionQuestStatus firstQuest anyProgress Completed
                            |> Expect.equal Completed

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]


questIntegrationTest : Test
questIntegrationTest =
    describe "Quest integration with existing systems"
        [ test "quest rewards work with coin system" <|
            \_ ->
                allQuests
                    |> List.map getQuestStats
                    |> List.map .coinReward
                    |> List.map Coin.toInt
                    |> List.all (\amount -> amount >= 0)
                    |> Expect.equal True
        , test "quest resource requirements use existing resource types" <|
            \_ ->
                allQuests
                    |> List.map getQuestStats
                    |> List.map .resourceRequirements
                    |> List.concatMap
                        (\requirements ->
                            allResources
                                |> List.map (\resource -> getByResource resource requirements)
                        )
                    |> List.all (\amount -> amount >= 0)
                    |> Expect.equal True
        , test "quest progress integrates with resource system" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            progress = Quest.initQuestProgress
                            questProgress = getByQuest firstQuest progress
                        in
                        allResources
                            |> List.map (\resource -> getByResource resource questProgress.depositedResources)
                            |> List.all ((==) 0)
                            |> Expect.equal True

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]


questEdgeCasesTest : Test
questEdgeCasesTest =
    describe "Quest edge cases"
        [ test "handles quests with no resource requirements" <|
            \_ ->
                -- Find if any quest has zero requirements
                let
                    questsWithNoRequirements =
                        allQuests
                            |> List.filter (\quest ->
                                let
                                    requirements = getQuestStats quest |> .resourceRequirements
                                    totalRequired = 
                                        allResources
                                            |> List.map (\resource -> getByResource resource requirements)
                                            |> List.sum
                                in
                                totalRequired == 0
                            )
                in
                case questsWithNoRequirements of
                    quest :: _ ->
                        let
                            emptyProgress = createQuestProgress 0
                        in
                        Expect.all
                            [ \_ -> Quest.calculateProgress quest emptyProgress |> Expect.equal 1.0
                            , \_ -> Quest.isQuestComplete quest emptyProgress |> Expect.equal True
                            ]
                            ()

                    [] ->
                        -- No quests with zero requirements, that's fine
                        Expect.pass
        , test "partial resource deposits work correctly" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            questStats = getQuestStats firstQuest
                            requirements = questStats.resourceRequirements

                            -- Create a resource record with half the required amounts
                            halfResources = mapResources (\amount -> max 0 (amount // 2)) requirements
                            halfProgress = { depositedResources = halfResources }

                            progress = Quest.calculateProgress firstQuest halfProgress
                        in
                        -- Progress should be between 0 and 1
                        Expect.all
                            [ \p -> Expect.atLeast 0.0 p
                            , \p -> Expect.atMost 1.0 p
                            ]
                            progress

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        , test "quest state progression follows expected flow" <|
            \_ ->
                case allQuests of
                    firstQuest :: _ ->
                        let
                            emptyProgress = createQuestProgress 0
                            partialProgress = createQuestProgress 50
                            completeProgress = createQuestProgress 10000

                            -- Test the complete state flow
                            stateEmpty = Quest.transitionQuestStatus firstQuest emptyProgress Available
                            statePartial = Quest.transitionQuestStatus firstQuest partialProgress Available
                            stateComplete = Quest.transitionQuestStatus firstQuest completeProgress InProgress
                        in
                        Expect.all
                            [ \_ -> Expect.equal Available stateEmpty
                            , \_ -> Expect.equal InProgress statePartial
                            , \_ -> Expect.equal Completed stateComplete
                            ]
                            ()

                    [] ->
                        Expect.fail "Expected at least one quest in allQuests"
        ]