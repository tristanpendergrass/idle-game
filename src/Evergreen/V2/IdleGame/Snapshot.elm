module Evergreen.V2.IdleGame.Snapshot exposing (..)

import Time


type Snapshot t
    = Snapshot ( Time.Posix, t )
