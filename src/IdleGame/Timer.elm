module IdleGame.Timer exposing
    ( Timer
    , create
    , percentComplete
    , tick
    , tickDuration
    )

-- An animation should know when it started, what percentage it is through, be able to update, do something on reaching end, know whether to repeat


type Timer
    = Timer
        { current : Int
        , length : Int
        }


create : Int -> Timer
create length =
    Timer { current = 0, length = length }


percentComplete : Timer -> Float
percentComplete (Timer { current, length }) =
    toFloat current / toFloat length * 100.0


tickDuration : Int
tickDuration =
    15


tick : Timer -> ( Timer, Int )
tick (Timer { current, length }) =
    let
        sum =
            current + tickDuration

        completions =
            sum // length

        newCurrent =
            remainderBy length sum
    in
    ( Timer { current = newCurrent, length = length }, completions )
