module Evergreen.V1.IdleGame.Timer exposing (..)


type alias PercentComplete =
    Float


type Timer
    = Timer
        { current : PercentComplete
        }
