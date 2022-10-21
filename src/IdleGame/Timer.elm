module IdleGame.Timer exposing
    ( Timer
    , create
    , percentComplete
    , update
    )

-- An animation should know when it started, what percentage it is through, be able to update, do something on reaching end, know whether to repeat


type Timer
    = Timer
        { start : Int
        , length : Int
        , lastRecorded : Int
        }


create : Int -> Int -> Timer
create start length =
    Timer { start = start, length = length, lastRecorded = start }


percentComplete : Int -> Timer -> Float
percentComplete current (Timer { start, length }) =
    let
        progress =
            remainderBy length (current - start)

        total =
            length
    in
    toFloat progress / toFloat total * 100


update : Int -> Timer -> ( Timer, Int )
update now (Timer { start, length, lastRecorded }) =
    let
        oldCompletions =
            (lastRecorded - start) // length

        newCompletions =
            (now - start) // length

        newTimer =
            Timer { start = start, length = length, lastRecorded = now }
    in
    ( newTimer, newCompletions - oldCompletions )
