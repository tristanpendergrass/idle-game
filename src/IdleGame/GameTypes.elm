module IdleGame.GameTypes exposing (..)

import IdleGame.Coin as Coin
import IdleGame.Resource as Resource


type ChoreKind
    = CleanStables
    | CleanBigBubba
    | SweepChimneys
    | WaterGreenhousePlants
    | WashAndIronRobes
    | OrganizePotionIngredients
    | RepairInstruments
    | FlushDrainDemons
    | OrganizeSpellBooks


type Toast
    = Gainedcoin Coin.Counter
    | GainedResource Int Resource.Kind


type alias IntervalMod =
    { kind : ChoreKind
    , percentChange : Float -- e.g. 0.25 -> 25% faster
    }
