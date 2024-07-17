module Config exposing (Flags, flags, version)

import Duration exposing (Duration)
import Env
import IdleGame.Kinds exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import Types exposing (..)


version : String
version =
    "0.1"


type alias Flags =
    { isDev : Bool -- Catchall boolean for anyting that needs to be different between dev and prod
    , showFastForwardSpeed : Bool -- Whether to show the "speed" of fast forward while it's active under the progress bar
    , extraFastForwardTime : Duration -- How much time to artificially add to the FastForward on init from backend
    , debugTimePasses : Bool -- If True then Time Passes with mock values will appear when app starts
    , showTimePasses : Bool
    , showDebugPanel : Bool
    , defaultTab : Tab
    , maxOutSkillXp : Bool
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
    , showFastForwardSpeed = True
    , extraFastForwardTime = Duration.hours 0
    , debugTimePasses = False
    , showTimePasses = True
    , showDebugPanel = True

    -- , defaultTab = Tab.SkillTab Anatomy
    , defaultTab = Tab.SkillTab Labs

    -- , defaultTab = Tab.TestingCenter
    , maxOutSkillXp = True
    }


prodFlags : Flags
prodFlags =
    -- WARNING!! THESE ARE PROD FLAGS!!
    { isDev = False
    , showFastForwardSpeed = False
    , extraFastForwardTime = Duration.hours 0
    , showTimePasses = True
    , showDebugPanel = True -- Setting to True for now so play testers can enjoy
    , defaultTab = Tab.SkillTab Anatomy
    , debugTimePasses = False
    , maxOutSkillXp = False
    }
