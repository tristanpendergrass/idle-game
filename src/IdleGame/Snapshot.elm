module IdleGame.Snapshot exposing
    ( Snapshot
    , Tick
    , createTick
    , dEBUG_addTime
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
import Time.Extra


type Tick t
    = Tick Float (Float -> t -> t)


type Snapshot t
    = Snapshot ( Posix, t )


createTick : Float -> (Float -> t -> t) -> Tick t
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


getDuration : Tick t -> Float
getDuration (Tick duration _) =
    duration


getFunction : Tick t -> (Float -> t -> t)
getFunction (Tick _ fn) =
    fn


tickUntil : Tick t -> Posix -> Snapshot t -> Snapshot t
tickUntil tick endTime snapshot =
    let
        tickDuration =
            getDuration tick

        timeOfNextTick =
            snapshot
                |> getTime
                |> Time.Extra.add Time.Extra.Millisecond (floor tickDuration) Time.utc
                |> Time.posixToMillis

        shouldTick : Bool
        shouldTick =
            timeOfNextTick < Time.posixToMillis endTime
    in
    if shouldTick then
        let
            newValue =
                snapshot
                    |> getValue
                    |> getFunction tick tickDuration

            newSnapshot =
                Snapshot ( Time.millisToPosix timeOfNextTick, newValue )
        in
        tickUntil tick endTime newSnapshot

    else
        snapshot


getTimeDifference : Snapshot t -> Snapshot a -> Posix
getTimeDifference (Snapshot ( oldTime, _ )) (Snapshot ( newTime, _ )) =
    Time.posixToMillis newTime
        - Time.posixToMillis oldTime
        |> Time.millisToPosix


{-| This function should only be referened from e.g. debug panel. It sets the time without updating the state.
Under normal circumstances that would cause bugs where the game gets out of sync
-}
dEBUG_addTime : Float -> Snapshot t -> Snapshot t
dEBUG_addTime duration (Snapshot ( time, state )) =
    Snapshot ( Time.Extra.add Time.Extra.Millisecond (floor duration) Time.utc time, state )
