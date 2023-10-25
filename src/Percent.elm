module Percent exposing (..)

import Quantity exposing (Quantity(..))


type Percentile
    = Percentile


type alias Percent =
    Quantity Float Percentile


float : Float -> Percent
float p =
    Quantity p


toFloat : Percent -> Float
toFloat (Quantity p) =
    p


toPercentage : Percent -> Float
toPercentage (Quantity p) =
    p * 100


capAtHundred : Percent -> Percent
capAtHundred (Quantity p) =
    Quantity (min 100 p)
