module Config exposing (Flags, flags, version)

import Duration exposing (Duration)
import Env
import IdleGame.Tab as Tab exposing (Tab)


version : String
version =
    "0.1.2"


type alias Flags =
    { showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Duration -- How much time to artificially add to the FastForward on init from backend
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
    , extraFastForwardTime = Duration.hours 0
    , showDebugPanel = True
    , defaultTab = Tab.Chores
    }


prodFlags : Flags
prodFlags =
    { showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showDebugPanel = False
    , defaultTab = Tab.Chores
    }
