module IdleGame.Timer exposing
    ( Timer
    , create
    , increment
    , percentComplete
    , tick
    , tickDuration
    , timerDecoder
    )

import Json.Decode as D



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


timerDecoder : D.Decoder Timer
timerDecoder =
    D.map2
        (\current length -> Timer { current = current, length = length })
        D.int
        D.int
