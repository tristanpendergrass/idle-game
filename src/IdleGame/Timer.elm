module IdleGame.Timer exposing
    ( Duration
    , Timer
    , create
    , increment
    , percentComplete
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
    current * 100


increment : Duration -> Duration -> Timer -> ( Timer, Int )
increment totalDuration delta (Timer { current }) =
    let
        additionalPercent =
            delta / totalDuration

        sum =
            current + additionalPercent

        completions =
            floor sum

        newCurrent =
            sum - toFloat (floor sum)
    in
    ( Timer { current = newCurrent }, completions )
