module Evergreen.V2.IdleGame.OneTime exposing (..)


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


type alias OneTimeRecord a =
    { lab1 : a
    , lab2 : a
    , lab3 : a
    , lab4 : a
    , lab5 : a
    , lab6 : a
    }
