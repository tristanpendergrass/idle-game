module Evergreen.V17.IdleGame.Timer exposing (..)

import Evergreen.V17.Percent


type Timer
    = Timer
        { current : Evergreen.V17.Percent.Percent
        }
