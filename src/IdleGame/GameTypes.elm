module IdleGame.GameTypes exposing (..)

import IdleGame.Coin exposing (Coin)
import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon exposing (Icon)
import Percent exposing (Percent)


type Toast
    = GainedCoin Coin
    | GainedResource Int Resource
    | NegativeAmountErr


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
