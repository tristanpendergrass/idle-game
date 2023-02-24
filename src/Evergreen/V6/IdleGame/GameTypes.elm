module Evergreen.V6.IdleGame.GameTypes exposing (..)

import Evergreen.V6.IdleGame.Counter
import Evergreen.V6.IdleGame.Resource


type Toast
    = GainedCoin Evergreen.V6.IdleGame.Counter.Counter
    | GainedResource Int Evergreen.V6.IdleGame.Resource.Kind


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
