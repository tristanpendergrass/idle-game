module Evergreen.V1.IdleGame.Timer exposing (..)

import Evergreen.V1.Percent


type Timer
    = Timer
        { current : Evergreen.V1.Percent.Percent
        }
