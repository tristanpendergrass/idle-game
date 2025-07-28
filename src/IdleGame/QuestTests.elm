module IdleGame.QuestTests exposing (..)

import Expect
import IdleGame.Coin as Coin
import IdleGame.Kinds exposing (..)
import IdleGame.Quest as Quest
import Test exposing (..)
import Types exposing (QuestProgress, QuestStatus(..))


suite : Test
suite =
    describe "Quest System"
        [ describe "Quest initialization"
            [ test "initQuestProgress creates empty progress for all quests" <|
                \_ ->
                    let
                        progress = Quest.initQuestProgress
                        gatherSuppliesProgress = getByQuest GatherSupplies progress
                    in
                    Expect.equal 0 (getByResource Sage gatherSuppliesProgress.depositedResources)
            , test "initQuestStatus sets all quests to Available" <|
                \_ ->
                    let
                        status = Quest.initQuestStatus
                        gatherSuppliesStatus = getByQuest GatherSupplies status
                    in
                    Expect.equal Available gatherSuppliesStatus
            ]
        , describe "Quest completion checking"
            [ test "isQuestComplete returns false for empty progress" <|
                \_ ->
                    let
                        progress = Quest.initQuestProgress |> getByQuest GatherSupplies
                    in
                    Quest.isQuestComplete GatherSupplies progress
                        |> Expect.equal False
            , test "isQuestComplete returns true when all requirements met" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        progress = { depositedResources = requirements }
                    in
                    Quest.isQuestComplete GatherSupplies progress
                        |> Expect.equal True
            , test "isQuestComplete returns false when requirements partially met" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        partialResources = { requirements | sage = requirements.sage - 1 }
                        progress = { depositedResources = partialResources }
                    in
                    Quest.isQuestComplete GatherSupplies progress
                        |> Expect.equal False
            ]
        , describe "Progress calculation"
            [ test "calculateProgress returns 0.0 for empty progress" <|
                \_ ->
                    let
                        progress = Quest.initQuestProgress |> getByQuest GatherSupplies
                        result = Quest.calculateProgress GatherSupplies progress
                    in
                    Expect.equal 0.0 result
            , test "calculateProgress returns 1.0 for completed quest" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        progress = { depositedResources = requirements }
                        result = Quest.calculateProgress GatherSupplies progress
                    in
                    Expect.equal 1.0 result
            , test "calculateProgress returns correct partial progress" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        -- GatherSupplies needs 10 sage + 5 nettle + 3 parchment = 18 total
                        -- Let's deposit 9 sage (half of sage requirement)
                        partialResources = { requirements | sage = 9, nettle = 0, parchment = 0 }
                        progress = { depositedResources = partialResources }
                        result = Quest.calculateProgress GatherSupplies progress
                        expected = 9.0 / 18.0 -- 9 out of 18 total resources
                    in
                    Expect.within (Expect.Absolute 0.001) expected result
            ]
        , describe "Resource validation"
            [ test "validateResourceDeposit accepts valid amounts" <|
                \_ ->
                    let
                        progress = Quest.initQuestProgress |> getByQuest GatherSupplies
                        result = Quest.validateResourceDeposit GatherSupplies Sage 5 progress
                    in
                    result |> Expect.equal True
            , test "validateResourceDeposit rejects negative amounts" <|
                \_ ->
                    let
                        progress = Quest.initQuestProgress |> getByQuest GatherSupplies
                        result = Quest.validateResourceDeposit GatherSupplies Sage -1 progress
                    in
                    result |> Expect.equal False
            , test "validateResourceDeposit rejects amounts exceeding requirements" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        sageRequired = getByResource Sage requirements
                        progress = Quest.initQuestProgress |> getByQuest GatherSupplies
                        result = Quest.validateResourceDeposit GatherSupplies Sage (sageRequired + 1) progress
                    in
                    result |> Expect.equal False
            ]
        , describe "Status transitions"
            [ test "Available transitions to InProgress when resources deposited" <|
                \_ ->
                    let
                        partialResources = resourceRecord 0 |> setByResource Sage 1
                        progress = { depositedResources = partialResources }
                        result = Quest.transitionQuestStatus GatherSupplies progress Available
                    in
                    Expect.equal InProgress result
            , test "InProgress transitions to Completed when quest complete" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        progress = { depositedResources = requirements }
                        result = Quest.transitionQuestStatus GatherSupplies progress InProgress
                    in
                    Expect.equal Completed result
            , test "Completed stays Completed" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        progress = { depositedResources = requirements }
                        result = Quest.transitionQuestStatus GatherSupplies progress Completed
                    in
                    Expect.equal Completed result
            ]
        , describe "Quest stats validation"
            [ test "GatherSupplies has valid stats" <|
                \_ ->
                    let
                        stats = getQuestStats GatherSupplies
                    in
                    Expect.all
                        [ \s -> String.length s.name > 0 |> Expect.equal True
                        , \s -> String.length s.description > 0 |> Expect.equal True
                        , \s -> Coin.toInt s.coinReward > 0 |> Expect.equal True
                        ] stats
            ]
        , describe "hasRequiredResources"
            [ test "returns false when player lacks resources" <|
                \_ ->
                    let
                        emptyResources = resourceRecord 0
                        result = Quest.hasRequiredResources GatherSupplies emptyResources
                    in
                    result |> Expect.equal False
            , test "returns true when player has exact resources" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        result = Quest.hasRequiredResources GatherSupplies requirements
                    in
                    result |> Expect.equal True
            , test "returns true when player has excess resources" <|
                \_ ->
                    let
                        requirements = getQuestStats GatherSupplies |> .resourceRequirements
                        excessResources = { requirements | sage = requirements.sage + 10 }
                        result = Quest.hasRequiredResources GatherSupplies excessResources
                    in
                    result |> Expect.equal True
            ]
        ]