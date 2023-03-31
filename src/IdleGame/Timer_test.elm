module IdleGame.Timer_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Timer as Timer exposing (Timer)
import Percent exposing (Percent)
import Quantity
import Test exposing (..)


aboutEqualFloat : Float -> Float -> Expectation
aboutEqualFloat =
    within (Absolute 0.001)


aboutEqualDuration : Duration -> Duration -> Expectation
aboutEqualDuration a b =
    Quantity.equalWithin (Duration.seconds 0.001) a b
        |> (\isEqual ->
                if isEqual then
                    Expect.pass

                else
                    Expect.fail <| "Expected " ++ String.fromFloat (Duration.inMilliseconds a) ++ " to equal " ++ String.fromFloat (Duration.inMilliseconds b)
           )


expectPercentComplete : Percent -> Timer -> Expectation
expectPercentComplete expectedPercent timer =
    Timer.percentComplete timer
        |> Percent.toFloat
        |> aboutEqualFloat (Percent.toFloat expectedPercent)


expectCompletions : Int -> ( Timer, Int ) -> Expectation
expectCompletions expectedCompletions ( _, completions ) =
    Expect.equal expectedCompletions completions


timerTest : Test
timerTest =
    describe "Timer"
        [ test "create returns a timer with 0 progress" <|
            \_ ->
                Timer.create
                    |> Timer.percentComplete
                    |> Expect.equal (Percent.fromFloat 0)
        , test "increment works for 50%" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 0.5)
                    |> (\( newTimer, _ ) -> newTimer)
                    |> expectPercentComplete (Percent.fromFloat 0.5)
        , test "tracks one completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 1)
                    |> expectCompletions 1
        , test "progress is correct after completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 1.3)
                    |> (\( newTimer, _ ) -> newTimer)
                    |> expectPercentComplete (Percent.fromFloat 0.3)
        , test "tracks multiple completions" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 5.999)
                    |> expectCompletions 5
        , test "incrementUntilComplete works for a delta that won't complete the timer" <|
            \_ ->
                Timer.create
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 0.25)
                    |> (\( newTimer, _ ) -> newTimer)
                    |> expectPercentComplete (Percent.fromFloat 0.25)
        , test "incrementUntilComplete works for a delta that completes the timer" <|
            \_ ->
                Timer.create
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 1.25)
                    |> (\( newTimer, _ ) -> newTimer)
                    |> expectPercentComplete (Percent.fromFloat 0)
        , test "incrementUntilComplete returns 0 additional time if not completing the timer" <|
            \_ ->
                Timer.create
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 0.25)
                    |> (\( _, remainingTime ) -> remainingTime)
                    |> aboutEqualDuration (Duration.seconds 0)
        , test "incrementUntilComplete returns the additional time if completing the timer" <|
            \_ ->
                Timer.create
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 0.95)
                    |> (\( t, _ ) -> t)
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 0.1)
                    |> (\( _, remainingTime ) -> remainingTime)
                    |> aboutEqualDuration (Duration.seconds 0.05)
        , test "incrementUntilComplete returns the additional time if completing the timer multiple times" <|
            \_ ->
                Timer.create
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 0.95)
                    |> (\( t, _ ) -> t)
                    |> Timer.incrementUntilComplete (Duration.seconds 1) (Duration.seconds 1.1)
                    |> (\( _, remainingTime ) -> remainingTime)
                    |> aboutEqualDuration (Duration.seconds 1.05)
        ]
