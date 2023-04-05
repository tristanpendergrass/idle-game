module Evergreen.V7.IdleGame.Timer exposing (..)

import Evergreen.V7.Percent


type Timer
    = Timer
        { current : Evergreen.V7.Percent.Percent
        }
