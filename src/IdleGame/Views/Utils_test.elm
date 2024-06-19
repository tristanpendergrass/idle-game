module IdleGame.Views.Utils_test exposing (..)

import Expect
import IdleGame.Views.Utils exposing (floatToString, getDurationString)
import Test exposing (..)


getDurationStringSuite : Test
getDurationStringSuite =
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


floatToStringSuite : Test
floatToStringSuite =
    describe "floatToString"
        [ test "shows with no decimal points if its a round number" <|
            \_ ->
                floatToString 2 3
                    |> Expect.equal "3"
        , test "shows out to two decimal places" <|
            \_ ->
                floatToString 2 3.2525
                    |> Expect.equal "3.25"
        ]
