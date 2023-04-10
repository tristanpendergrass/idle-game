module Evergreen.V10.IdleGame.Chore exposing (..)

import Evergreen.V10.IdleGame.Counter


type alias State =
    { mxp : Evergreen.V10.IdleGame.Counter.Counter
    }


type alias AllChoreStates =
    { cleanStables : State
    , cleanBigBubba : State
    , sweepChimneys : State
    , waterGreenhousePlants : State
    , washRobes : State
    , organizePotionIngredients : State
    , repairInstruments : State
    , flushDrainDemons : State
    , organizeSpellBooks : State
    }
