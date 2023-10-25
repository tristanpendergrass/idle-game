module Evergreen.V12.Percent exposing (..)

import Quantity


type Percentile
    = Percentile


type alias Percent =
    Quantity.Quantity Float Percentile
