module IdleGame.Snapshot exposing
    ( Snapshot
    , Tick
    , createTick
    , fromTuple
    , getTime
    , getTimeDifference
    , getValue
    , map
    , setTime
    , setValue
    , tickUntil
    )

import Time exposing (Posix)


type Tick t
    = Tick Int (t -> t)


type Snapshot t
    = Snapshot ( Posix, t )


createTick : Int -> (t -> t) -> Tick t
createTick =
    Tick


fromTuple : ( Posix, t ) -> Snapshot t
fromTuple ( now, initialState ) =
    Snapshot ( now, initialState )


map : (t -> a) -> Snapshot t -> Snapshot a
map fn (Snapshot ( time, state )) =
    Snapshot ( time, fn state )


setTime : Posix -> Snapshot t -> Snapshot t
setTime time (Snapshot ( _, state )) =
    Snapshot ( time, state )


getTime : Snapshot t -> Posix
getTime (Snapshot ( time, _ )) =
    time


getValue : Snapshot t -> t
getValue (Snapshot ( _, state )) =
    state


setValue : t -> Snapshot t -> Snapshot t
setValue state (Snapshot ( time, _ )) =
    Snapshot ( time, state )


tickUntil : Tick t -> Posix -> Snapshot t -> Snapshot t
tickUntil (Tick delta fn) endTime (Snapshot ( time, state )) =
    Debug.todo ""


getTimeDifference : Snapshot t -> Snapshot a -> Posix
getTimeDifference (Snapshot ( oldTime, _ )) (Snapshot ( newTime, _ )) =
    Time.posixToMillis newTime
        - Time.posixToMillis oldTime
        |> Time.millisToPosix
