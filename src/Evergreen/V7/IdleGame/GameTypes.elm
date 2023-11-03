module Evergreen.V7.IdleGame.GameTypes exposing (..)

import Evergreen.V7.IdleGame.Counter
import Evergreen.V7.IdleGame.Resource


type Toast
    = GainedCoin Evergreen.V7.IdleGame.Counter.Counter
    | GainedResource Int Evergreen.V7.IdleGame.Resource


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
