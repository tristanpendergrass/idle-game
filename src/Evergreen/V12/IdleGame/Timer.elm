module Evergreen.V12.IdleGame.Timer exposing (..)

import Evergreen.V12.Percent


type Timer
    = Timer
        { current : Evergreen.V12.Percent.Percent
        }
