module Evergreen.V1.Percent exposing (..)

import Quantity


type Percentile
    = Percentile


type alias Percent =
    Quantity.Quantity Float Percentile
