module Evergreen.V17.IdleGame.Snapshot exposing (..)

import Time


type Snapshot t
    = Snapshot ( Time.Posix, t )
