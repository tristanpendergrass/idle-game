module Evergreen.V2.IdleGame.Effect exposing (..)

import Evergreen.V2.IdleGame.Coin
import Evergreen.V2.IdleGame.Kinds
import Evergreen.V2.IdleGame.OneTime
import Evergreen.V2.IdleGame.Xp
import Evergreen.V2.Percent


type Tag
    = SkillTag Evergreen.V2.IdleGame.Kinds.Skill
    | ActivityTag Evergreen.V2.IdleGame.Kinds.Activity
    | ActivityCompleteTag


type alias Effect =
    { effect : EffectType
    , tags : List Tag
    , oneTimeStatus : Evergreen.V2.IdleGame.OneTime.OneTimeStatus
    }


type alias GainResourceParams =
    { base : Int
    , doublingChance : Evergreen.V2.Percent.Percent
    , resource : Evergreen.V2.IdleGame.Kinds.Resource
    }


type ReducedBy
    = ReducedByFlat Evergreen.V2.IdleGame.Kinds.Resource
    | ReducedByPercent Evergreen.V2.IdleGame.Kinds.Resource Evergreen.V2.Percent.Percent


type alias SpendResourceParams =
    { base : Int
    , resource : Evergreen.V2.IdleGame.Kinds.Resource
    , preservationChance : Evergreen.V2.Percent.Percent
    , reducedBy : Maybe ReducedBy
    }


type alias GainXpParams =
    { base : Evergreen.V2.IdleGame.Xp.Xp
    , percentIncrease : Evergreen.V2.Percent.Percent
    , skill : Evergreen.V2.IdleGame.Kinds.Skill
    }


type alias GainMxpParams =
    { percentIncrease : Evergreen.V2.Percent.Percent
    , activity : Evergreen.V2.IdleGame.Kinds.Activity
    }


type alias GainCoinParams =
    { base : Evergreen.V2.IdleGame.Coin.Coin
    , percentIncrease : Evergreen.V2.Percent.Percent
    }


type EffectType
    = NoOp
    | VariableSuccess
        { successProbability : Evergreen.V2.Percent.Percent
        , successEffects : List Effect
        , failureEffects : List Effect
        }
    | OneOf Effect (List Effect)
    | GainResource GainResourceParams
    | SpendResource SpendResourceParams
    | GainXp GainXpParams
    | GainMxp GainMxpParams
    | GainCoin GainCoinParams
