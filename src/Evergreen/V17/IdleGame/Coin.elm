module Evergreen.V17.IdleGame.Coin exposing (..)

import Quantity


type SingleCoin
    = SingleCoin


type alias Coin =
    Quantity.Quantity Float SingleCoin
