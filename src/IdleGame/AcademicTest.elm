module IdleGame.AcademicTest exposing (..)

import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Kinds exposing (..)


getCostEffects : AcademicTest -> List Effect
getCostEffects test =
    let
        toEffect : { resource : Resource, amount : Int } -> Effect
        toEffect { resource, amount } =
            Effect.spendResource amount resource
    in
    List.map toEffect (getAcademicTestStats test).costs


getRewardEffects : AcademicTest -> List Effect
getRewardEffects test =
    let
        stats : AcademicTestStats
        stats =
            getAcademicTestStats test

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


getAllEffects : AcademicTest -> List Effect
getAllEffects test =
    List.concat [ getCostEffects test, getRewardEffects test ]
