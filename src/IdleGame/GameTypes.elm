module IdleGame.GameTypes exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import Percent as Percent exposing (Percent)


type Toast
    = GainedCoin Coin
    | GainedResource Int Resource.Kind
    | LostCombat


type IntervalModLabel
    = IntervalModLabel Percent


type alias IntervalMod =
    { kind : Activity
    , percentChange : Percent -- e.g. 0.25 -> 25% faster
    , label : IntervalModLabel
    }
