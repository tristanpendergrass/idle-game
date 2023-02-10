module IdleGame.Coin exposing (..)

import IdleGame.Views.Utils


type Counter
    = Counter Float


create : Int -> Counter
create init =
    Counter (toFloat init)


add : Counter -> Counter -> Counter
add (Counter val1) (Counter val2) =
    Counter (val1 + val2)


subtract : Counter -> Counter -> Counter
subtract (Counter val1) (Counter val2) =
    Counter (val1 - val2)


getVal : Counter -> Int
getVal (Counter val) =
    floor val


multiplyBy : Float -> Counter -> Counter
multiplyBy amount (Counter oldVal) =
    Counter (amount * oldVal)


toString : Counter -> String
toString =
    getVal >> IdleGame.Views.Utils.intToString
