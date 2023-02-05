module IdleGame.Timer_test exposing (..)

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
                    |> Timer.increment 1000 500
                    |> (\( newTimer, _ ) -> Timer.percentComplete newTimer)
                    |> isAboutEqualTo 0.5
        , test "tracks one completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment 1000 1000
                    |> (\( _, completions ) -> completions)
                    |> Expect.equal 1
        , test "progress is correct after completion" <|
            \_ ->
                Timer.create
                    |> Timer.increment 1000 1300
                    |> (\( newTimer, _ ) -> Timer.percentComplete newTimer)
                    |> isAboutEqualTo 0.3
        , test "tracks multiple completions" <|
            \_ ->
                Timer.create
                    |> Timer.increment 1000 5999
                    |> (\( _, completions ) -> completions)
                    |> Expect.equal 5
        ]
