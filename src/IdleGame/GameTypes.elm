module IdleGame.GameTypes exposing (..)

import IdleGame.Resource as Resource


type Toast
    = GainedGold Int
    | GainedResource Int Resource.Kind
