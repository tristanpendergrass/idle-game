module Config exposing (Flags, flags, version)

import Duration exposing (Duration)
import Env
import IdleGame.Tab as Tab exposing (Tab)
import Types exposing (..)


version : String
version =
    "0.2"


type alias Flags =
    { isDev : Bool -- Catchall boolean for anyting that needs to be different between dev and prod
    , showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Duration -- How much time to artificially add to the FastForward on init from backend
    , showTimePasses : Bool
    , showDebugPanel : Bool
    , defaultMode : Mode
    , defaultTabSkilling : Tab
    , defaultTabAdventuring : Tab
    , defaultDetailViewExpanded : Bool
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
    -- (\_/)
    -- (^_^) < "Here are the dev flags :)"
    -- c(")(")
    { isDev = True
    , showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showTimePasses = False
    , showDebugPanel = True
    , defaultMode = Skilling
    , defaultTabSkilling = Tab.Shop
    , defaultTabAdventuring = Tab.CombatTab1
    , defaultDetailViewExpanded = True
    }


prodFlags : Flags
prodFlags =
    -- WARNING!! THESE ARE PROD FLAGS!!
    { isDev = False
    , showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showTimePasses = True

    -- , showDebugPanel = False
    , showDebugPanel = True -- Setting to True for now so play testers can enjoy
    , defaultMode = Skilling
    , defaultTabSkilling = Tab.Chores
    , defaultTabAdventuring = Tab.CombatTab1
    , defaultDetailViewExpanded = False
    }
