module IdleGame.Timer_test exposing (..)

import Expect exposing (..)
import IdleGame.Timer as Timer
import Test exposing (..)


suite : Test
suite =
    describe "Timer module"
        [ test "creates a Timer with zero progress" <|
            \_ ->
                Timer.create 0 100
                    |> Timer.percentComplete 0
                    |> Expect.equal 0.0
        , test "increments a timer" <|
            \_ ->
                Timer.create 0 100
                    |> Timer.percentComplete 10
                    |> Expect.equal 10.0
        , test "reports zero completions correctly" <|
            \_ ->
                Timer.create 0 100
                    |> Timer.update 10
                    |> (\( _, timesCompleted ) -> timesCompleted)
                    |> Expect.equal 0
        , test "reports one completion correctly" <|
            \_ ->
                Timer.create 0 100
                    |> Timer.update 110
                    |> (\( _, timesCompleted ) -> timesCompleted)
                    |> Expect.equal 1
        , test "reports two completions correctly" <|
            \_ ->
                Timer.create 0 100
                    |> Timer.update 250
                    |> (\( timer, _ ) -> timer)
                    |> Timer.update 450
                    |> (\( _, timesCompleted ) -> timesCompleted)
                    |> Expect.equal 2
        ]
