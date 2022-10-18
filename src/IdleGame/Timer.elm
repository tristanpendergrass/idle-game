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


recursiveSubtract : Float -> Float -> { fullSubtractions : Int, remainder : Float }
recursiveSubtract subtrahend minuend =
    let
        difference =
            minuend - subtrahend
    in
    if difference > subtrahend then
        let
            { remainder, fullSubtractions } =
                recursiveSubtract subtrahend difference
        in
        { remainder = remainder, fullSubtractions = fullSubtractions + 1 }

    else
        { remainder = difference, fullSubtractions = 0 }


increment : Float -> Timer -> ( Timer, Int )
increment delta (Timer data) =
    let
        sum =
            data.current + delta

        { fullSubtractions, remainder } =
            recursiveSubtract data.length sum
    in
    ( Timer { data | current = remainder }, fullSubtractions )
