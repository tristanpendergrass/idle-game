module Evergreen.V1.IdleGame.Effect exposing (..)

import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.Kinds
import Evergreen.V1.IdleGame.OneTime
import Evergreen.V1.IdleGame.Xp
import Evergreen.V1.Percent


type Tag
    = SkillTag Evergreen.V1.IdleGame.Kinds.Skill
    | ActivityTag Evergreen.V1.IdleGame.Kinds.Activity
    | ActivityCompleteTag


type alias Effect =
    { effect : EffectType
    , tags : List Tag
    , oneTimeStatus : Evergreen.V1.IdleGame.OneTime.OneTimeStatus
    }


type alias GainResourceParams =
    { base : Int
    , doublingChance : Evergreen.V1.Percent.Percent
    , resource : Evergreen.V1.IdleGame.Kinds.Resource
    }


type ReducedBy
    = ReducedByFlat Evergreen.V1.IdleGame.Kinds.Resource
    | ReducedByPercent Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.Percent.Percent


type alias SpendResourceParams =
    { base : Int
    , resource : Evergreen.V1.IdleGame.Kinds.Resource
    , preservationChance : Evergreen.V1.Percent.Percent
    , reducedBy : Maybe ReducedBy
    }


type alias GainXpParams =
    { base : Evergreen.V1.IdleGame.Xp.Xp
    , percentIncrease : Evergreen.V1.Percent.Percent
    , skill : Evergreen.V1.IdleGame.Kinds.Skill
    }


type alias GainMxpParams =
    { percentIncrease : Evergreen.V1.Percent.Percent
    , activity : Evergreen.V1.IdleGame.Kinds.Activity
    }


type alias GainCoinParams =
    { base : Evergreen.V1.IdleGame.Coin.Coin
    , percentIncrease : Evergreen.V1.Percent.Percent
    }


type EffectType
    = NoOp
    | VariableSuccess
        { successProbability : Evergreen.V1.Percent.Percent
        , successEffects : List Effect
        , failureEffects : List Effect
        }
    | OneOf Effect (List Effect)
    | GainResource GainResourceParams
    | SpendResource SpendResourceParams
    | GainXp GainXpParams
    | GainMxp GainMxpParams
    | GainCoin GainCoinParams
