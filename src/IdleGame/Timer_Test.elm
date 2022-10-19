module IdleGame.Timer_test exposing (..)

import Expect exposing (..)
import IdleGame.Timer as Timer
import Test exposing (..)


suite : Test
suite =
    describe "Timer module"
        [ test "creates a Timer with zero progress" <|
            \_ ->
                Timer.create 100
                    |> Timer.percentComplete
                    |> Expect.equal 0.0
        , test "increments a timer" <|
            \_ ->
                Timer.create 100
                    |> Timer.increment 10.0
                    |> (\( incrementedTimer, _ ) -> incrementedTimer)
                    |> Timer.percentComplete
                    |> Expect.equal 10.0
        , test "reports zero completions correctly" <|
            \_ ->
                Timer.create 100
                    |> Timer.increment 10.0
                    |> (\( _, timesCompleted ) -> timesCompleted)
                    |> Expect.equal 0
        ]
