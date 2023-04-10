module Evergreen.V10.IdleGame.Timer exposing (..)

import Evergreen.V10.Percent


type Timer
    = Timer
        { current : Evergreen.V10.Percent.Percent
        }
