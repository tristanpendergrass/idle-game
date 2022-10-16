module IdleGame.Timer exposing
    ( Timer
    , create
    , percentComplete
    , updateCurrentTime
    )

import Time



-- An animation should know when it started, what percentage it is through, be able to update, do something on reaching end, know whether to repeat


type Timer
    = Timer
        { startTime : Time.Posix
        , currentTime : Time.Posix
        , length : Int
        }


create : Time.Posix -> Int -> Timer
create startTime length =
    Timer { startTime = startTime, currentTime = startTime, length = length }


percentComplete : Timer -> Float
percentComplete (Timer { startTime, currentTime, length }) =
    (Time.posixToMillis currentTime - Time.posixToMillis startTime)
        -- obtain progress through a timer that might have completed more than once and looped around
        |> remainderBy length
        -- calculate completion
        |> (\timeElapsed -> toFloat timeElapsed / toFloat length)
        -- convert to percent
        |> (*) 100


updateCurrentTime : Time.Posix -> Timer -> ( Timer, Int )
updateCurrentTime newCurrentTime (Timer data) =
    let
        millisElapsed =
            Time.posixToMillis newCurrentTime - Time.posixToMillis data.currentTime

        timesCompleted =
            millisElapsed // data.length

        newAnimation =
            Timer { data | currentTime = newCurrentTime }
    in
    ( newAnimation, timesCompleted )
