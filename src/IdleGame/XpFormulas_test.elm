module IdleGame.XpFormulas_test exposing (..)

import Expect exposing (..)
import IdleGame.XpFormulas exposing (skillLevel, skillLevelPercent)
import Test exposing (..)


isAboutEqualTo : Float -> Float -> Expectation
isAboutEqualTo =
    within (Absolute 0.001)


skillLevelTest : Test
skillLevelTest =
    describe "skillLevel"
        [ test "returns correct skill level for 0 xp" <|
            \_ ->
                skillLevel 0
                    |> Expect.equal 1
        , test "returns correct skill level for 100 xp" <|
            \_ ->
                skillLevel 100
                    |> Expect.equal 2
        , test "returns correct skill level for 1154 xp" <|
            \_ ->
                skillLevel 1154
                    |> Expect.equal 10
        ]


skillLevelPercentTest : Test
skillLevelPercentTest =
    describe "skillLevelPercent"
        [ test "returns correct percent for 0 xp" <|
            \_ ->
                skillLevelPercent 0
                    |> Expect.equal 0
        , test "returns correct skill level for 100 xp" <|
            \_ ->
                skillLevelPercent 100
                    |> isAboutEqualTo 0.1868
        , test "returns correct skill level for 1154 xp" <|
            \_ ->
                skillLevelPercent 1154
                    |> Expect.equal 0
        , test "returns correct skill level for 1153.99 xp" <|
            \_ ->
                skillLevelPercent 1153.9999999
                    |> isAboutEqualTo 1.0
        , test "returns 1.0 for an xp value way above our max" <|
            \_ ->
                skillLevelPercent 999999999
                    |> isAboutEqualTo 1.0
        ]
