module IdleGame.Effect exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Kinds exposing (..)
import IdleGame.OneTime as OneTimeStatus
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Task exposing (fail)
import Types exposing (..)


getEffectType : Effect -> EffectType
getEffectType e =
    e.effect


setEffect : EffectType -> Effect -> Effect
setEffect newEffect taggedEffect =
    { taggedEffect | effect = newEffect }


effect : EffectType -> Effect
effect type_ =
    { effect = type_
    , tags = []
    , oneTimeStatus = OneTimeStatus.NotOneTime
    }


noOp : Effect
noOp =
    effect EffectNoOp


gainCoin : Coin -> Effect
gainCoin quantity =
    effect (GainCoin { base = quantity, percentIncrease = Percent.zero })


gainXp : Xp -> Skill -> Effect
gainXp xp skill =
    effect (GainXp { base = xp, percentIncrease = Percent.zero, skill = skill })


gainMxp : Activity -> Effect
gainMxp activity =
    effect (GainMxp { percentIncrease = Percent.zero, activity = activity })


gainResource : Int -> Resource -> Effect
gainResource quantity kind =
    effect (GainResource { base = quantity, doublingChance = Percent.zero, resource = kind })


spendResource : Int -> Resource -> Effect
spendResource quantity kind =
    effect
        (SpendResource
            { base = quantity
            , preservationChance = Percent.zero
            , resource = kind
            , reducedBy = Nothing
            }
        )


withOneTime : OneTimeStatus.OneTimeId -> Effect -> Effect
withOneTime oneTimeId taggedEffect =
    { taggedEffect | oneTimeStatus = OneTimeStatus.OneTime oneTimeId }


withReducedBy : ReducedBy -> Effect -> Effect
withReducedBy reducedBy e =
    case e.effect of
        SpendResource spendResourceParams ->
            { e
                | effect = SpendResource { spendResourceParams | reducedBy = Just reducedBy }
            }

        _ ->
            e


withPreservationChance : Percent -> Effect -> Effect
withPreservationChance preservationChance e =
    case e.effect of
        SpendResource spendResourceParams ->
            { e
                | effect = SpendResource { spendResourceParams | preservationChance = preservationChance }
            }

        _ ->
            e


gainResourceWithDoubling : Int -> Resource -> Percent -> Effect
gainResourceWithDoubling quantity kind doubling =
    { effect = GainResource { base = quantity, doublingChance = doubling, resource = kind }
    , tags = []
    , oneTimeStatus = OneTimeStatus.NotOneTime
    }


oneOf : Effect -> List Effect -> Effect
oneOf effect1 effect2s =
    { effect = OneOf effect1 effect2s
    , tags = []
    , oneTimeStatus = OneTimeStatus.NotOneTime
    }


gainWithProbability : Percent -> List Effect -> Effect
gainWithProbability probability successEffects =
    { effect = VariableSuccess { successProbability = probability, successEffects = successEffects, failureEffects = [] }
    , tags = []
    , oneTimeStatus = OneTimeStatus.NotOneTime
    }


withTags : List Tag -> Effect -> Effect
withTags newTags taggedEffect =
    { taggedEffect
      -- TODO: dedupe tags?
        | tags = taggedEffect.tags ++ newTags
    }


order : Effect -> Effect -> Order
order effect1 effect2 =
    case ( getEffectType effect1, getEffectType effect2 ) of
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
