module Evergreen.V10.IdleGame.GameTypes exposing (..)

import Evergreen.V10.IdleGame.Counter
import Evergreen.V10.IdleGame.Resource


type Toast
    = GainedCoin Evergreen.V10.IdleGame.Counter.Counter
    | GainedResource Int Evergreen.V10.IdleGame.Resource.Kind


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
