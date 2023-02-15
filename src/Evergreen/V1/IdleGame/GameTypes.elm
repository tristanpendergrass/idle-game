module Evergreen.V1.IdleGame.GameTypes exposing (..)

import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.Resource


type Toast
    = GainedCoin Evergreen.V1.IdleGame.Coin.Counter
    | GainedResource Int Evergreen.V1.IdleGame.Resource.Kind


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
