module Evergreen.V10.IdleGame.Game exposing (..)

import Evergreen.V10.IdleGame.Adventuring
import Evergreen.V10.IdleGame.Chore
import Evergreen.V10.IdleGame.Counter
import Evergreen.V10.IdleGame.GameTypes
import Evergreen.V10.IdleGame.Resource
import Evergreen.V10.IdleGame.ShopItems
import Evergreen.V10.IdleGame.Timer
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V10.IdleGame.Counter.Counter
    , currentXp : Evergreen.V10.IdleGame.Counter.Counter
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V10.IdleGame.Counter.Counter
    , resourcesDiff : Evergreen.V10.IdleGame.Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , choresXp : Evergreen.V10.IdleGame.Counter.Counter
    , choresMxp : Evergreen.V10.IdleGame.Counter.Counter
    , activeChore : Maybe ( Evergreen.V10.IdleGame.GameTypes.ChoreKind, Evergreen.V10.IdleGame.Timer.Timer )
    , choresData : Evergreen.V10.IdleGame.Chore.AllChoreStates
    , coin : Evergreen.V10.IdleGame.Counter.Counter
    , resources : Evergreen.V10.IdleGame.Resource.Amounts
    , shopItems : Evergreen.V10.IdleGame.ShopItems.ShopItems
    , adventuring : Evergreen.V10.IdleGame.Adventuring.Adventuring
    , combatsWon : Int
    , combatsLost : Int
    }
