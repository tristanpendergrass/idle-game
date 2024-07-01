module IdleGame.TestExtras exposing (..)

import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Kinds exposing (..)


getCostEffects : Test -> List Effect
getCostEffects test =
    let
        toEffect : { resource : Resource, amount : Int } -> Effect
        toEffect { resource, amount } =
            Effect.spendResource amount resource
    in
    List.map toEffect (getTestStats test).costs


getRewardEffects : Test -> List Effect
getRewardEffects test =
    let
        stats : TestStats
        stats =
            getTestStats test

        toEffect : { resource : Resource, amount : Int } -> Effect
        toEffect { resource, amount } =
            Effect.gainResource amount resource

        rewardResourceEffect : Maybe Effect
        rewardResourceEffect =
            Maybe.map toEffect stats.rewardResource

        rewardCoinEffect : Maybe Effect
        rewardCoinEffect =
            Maybe.map Effect.gainCoin stats.rewardCoin
    in
    List.filterMap identity [ rewardResourceEffect, rewardCoinEffect ]


getAllEffects : Test -> List Effect
getAllEffects test =
    List.concat [ getCostEffects test, getRewardEffects test ]
