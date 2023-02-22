module IdleGame.Timer_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Timer as Timer exposing (Timer)
import Test exposing (..)


isAboutEqualTo : Float -> Float -> Expectation
isAboutEqualTo =
    within (Absolute 0.001)


timerTest : Test
timerTest =
    describe "Timer"
        [ test "create returns a timer with 0 progress" <|
            \_ ->
                Timer.create
                    |> Timer.percentComplete
                    |> Expect.equal 0
        , test "increment works for 50%" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 0.5)
                    |> (\( newTimer, _ ) -> Timer.percentComplete newTimer)
                    |> isAboutEqualTo 50
        , test "tracks one completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 1)
                    |> (\( _, completions ) -> completions)
                    |> Expect.equal 1
        , test "progress is correct after completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 1.3)
                    |> (\( newTimer, _ ) -> Timer.percentComplete newTimer)
                    |> isAboutEqualTo 30
        , test "tracks multiple completions" <|
            \_ ->
                Timer.create
                    |> Timer.increment (Duration.seconds 1) (Duration.seconds 5.999)
                    |> (\( _, completions ) -> completions)
                    |> Expect.equal 5
        ]
