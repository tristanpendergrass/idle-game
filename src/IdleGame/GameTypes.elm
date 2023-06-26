module IdleGame.GameTypes exposing (..)

import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource


type Toast
    = GainedCoin Counter
    | GainedResource Int Resource.Kind


type alias IntervalMod =
    { kind : Activity
    , percentChange : Float -- e.g. 0.25 -> 25% faster
    }
