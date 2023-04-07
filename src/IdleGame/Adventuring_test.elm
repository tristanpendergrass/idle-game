module IdleGame.Adventuring_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Adventuring as Adventuring
import Test exposing (..)


expectPlayerHealth : Int -> Adventuring.CombatState -> Expectation
expectPlayerHealth expectedHealth state =
    Expect.equal expectedHealth state.playerHealth


expectMonsterHealth : Int -> Adventuring.CombatState -> Expectation
expectMonsterHealth expectedHealth state =
    Expect.equal expectedHealth state.monsterHealth


expectMoveIndex : Int -> Adventuring.CombatState -> Expectation
expectMoveIndex index state =
    Expect.equal index state.nextMoveIndex


threePunches : List Adventuring.PlayerMove
threePunches =
    [ Adventuring.Punch
    , Adventuring.Punch
    , Adventuring.Punch
    ]


defaultState : Adventuring.CombatState
defaultState =
    Adventuring.createState { monster = Adventuring.Charmstone, playerMoves = threePunches }


adventuringTest : Test
adventuringTest =
    describe "Adventuring State"
        [ test "moving to next index works" <|
            \_ ->
                defaultState
                    |> Adventuring.increment
                    |> expectMoveIndex 1
        , test "moving to next index works when at last index" <|
            \_ ->
                defaultState
                    |> Adventuring.increment
                    |> Adventuring.increment
                    |> Adventuring.increment
                    |> expectMoveIndex 0
        , skip <|
            test "monster loses health when hit by player" <|
                \_ ->
                    defaultState
                        |> Adventuring.increment
                        |> expectPlayerHealth 94
        , skip <|
            test "player loses health when hit by monster" <|
                \_ ->
                    defaultState
                        |> Adventuring.increment
                        |> expectMonsterHealth 94
        ]
