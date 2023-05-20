module IdleGame.GameTypes exposing (..)

import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)


type Activity
    = ActivityChore ChoreKind Timer


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
    = GainedCoin Counter
    | GainedResource Int Resource.Kind


type alias IntervalMod =
    { kind : ChoreKind
    , percentChange : Float -- e.g. 0.25 -> 25% faster
    }
