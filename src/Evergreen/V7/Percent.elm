module Evergreen.V7.Percent exposing (..)

import Quantity


type Percentile
    = Percentile


type alias Percent =
    Quantity.Quantity Float Percentile
