module IdleGame.Timer exposing
    ( Timer
    , create
    , percentComplete
    , update
    )

import Time exposing (Posix)



-- An animation should know when it started, what percentage it is through, be able to update, do something on reaching end, know whether to repeat


type Timer
    = Timer
        { start : Posix
        , length : Int
        , lastRecorded : Posix
        }


create : Posix -> Int -> Timer
create start length =
    Timer { start = start, length = length, lastRecorded = start }


percentComplete : Posix -> Timer -> Float
percentComplete current (Timer { start, length }) =
    let
        progress =
            remainderBy length (Time.posixToMillis current - Time.posixToMillis start)

        total =
            length
    in
    toFloat progress / toFloat total * 100


update : Posix -> Timer -> ( Timer, Int )
update now (Timer { start, length, lastRecorded }) =
    let
        oldCompletions =
            (Time.posixToMillis lastRecorded - Time.posixToMillis start) // length

        newCompletions =
            (Time.posixToMillis now - Time.posixToMillis start) // length

        newTimer =
            Timer { start = start, length = length, lastRecorded = now }
    in
    ( newTimer, newCompletions - oldCompletions )
