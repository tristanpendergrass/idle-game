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


type Skill
    = Woodcutting
    | BoatBuilding


type Reward
    = SkillXp { skill : Skill, baseAmount : Float, percentIncrease : Float }
    | MasteryXp { skill : Skill, baseAmount : Float, percentIncrease : Float }


type Modifier
    = ModifyBase
    | ModifyPercent
    | ModifyFlatAmount


type Tag reward
    = CanMultiply (Float -> reward -> reward)
    | CanAddBase (Float -> reward -> reward)
    | CanAddFlatAmount (Float -> reward -> reward)
    | HasDoubling (Float -> reward -> reward)
    | Skill Skill
    | IsSkillXp
    | IsMasteryXp


type alias BaseReward reward =
    { reward : reward
    , tags : List (Tag reward)
    }


type alias FloatTag =
    Tag { a | quantity : Float }


float =
    { canMultiply = CanMultiply (\multiplier { quantity } -> { quantity = multiplier * quantity })
    , canAddBase = CanAddBase (\addend { quantity } -> { quantity = quantity + addend })
    , canAddFlatAmount = CanAddFlatAmount (\addend { quantity } -> { quantity = quantity + addend })
    , hasDoubling = HasDoubling (\chance { quantity } -> { quantity = quantity * 2 })
    }


woodcuttingXpReward : BaseReward { quantity : Float }
woodcuttingXpReward =
    { reward = { xp = 5 }
    , tags =
        [ Skill Woodcutting
        , IsSkillXp
        , float.canMultiply
        , float.canAddBase
        , float.canAddFlatAmount
        ]
    }


type Tag
    = Unique
    | Unique


gainSomething : RewardBase -> Game -> RewardFinal
gainSomething rewardBase game =
    Debug.todo "Implement gainSomething"


tick : Game -> Game
tick game =
    Debug.todo "Implement tick"


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc
