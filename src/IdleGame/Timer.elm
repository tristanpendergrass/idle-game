module IdleGame.Timer exposing
    ( Timer(..)
    , create
    , increment
    , percentComplete
    )

import Duration exposing (Duration)
import Quantity


type alias PercentComplete =
    Float


type Timer
    = Timer
        { current : PercentComplete
        }


create : Timer
create =
    Timer { current = 0 }


percentComplete : Timer -> Float
percentComplete (Timer { current }) =
    current * 100


increment : Duration -> Duration -> Timer -> ( Timer, Int )
increment totalDuration delta (Timer { current }) =
    let
        additionalPercent =
            Quantity.ratio delta totalDuration

        sum =
            current + additionalPercent

        completions =
            floor sum

        newCurrent =
            sum - toFloat (floor sum)
    in
    ( Timer { current = newCurrent }, completions )
