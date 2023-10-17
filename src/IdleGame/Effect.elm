module IdleGame.Effect exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)


type
    Tag
    -- TODO: refactor into a Tag module so references can be Tag.Skill?
    = SkillTag Skill.Kind
    | XpTag
    | MxpTag
    | ActivityTag Activity


type Effect
    = Effect
        { type_ : EffectType
        , tags : List Tag
        }


type EffectType
    = VariableSuccess { successProbability : Float, successEffects : List Effect, failureEffects : List Effect }
    | GainResource { base : Int, doublingChance : Float } Resource.Kind
    | GainXp { base : Xp, multiplier : Float } Skill.Kind
    | GainMxp { multiplier : Float } Activity
    | GainCoin { base : Coin, multiplier : Float }


getType : Effect -> EffectType
getType (Effect { type_ }) =
    type_


setType : EffectType -> Effect -> Effect
setType newType (Effect data) =
    Effect { data | type_ = newType }


gainXp : Xp -> Skill.Kind -> Effect
gainXp quantity skill =
    Effect
        { type_ = GainXp { base = quantity, multiplier = 1 } skill
        , tags = []
        }


gainCoin : Coin -> Effect
gainCoin quantity =
    Effect
        { type_ = GainCoin { base = quantity, multiplier = 1 }
        , tags = []
        }


gainMxp : Activity -> Effect
gainMxp activity =
    Effect
        { type_ = GainMxp { multiplier = 1 } activity
        , tags = []
        }


gainResource : Int -> Resource.Kind -> Effect
gainResource quantity kind =
    Effect
        { type_ = GainResource { base = quantity, doublingChance = 0 } kind
        , tags = []
        }


gainResourceWithDoubling : Int -> Resource.Kind -> Float -> Effect
gainResourceWithDoubling quantity kind doubling =
    Effect
        { type_ = GainResource { base = quantity, doublingChance = doubling } kind
        , tags = []
        }


gainWithProbability : Float -> List Effect -> Effect
gainWithProbability probability successEffects =
    Effect { type_ = VariableSuccess { successProbability = probability, successEffects = successEffects, failureEffects = [] }, tags = [] }


withTags : List Tag -> Effect -> Effect
withTags newTags (Effect { type_, tags }) =
    Effect
        { type_ = type_

        -- TODO: dedupe tags?
        , tags = tags ++ newTags
        }


orderEffects : Effect -> Effect -> Order
orderEffects effect1 effect2 =
    case ( getType effect1, getType effect2 ) of
        -- Coin comes at front
        ( GainCoin _, _ ) ->
            LT

        ( _, GainCoin _ ) ->
            GT

        -- XP comes before MXP
        ( GainXp _ _, GainMxp _ _ ) ->
            LT

        ( GainMxp _ _, GainXp _ _ ) ->
            GT

        -- Both types of XP come at the end
        ( GainXp _ _, _ ) ->
            GT

        ( GainMxp _ _, _ ) ->
            GT

        ( _, GainXp _ _ ) ->
            LT

        ( _, GainMxp _ _ ) ->
            LT

        _ ->
            EQ
