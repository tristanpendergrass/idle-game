module IdleGame.Coin exposing (..)

import Quantity exposing (Quantity(..))


type SingleCoin
    = SingleCoin


type alias Coin =
    Quantity Float SingleCoin


int : Int -> Coin
int amount =
    Quantity (toFloat amount)


toInt : Coin -> Int
toInt (Quantity amount) =
    floor amount
