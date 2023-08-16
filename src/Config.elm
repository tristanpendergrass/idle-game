module Config exposing (Flags, flags, version)

import Duration exposing (Duration)
import Env
import IdleGame.Tab as Tab exposing (Tab)
import Types exposing (..)


version : String
version =
    "0.1.2"


type alias Flags =
    { showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Duration -- How much time to artificially add to the FastForward on init from backend
    , showTimePasses : Bool
    , showDebugPanel : Bool
    , defaultMode : Mode
    , defaultSkillTab : Tab
    , defaultCombatTab : Tab
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
    { showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showTimePasses = False
    , showDebugPanel = True
    , defaultMode = Combat
    , defaultSkillTab = Tab.Shop
    , defaultCombatTab = Tab.SchoolGrounds
    , defaultDetailViewExpanded = False
    }


prodFlags : Flags
prodFlags =
    -- WARNING!! THESE ARE PROD FLAGS!!
    { showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showTimePasses = True
    , showDebugPanel = False
    , defaultMode = Skill
    , defaultSkillTab = Tab.Shop
    , defaultCombatTab = Tab.SchoolGrounds
    , defaultDetailViewExpanded = False
    }
