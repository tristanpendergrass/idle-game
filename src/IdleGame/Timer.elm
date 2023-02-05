module IdleGame.Timer exposing
    ( Timer
    , create
    , increment
    , percentComplete
    , tickDuration
    )


type alias Duration =
    Float


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
    current


tickDuration : Float
tickDuration =
    15


increment : Duration -> Duration -> Timer -> ( Timer, Int )
increment totalDuration delta (Timer { current }) =
    let
        additionalPercent =
            delta / totalDuration

        sum =
            current + additionalPercent

        completions =
            floor (sum / 1.0)

        newCurrent =
            (sum / 1.0) - toFloat (floor (sum / 1.0))
    in
    ( Timer { current = newCurrent }, completions )
