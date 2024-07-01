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


getRewardEffect : Test -> Effect
getRewardEffect test =
    let
        toEffect : { resource : Resource, amount : Int } -> Effect
        toEffect { resource, amount } =
            Effect.spendResource amount resource
    in
    toEffect (getTestStats test).rewardResource
