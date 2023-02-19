module Config exposing (..)

import Env


type alias Flags =
    { showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Int -- How many milliseconds to artificially add to the FastForward on init from backend
    , showDebugPanel : Bool
    }


flags : Flags
flags =
    case Env.mode of
        Env.Development ->
            devFlags

        Env.Production ->
            prodFlags


devFlags : Flags
devFlags =
    { showFastForwardSpeed = True
    , extraFastForwardTime = 1000 * 60 * 60 * 8 -- 8 hours
    , showDebugPanel = True
    }


prodFlags : Flags
prodFlags =
    { showFastForwardSpeed = False
    , extraFastForwardTime = 0
    , showDebugPanel = False
    }
