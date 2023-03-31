module IdleGame.Adventuring_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Adventuring as Adventuring
import Test exposing (..)


expectPlayerHealth : Int -> Adventuring.State -> Expectation
expectPlayerHealth expectedHealth state =
    Expect.equal expectedHealth state.playerHealth


expectMonsterHealth : Int -> Adventuring.State -> Expectation
expectMonsterHealth expectedHealth state =
    Expect.equal expectedHealth state.monsterHealth


expectMoveIndex : Int -> Adventuring.State -> Expectation
expectMoveIndex index state =
    Expect.equal index state.nextMoveIndex


adventuringTest : Test
adventuringTest =
    describe "Adventuring State"
        [ test "moving to next index works" <|
            \_ ->
                Adventuring.createState
                    |> Adventuring.increment
                    |> expectMoveIndex 1
        , test "moving to next index works when at last index" <|
            \_ ->
                Adventuring.createState
                    |> Adventuring.increment
                    |> Adventuring.increment
                    |> Adventuring.increment
                    |> expectMoveIndex 0
        , skip <|
            test "monster loses health when hit by player" <|
                \_ ->
                    Adventuring.createState
                        |> Adventuring.increment
                        |> expectPlayerHealth 94
        , skip <|
            test "player loses health when hit by monster" <|
                \_ ->
                    Adventuring.createState
                        |> Adventuring.increment
                        |> expectMonsterHealth 94
        ]
