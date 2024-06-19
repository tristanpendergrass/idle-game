module IdleGame.Xp_test exposing (..)

import Expect exposing (..)
import IdleGame.Xp as Xp
import Percent
import Test exposing (..)


isAboutEqualTo : Float -> Float -> Expectation
isAboutEqualTo =
    within (Absolute 0.001)


levelTest : Test
levelTest =
    describe "level based on default leveling schedule"
        [ test "returns correct skill level for 0 xp" <|
            \_ ->
                Xp.level Xp.defaultSchedule (Xp.int 0)
                    |> Expect.equal 1
        , test "returns correct skill level for 100 xp" <|
            \_ ->
                Xp.level Xp.defaultSchedule (Xp.int 100)
                    |> Expect.equal 2
        , test "returns correct skill level for 1154 xp" <|
            \_ ->
                Xp.level Xp.defaultSchedule (Xp.int 1154)
                    |> Expect.equal 10
        , test "returns correct skill level for 13034431 xp" <|
            \_ ->
                Xp.level Xp.defaultSchedule (Xp.int 13034431)
                    |> Expect.equal 99
        , test "returns correct skill level for 13034432 xp" <|
            -- Tests that 99 is the maximum
            \_ ->
                Xp.level Xp.defaultSchedule (Xp.int 13034432)
                    |> Expect.equal 99
        ]


skillLevelPercentTest : Test
skillLevelPercentTest =
    describe "skillLevelPercent"
        [ test "returns correct percent for 0 xp" <|
            \_ ->
                Xp.levelPercent Xp.defaultSchedule (Xp.int 0)
                    |> Percent.toFloat
                    |> isAboutEqualTo 0
        , test "returns correct skill level for 100 xp" <|
            \_ ->
                Xp.levelPercent Xp.defaultSchedule (Xp.int 100)
                    |> Percent.toFloat
                    |> isAboutEqualTo 0.1868
        , test "returns correct skill level for 1154 xp" <|
            \_ ->
                Xp.levelPercent Xp.defaultSchedule (Xp.int 1154)
                    |> Percent.toFloat
                    |> isAboutEqualTo 0
        , test "returns 1.0 for an xp value way above our max" <|
            \_ ->
                Xp.levelPercent Xp.defaultSchedule (Xp.int 999999999)
                    |> Percent.toFloat
                    |> isAboutEqualTo 1.0
        ]
