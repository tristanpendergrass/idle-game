module Evergreen.V2.IdleGame.Timer exposing (..)

import Evergreen.V2.Percent


type Timer
    = Timer
        { current : Evergreen.V2.Percent.Percent
        }
