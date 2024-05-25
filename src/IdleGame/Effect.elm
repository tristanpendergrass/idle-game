module IdleGame.Effect exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Task exposing (fail)


type Tag
    = SkillTag Skill
    | XpTag
    | MxpTag
    | ActivityTag Activity


type alias Effect =
    { effect : EffectType
    , tags : List Tag
    }


type alias GainXpParams =
    { base : Xp
    , percentIncrease : Percent
    , skill : Skill
    }


type alias GainMxpParams =
    { percentIncrease : Percent
    , activity : Activity
    }


type alias GainCoinParams =
    { base : Coin
    , percentIncrease : Percent
    }


type alias GainResourceParams =
    { base : Int, doublingChance : Percent, resource : Resource }


type alias SpendResourceParams =
    { base : Int, resource : Resource, preservationChance : Percent }


type EffectType
    = VariableSuccess { successProbability : Percent, successEffects : List Effect, failureEffects : List Effect }
    | GainResource GainResourceParams
    | SpendResource SpendResourceParams
    | GainXp GainXpParams
    | GainMxp GainMxpParams
    | GainCoin GainCoinParams


getEffect : Effect -> EffectType
getEffect { effect } =
    effect


setEffect : EffectType -> Effect -> Effect
setEffect newEffect taggedEffect =
    { taggedEffect | effect = newEffect }


gainXp : Xp -> Skill -> Effect
gainXp quantity skill =
    { effect = GainXp { base = quantity, percentIncrease = Percent.zero, skill = skill }
    , tags = [ XpTag, SkillTag skill ]
    }


gainCoin : Coin -> Effect
gainCoin quantity =
    { effect = GainCoin { base = quantity, percentIncrease = Percent.zero }
    , tags = []
    }


gainMxp : Activity -> Effect
gainMxp activity =
    { effect = GainMxp { percentIncrease = Percent.zero, activity = activity }
    , tags = []
    }


gainResource : Int -> Resource -> Effect
gainResource quantity kind =
    { effect = GainResource { base = quantity, doublingChance = Percent.zero, resource = kind }
    , tags = []
    }


spendResource : Int -> Resource -> Effect
spendResource quantity kind =
    { effect = SpendResource { base = quantity, preservationChance = Percent.zero, resource = kind }
    , tags = []
    }


withPreservationChance : Percent -> Effect -> Effect
withPreservationChance preservationChance taggedEffect =
    case taggedEffect.effect of
        SpendResource spendResourceParams ->
            { taggedEffect
                | effect = SpendResource { base = spendResourceParams.base, resource = spendResourceParams.resource, preservationChance = preservationChance }
            }

        _ ->
            taggedEffect


gainResourceWithDoubling : Int -> Resource -> Percent -> Effect
gainResourceWithDoubling quantity kind doubling =
    { effect = GainResource { base = quantity, doublingChance = doubling, resource = kind }
    , tags = []
    }


gainWithProbability : Percent -> List Effect -> Effect
gainWithProbability probability successEffects =
    { effect = VariableSuccess { successProbability = probability, successEffects = successEffects, failureEffects = [] }
    , tags = []
    }


withTags : List Tag -> Effect -> Effect
withTags newTags taggedEffect =
    { taggedEffect
      -- TODO: dedupe tags?
        | tags = taggedEffect.tags ++ newTags
    }


order : Effect -> Effect -> Order
order effect1 effect2 =
    case ( getEffect effect1, getEffect effect2 ) of
        -- Coin comes at front
        ( GainCoin _, _ ) ->
            LT

        ( _, GainCoin _ ) ->
            GT

        -- XP comes before MXP
        ( GainXp _, GainMxp _ ) ->
            LT

        ( GainMxp _, GainXp _ ) ->
            GT

        -- Both types of XP come at the end
        ( GainXp _, _ ) ->
            GT

        ( GainMxp _, _ ) ->
            GT

        ( _, GainXp _ ) ->
            LT

        ( _, GainMxp _ ) ->
            LT

        _ ->
            EQ


hasTags : List Tag -> Effect -> Bool
hasTags requiredTags { tags } =
    List.all
        (\tag ->
            List.member tag tags
        )
        requiredTags
