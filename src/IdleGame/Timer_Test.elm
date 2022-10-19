module IdleGame.Timer_Test exposing (..)

import Expect exposing (..)
import IdleGame.Timer as Timer
import Test exposing (..)


suite : Test
suite =
    describe "Timer module"
        [ describe "create"
            [ test "creates a Timer with zero progress" <|
                \_ ->
                    Timer.create 100
                        |> Timer.percentComplete
                        |> Expect.equal 0.0
            ]
        ]
