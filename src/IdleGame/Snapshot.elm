module IdleGame.Snapshot exposing
    ( Snapshot
    , Tick
    , createTick
    , fastForward
    , fromTuple
    , getTime
    , getValue
    , map
    , setTime
    , setValue
    , tickWith
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


map : (t -> t) -> Snapshot t -> Snapshot t
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


tickWith : Tick t -> Snapshot t -> Snapshot t
tickWith (Tick delta fn) (Snapshot ( time, state )) =
    Debug.todo ""


fastForward : Tick t -> Posix -> Snapshot t -> Snapshot t
fastForward (Tick delta fn) endTime (Snapshot ( time, state )) =
    Debug.todo ""
