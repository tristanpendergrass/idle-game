module Evergreen.V7.IdleGame.Game exposing (..)

import Evergreen.V7.IdleGame.Adventuring
import Evergreen.V7.IdleGame.Chore
import Evergreen.V7.IdleGame.Counter
import Evergreen.V7.IdleGame.GameTypes
import Evergreen.V7.IdleGame.Resource
import Evergreen.V7.IdleGame.ShopItems
import Evergreen.V7.IdleGame.Timer
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V7.IdleGame.Counter.Counter
    , currentXp : Evergreen.V7.IdleGame.Counter.Counter
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V7.IdleGame.Counter.Counter
    , resourcesDiff : Evergreen.V7.IdleGame.Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , choresXp : Evergreen.V7.IdleGame.Counter.Counter
    , choresMxp : Evergreen.V7.IdleGame.Counter.Counter
    , activeChore : Maybe ( Evergreen.V7.IdleGame.GameTypes.ChoreKind, Evergreen.V7.IdleGame.Timer.Timer )
    , choresData : Evergreen.V7.IdleGame.Chore.AllChoreStates
    , coin : Evergreen.V7.IdleGame.Counter.Counter
    , resources : Evergreen.V7.IdleGame.Resource.Amounts
    , shopItems : Evergreen.V7.IdleGame.ShopItems.ShopItems
    , adventuringState : Evergreen.V7.IdleGame.Adventuring.State
    , adventuringTimer : Maybe Evergreen.V7.IdleGame.Timer.Timer
    , combatsWon : Int
    , combatsLost : Int
    }
