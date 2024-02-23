module IdleGame.PerfTesting.Test5Years exposing (..)

import Duration
import IdleGame.PerfTesting.PerfTestingUtil as PerfTestingUtil
import Test exposing (..)


{-| Demonstrates how fast calculating even 5 years of ticks is if you use a high enough tick duration.
-}
test5Years : Test
test5Years =
    PerfTestingUtil.testTimePasses
        { tick = PerfTestingUtil.createTick (Duration.hours 1)
        , duration = Duration.weeks 260
        }
