module IdleGame.GameTypes exposing (..)

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
    = GainedGold Int
    | GainedResource Int Resource.Kind
