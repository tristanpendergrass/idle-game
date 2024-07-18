module Evergreen.V1.IdleGame.OneTime exposing (..)


type alias OneTimeRecord a =
    { lab1 : a
    , lab2 : a
    }


type OneTimeId
    = Lab1
    | Lab2


type OneTimeStatus
    = NotOneTime
    | OneTime OneTimeId
