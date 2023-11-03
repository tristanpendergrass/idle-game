module Evergreen.V11.IdleGame.GameTypes exposing (..)

import Evergreen.V11.IdleGame.Counter
import Evergreen.V11.IdleGame.Resource
import Evergreen.V11.IdleGame.Timer


type Toast
    = GainedCoin Evergreen.V11.IdleGame.Counter.Counter
    | GainedResource Int Evergreen.V11.IdleGame.Resource


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


type Activity
    = ActivityChore ChoreKind Evergreen.V11.IdleGame.Timer.Timer
