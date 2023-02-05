module IdleGame.Timer exposing
    ( Timer
    , create
    , increment
    , percentComplete
    , tick
    , tickDuration
    )

import Json.Decode as D


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
tick =
    increment tickDuration


increment : Int -> Timer -> ( Timer, Int )
increment duration (Timer { current, length }) =
    let
        sum =
            current + duration

        completions =
            sum // length

        newCurrent =
            remainderBy length sum
    in
    ( Timer { current = newCurrent, length = length }, completions )
