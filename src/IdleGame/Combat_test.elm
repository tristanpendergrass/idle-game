module IdleGame.Combat_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Combat as Combat
import Test exposing (..)


expectPlayerHealth : Int -> Combat.State -> Expectation
expectPlayerHealth expectedHealth state =
    Expect.equal expectedHealth state.playerHealth


expectMonsterHealth : Int -> Combat.State -> Expectation
expectMonsterHealth expectedHealth state =
    Expect.equal expectedHealth state.monsterHealth


expectMoveIndex : Int -> Combat.State -> Expectation
expectMoveIndex index state =
    Expect.equal index state.nextMoveIndex


threePunches : List Combat.PlayerMove
threePunches =
    [ Combat.Punch
    , Combat.Punch
    , Combat.Punch
    ]


defaultState : Combat.State
defaultState =
    Combat.createState { monster = Combat.Charmstone, playerMoves = threePunches }



-- adventuringTest : Test
-- adventuringTest =
--     describe "Combat State"
--         [ test "moving to next index works" <|
--             \_ ->
--                 defaultState
--                     |> Combat.increment
--                     |> expectMoveIndex 1
--         , test "moving to next index works when at last index" <|
--             \_ ->
--                 defaultState
--                     |> Combat.increment
--                     |> Combat.increment
--                     |> Combat.increment
--                     |> expectMoveIndex 0
--         , skip <|
--             test "monster loses health when hit by player" <|
--                 \_ ->
--                     defaultState
--                         |> Combat.increment
--                         |> expectPlayerHealth 94
--         , skip <|
--             test "player loses health when hit by monster" <|
--                 \_ ->
--                     defaultState
--                         |> Combat.increment
--                         |> expectMonsterHealth 94
--         ]
