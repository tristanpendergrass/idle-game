module Evergreen.V6.IdleGame.Timer exposing (..)


type alias PercentComplete =
    Float


type Timer
    = Timer
        { current : PercentComplete
        }
