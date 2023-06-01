module Evergreen.V11.IdleGame.Chore exposing (..)

import Evergreen.V11.IdleGame.Xp


type alias State =
    { mxp : Evergreen.V11.IdleGame.Xp.Xp
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
