module IdleGame.GameTypes exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.EffectErr exposing (EffectErr(..))
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import Percent exposing (Percent)


type Toast
    = GainedCoin Coin
    | GainedResource Int Resource
    | NegativeAmountErr
    | TestAlreadyCompleted
    | OneTimeEffectAlreadyApplied
    | TestNotUnlocked


type IntervalModLabel
    = IntervalModLabel Percent


type alias IntervalMod =
    { kind : Activity
    , percentChange : Percent -- e.g. 0.25 -> 25% faster
    , label : IntervalModLabel
    }


type CardImage
    = CardLandscape String
    | CardIcon Icon
