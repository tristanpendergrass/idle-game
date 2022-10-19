module IdleGame.Timer exposing
    ( Timer
    , create
    , increment
    , percentComplete
    )

import Time



-- An animation should know when it started, what percentage it is through, be able to update, do something on reaching end, know whether to repeat


type Timer
    = Timer
        { current : Float
        , length : Float
        }


create : Float -> Timer
create length =
    Timer { current = 0, length = length }


percentComplete : Timer -> Float
percentComplete (Timer { current, length }) =
    current / length * 100.0


increment : Float -> Timer -> ( Timer, Int )
increment delta timer =
    let
        (Timer data) =
            timer

        sum =
            data.current + delta
    in
    if sum > data.length then
        -- In this case the timer has reached completion and we should loop it around to the beginning. This may happen more than once, hence the recursion
        let
            ( incrementedTimer, completions ) =
                increment (delta - data.length) timer
        in
        ( incrementedTimer, 1 + completions )

    else
        ( Timer { data | current = sum }, 0 )
