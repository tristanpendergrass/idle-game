module Percent exposing (..)

import Quantity exposing (Quantity(..))


type Percentile
    = Percentile


type alias Percent =
    Quantity Float Percentile


fromFloat : Float -> Percent
fromFloat p =
    Quantity p


toFloat : Percent -> Float
toFloat (Quantity p) =
    p


toNumber : Percent -> Float
toNumber (Quantity p) =
    p * 100
