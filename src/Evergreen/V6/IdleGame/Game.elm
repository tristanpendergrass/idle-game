module Evergreen.V6.IdleGame.Game exposing (..)

import Evergreen.V6.IdleGame.Chore
import Evergreen.V6.IdleGame.Counter
import Evergreen.V6.IdleGame.GameTypes
import Evergreen.V6.IdleGame.Resource
import Evergreen.V6.IdleGame.ShopItems
import Evergreen.V6.IdleGame.Timer
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V6.IdleGame.Counter.Counter
    , currentXp : Evergreen.V6.IdleGame.Counter.Counter
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V6.IdleGame.Counter.Counter
    , resourcesDiff : Evergreen.V6.IdleGame.Resource.Diff
    }


type alias Game =
    { seed : Random.Seed
    , choresXp : Evergreen.V6.IdleGame.Counter.Counter
    , choresMxp : Evergreen.V6.IdleGame.Counter.Counter
    , activeChore : Maybe ( Evergreen.V6.IdleGame.GameTypes.ChoreKind, Evergreen.V6.IdleGame.Timer.Timer )
    , choresData : Evergreen.V6.IdleGame.Chore.AllChoreStates
    , coin : Evergreen.V6.IdleGame.Counter.Counter
    , resources : Evergreen.V6.IdleGame.Resource.Amounts
    , shopItems : Evergreen.V6.IdleGame.ShopItems.ShopItems
    }
