module Evergreen.V11.IdleGame.Timer exposing (..)

import Evergreen.V11.Percent


type Timer
    = Timer
        { current : Evergreen.V11.Percent.Percent
        }
