module IdleGame.PerfTesting.Test7Days exposing (..)

import Duration
import IdleGame.PerfTesting.PerfTestingUtil as PerfTestingUtil
import Test exposing (..)


test7Days : Test
test7Days =
    PerfTestingUtil.testTimePasses
        { tick = PerfTestingUtil.createTick (Duration.minutes 1)
        , duration = Duration.days 7
        }
