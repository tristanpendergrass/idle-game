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


type alias Reward v =
    { value : v
    , tags : List Tag
    , apply : v -> model -> model
    }


type V
    = FloatV Float
    | IntV Int


woodcuttingXpReward : Reward Float
woodcuttingXpReward =
    { value = 5.0
    , tags =
        [ Woodcutting
        , SkillXp
        ]
    , apply =
        \finalValue model -> model
    }


type Tag
    = Woodcutting
    | BoatBuilding
    | SkillXp
    | MasteryXp


gainSomething : Reward -> Game -> RewardFinal
gainSomething rewardBase game =
    Debug.todo "Implement gainSomething"


tick : Game -> Game
tick game =
    Debug.todo "Implement tick"


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc
