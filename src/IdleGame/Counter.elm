module IdleGame.Counter exposing
    ( Counter
    , add
    , create
    , getValue
    , multiplyBy
    , subtract
    , toString
    )

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


getValue : Counter -> Int
getValue (Counter val) =
    floor val


multiplyBy : Float -> Counter -> Counter
multiplyBy amount (Counter oldVal) =
    Counter (amount * oldVal)


toString : Counter -> String
toString =
    getValue >> IdleGame.Views.Utils.intToString
