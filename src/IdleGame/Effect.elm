module IdleGame.Effect exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Task exposing (fail)


type Tag
    = SkillTag Skill.Kind
    | XpTag
    | MxpTag
    | ActivityTag Activity


type alias TaggedEffect =
    { effect : Effect
    , tags : List Tag
    }


type alias GainXpParams =
    { base : Xp
    , multiplier : Float
    , skill : Skill.Kind
    }


type Effect
    = VariableSuccess { successProbability : Float, successEffects : List TaggedEffect, failureEffects : List TaggedEffect }
    | GainResource { base : Int, doublingChance : Float } Resource.Kind
      -- | GainXp GainXpParams
    | GainXp { base : Xp, multiplier : Float } Skill.Kind
    | GainMxp { multiplier : Float } Activity
    | GainCoin { base : Coin, multiplier : Float }
    | ResolveCombat { combat : Combat, successEffects : List TaggedEffect, failureEffects : List TaggedEffect }


getEffect : TaggedEffect -> Effect
getEffect { effect } =
    effect


setEffect : Effect -> TaggedEffect -> TaggedEffect
setEffect newEffect taggedEffect =
    { taggedEffect | effect = newEffect }


gainXp : Xp -> Skill.Kind -> TaggedEffect
gainXp quantity skill =
    { effect = GainXp { base = quantity, multiplier = 1 } skill
    , tags = []
    }


gainCoin : Coin -> TaggedEffect
gainCoin quantity =
    { effect = GainCoin { base = quantity, multiplier = 1 }
    , tags = []
    }


gainMxp : Activity -> TaggedEffect
gainMxp activity =
    { effect = GainMxp { multiplier = 1 } activity
    , tags = []
    }


gainResource : Int -> Resource.Kind -> TaggedEffect
gainResource quantity kind =
    { effect = GainResource { base = quantity, doublingChance = 0 } kind
    , tags = []
    }


gainResourceWithDoubling : Int -> Resource.Kind -> Float -> TaggedEffect
gainResourceWithDoubling quantity kind doubling =
    { effect = GainResource { base = quantity, doublingChance = doubling } kind
    , tags = []
    }


gainWithProbability : Float -> List TaggedEffect -> TaggedEffect
gainWithProbability probability successEffects =
    { effect = VariableSuccess { successProbability = probability, successEffects = successEffects, failureEffects = [] }
    , tags = []
    }


resolveCombat : Combat -> List TaggedEffect -> TaggedEffect
resolveCombat combat successEffects =
    { effect = ResolveCombat { combat = combat, successEffects = successEffects, failureEffects = [] }
    , tags = []
    }


withTags : List Tag -> TaggedEffect -> TaggedEffect
withTags newTags taggedEffect =
    { taggedEffect
      -- TODO: dedupe tags?
        | tags = taggedEffect.tags ++ newTags
    }


order : TaggedEffect -> TaggedEffect -> Order
order effect1 effect2 =
    case ( getEffect effect1, getEffect effect2 ) of
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


hasTags : List Tag -> TaggedEffect -> Bool
hasTags requiredTags { tags } =
    List.all
        (\tag ->
            List.member tag tags
        )
        requiredTags
