module IdleGame.GameTypes exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)


type Activity
    = ActivityChore Chore.Kind Timer


type HexKind
    = Hex1
    | Jinx1
    | Curse1
    | Hex2
    | Jinx2
    | Curse2
    | Hex3
    | Jinx3
    | Curse3


type Toast
    = GainedCoin Counter
    | GainedResource Int Resource.Kind


type alias IntervalMod =
    { kind : Chore.Kind
    , percentChange : Float -- e.g. 0.25 -> 25% faster
    }
