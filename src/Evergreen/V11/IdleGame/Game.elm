module Evergreen.V11.IdleGame.Game exposing (..)

import Evergreen.V11.IdleGame.Adventuring
import Evergreen.V11.IdleGame.Chore
import Evergreen.V11.IdleGame.Counter
import Evergreen.V11.IdleGame.GameTypes
import Evergreen.V11.IdleGame.Resource
import Evergreen.V11.IdleGame.ShopItems
import Evergreen.V11.IdleGame.Xp
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V11.IdleGame.Xp.Xp
    , currentXp : Evergreen.V11.IdleGame.Xp.Xp
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V11.IdleGame.Counter.Counter
    , resourcesDiff : Evergreen.V11.IdleGame.Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , choresXp : Evergreen.V11.IdleGame.Xp.Xp
    , choresMxp : Evergreen.V11.IdleGame.Xp.Xp
    , activity : Maybe Evergreen.V11.IdleGame.GameTypes.Activity
    , choresData : Evergreen.V11.IdleGame.Chore.AllChoreStates
    , coin : Evergreen.V11.IdleGame.Counter.Counter
    , resources : Evergreen.V11.IdleGame.Resource.Amounts
    , shopItems : Evergreen.V11.IdleGame.ShopItems.ShopItems
    , adventuring : Evergreen.V11.IdleGame.Adventuring.Adventuring
    , combatsWon : Int
    , combatsLost : Int
    }
