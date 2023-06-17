module IdleGame.GameTypes exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Hex as Hex
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)


type Activity
    = ActivityChore Chore.ActivityData
    | ActivityHex Hex.Kind Timer


type Toast
    = GainedCoin Counter
    | GainedResource Int Resource.Kind


type alias IntervalMod =
    { kind : Chore.Kind
    , percentChange : Float -- e.g. 0.25 -> 25% faster
    }
