module Config exposing (..)

import Env
import IdleGame.Tab as Tab exposing (Tab)
import Duration exposing (Duration)


version : String
version =
    "0.1.2"


type alias Flags =
    { showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Duration -- How many milliseconds to artificially add to the FastForward on init from backend
    , showDebugPanel : Bool
    , defaultTab : Tab
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
    , extraFastForwardTime = Duration.hours 8
    , showDebugPanel = True
    , defaultTab = Tab.Adventuring
    }


prodFlags : Flags
prodFlags =
    { showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showDebugPanel = False
    , defaultTab = Tab.Chores
    }
