module Evergreen.V12.IdleGame.Snapshot exposing (..)

import Time


type Snapshot t
    = Snapshot ( Time.Posix, t )
