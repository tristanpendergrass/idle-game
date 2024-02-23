module IdleGame.PerfTesting.Test60Days exposing (..)

import Duration
import IdleGame.PerfTesting.PerfTestingUtil as PerfTestingUtil
import Test exposing (..)


test60Days : Test
test60Days =
    PerfTestingUtil.testTimePasses
        { tick = PerfTestingUtil.createTick (Duration.minutes 1)
        , duration = Duration.days 60
        }
