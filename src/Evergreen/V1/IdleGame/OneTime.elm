module Evergreen.V1.IdleGame.OneTime exposing (..)


type alias OneTimeRecord a =
    { lab1 : a
    , lab2 : a
    , lab3 : a
    , lab4 : a
    , lab5 : a
    , lab6 : a
    }


type OneTimeId
    = Lab1
    | Lab2
    | Lab3
    | Lab4
    | Lab5
    | Lab6


type OneTimeStatus
    = NotOneTime
    | OneTime OneTimeId
