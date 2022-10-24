module IdleGame.Game exposing (..)

import Time exposing (Posix)
import Time.Extra



-- Public


type alias Game =
    { currentTime : Posix
    }


create : Posix -> Game
create now =
    { currentTime = now
    }


updateGameObject : Posix -> Game -> Game
updateGameObject now gameObject =
    if Time.posixToMillis (getTimeOfNextTick gameObject) <= Time.posixToMillis now then
        gameObject
            |> tick
            |> updateGameObject now

    else
        gameObject



-- Private


tick : Game -> Game
tick game =
    Debug.todo "Implement tick"


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc
