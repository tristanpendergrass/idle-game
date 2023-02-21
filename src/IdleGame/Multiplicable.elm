module IdleGame.Multiplicable exposing
    ( Multiplicable
    , addMultiplier
    , fromCounter
    , fromInt
    , toCounter
    )

import IdleGame.Counter as Counter exposing (Counter)


type Multiplicable
    = Multiplicable { base : Counter, multiplier : Float }


fromInt : Int -> Multiplicable
fromInt =
    Counter.create >> fromCounter


fromCounter : Counter -> Multiplicable
fromCounter base =
    Multiplicable { base = base, multiplier = 1 }


toCounter : Multiplicable -> Counter
toCounter (Multiplicable { base, multiplier }) =
    base
        |> Counter.multiplyBy multiplier


addMultiplier : Float -> Multiplicable -> Multiplicable
addMultiplier amount (Multiplicable { base, multiplier }) =
    Multiplicable { base = base, multiplier = multiplier + amount }
