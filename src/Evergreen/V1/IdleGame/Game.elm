module Evergreen.V1.IdleGame.Game exposing (..)

import Evergreen.V1.IdleGame.Chore
import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.GameTypes
import Evergreen.V1.IdleGame.Resource
import Evergreen.V1.IdleGame.ShopItems
import Evergreen.V1.IdleGame.Timer
import Random


type alias TimePassesXpGain =
    { originalXp : Float
    , currentXp : Float
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V1.IdleGame.Coin.Counter
    , resourcesDiff : Evergreen.V1.IdleGame.Resource.Diff
    }


type alias Game =
    { seed : Random.Seed
    , choresXp : Float
    , choresMxp : Float
    , activeChore : Maybe ( Evergreen.V1.IdleGame.GameTypes.ChoreKind, Evergreen.V1.IdleGame.Timer.Timer )
    , choresData : Evergreen.V1.IdleGame.Chore.AllChoreStates
    , coin : Evergreen.V1.IdleGame.Coin.Counter
    , resources : Evergreen.V1.IdleGame.Resource.Amounts
    , shopItems : Evergreen.V1.IdleGame.ShopItems.ShopItems
    }
