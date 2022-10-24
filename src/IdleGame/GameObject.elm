module IdleGame.GameObject exposing (..)

import IdleGame.Types exposing (..)
import Time exposing (Posix)
import Time.Extra


init : GameObject
init =
    { currentTime = Time.posixFromMillis 0
    , wood = 0
    , boatLevel = 0
    , woodcuttingXp = 0
    , boatbuildingXp = 0
    }



-- Use this function to update after animationFrame: just pass the oldTime and current game object in, along with the new time
-- Same goes for updating after receiving visibility/init from local storage.


getTimeOfNextTick : GameObject -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc


tick : GameObject -> GameObject
tick gameObject =
    gameObject
        |> IdleGame.Woodcuttings.tick


update : Posix -> GameObject -> GameObject
update now gameObject =
    if getTimeOfNextTick gameObject <= now then
        gameObject
            |> tick
            |> update now

    else
        gameObject



-- Diff stuff


type Gain
    = XpGain
    | ResourceGain


type Loss
    = ResourceLoss


type alias GameObjectDiff =
    { gains : List Gain
    , losses : List Loss
    }


diff : GameObject -> GameObject -> GameObjectDiff
diff gameObject1 gameObject2 =
    Debug.todo "Implement diff"
