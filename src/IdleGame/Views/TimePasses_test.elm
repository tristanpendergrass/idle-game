module IdleGame.Views.TimePasses_test exposing (..)

import Expect exposing (..)
import IdleGame.Views.TimePasses exposing (getDurationString)
import Test exposing (..)


suite : Test
suite =
    describe "getDurationString"
        [ test "works on two days" <|
            \_ ->
                (1000 * 60 * 60 * 24 * 2)
                    |> getDurationString
                    |> Expect.equal "2 days"
        , test "works on one day" <|
            \_ ->
                (1000 * 60 * 60 * 24)
                    |> getDurationString
                    |> Expect.equal "1 day"
        , test "works on a formulation with every unit" <|
            \_ ->
                ((1000 * 60 * 60 * 24)
                    -- one day
                    + (1000 * 60 * 60 * 12)
                    -- twelve hours
                    + (1000 * 60 * 30)
                    -- 30 minutes
                    + (1000 * 30)
                    -- 30 seconds
                    + 500
                 -- 500 milliseconds
                )
                    |> getDurationString
                    |> Expect.equal "1 day, 12 hours, 30 minutes, 30 seconds"
        , test "works on a formulation \"missing\" a unit" <|
            \_ ->
                ((1000 * 60 * 60 * 24)
                    -- one day
                    + (1000 * 60 * 30)
                    -- 30 minutes
                    + (1000 * 30)
                    -- 30 seconds
                    + 500
                 -- 500 milliseconds
                )
                    |> getDurationString
                    |> Expect.equal "1 day, 30 minutes, 30 seconds"
        , test "works on zero time" <|
            \_ ->
                0
                    |> getDurationString
                    |> Expect.equal "0 seconds"
        ]
