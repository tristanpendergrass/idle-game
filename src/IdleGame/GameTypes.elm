module IdleGame.GameTypes exposing (..)

import IdleGame.Resource as Resource


type ChoreType
    = CleanStables
    | CleanBigBubba
    | GatherFirewood


type Toast
    = GainedGold Int
    | GainedResource Int Resource.Kind
