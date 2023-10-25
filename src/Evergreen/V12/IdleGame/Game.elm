module Evergreen.V12.IdleGame.Game exposing (..)

import Evergreen.V12.IdleGame.Activity
import Evergreen.V12.IdleGame.Coin
import Evergreen.V12.IdleGame.Kinds.Activities
import Evergreen.V12.IdleGame.Kinds.Monsters
import Evergreen.V12.IdleGame.Kinds.Spells
import Evergreen.V12.IdleGame.Resource
import Evergreen.V12.IdleGame.ShopItems
import Evergreen.V12.IdleGame.Skill
import Evergreen.V12.IdleGame.Timer
import Evergreen.V12.IdleGame.Xp
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V12.IdleGame.Xp.Xp
    , currentXp : Evergreen.V12.IdleGame.Xp.Xp
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V12.IdleGame.Coin.Coin
    , resourcesDiff : Evergreen.V12.IdleGame.Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , xp : Evergreen.V12.IdleGame.Skill.Record Evergreen.V12.IdleGame.Xp.Xp
    , mxp : Evergreen.V12.IdleGame.Activity.Record Evergreen.V12.IdleGame.Xp.Xp
    , choresMxp : Evergreen.V12.IdleGame.Xp.Xp
    , activitySkilling : Maybe ( Evergreen.V12.IdleGame.Kinds.Activities.Activity, Evergreen.V12.IdleGame.Timer.Timer )
    , activityAdventuring : Maybe ( Evergreen.V12.IdleGame.Kinds.Activities.Activity, Evergreen.V12.IdleGame.Timer.Timer )
    , monster : Maybe Evergreen.V12.IdleGame.Kinds.Monsters.Monster
    , coin : Evergreen.V12.IdleGame.Coin.Coin
    , resources : Evergreen.V12.IdleGame.Resource.Record Int
    , shopItems : Evergreen.V12.IdleGame.ShopItems.ShopItems
    , combatsWon : Int
    , combatsLost : Int
    , spellSelectors : Evergreen.V12.IdleGame.Activity.Record (Maybe Evergreen.V12.IdleGame.Kinds.Spells.Spell)
    }
