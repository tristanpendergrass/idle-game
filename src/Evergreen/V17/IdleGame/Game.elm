module Evergreen.V17.IdleGame.Game exposing (..)

import Evergreen.V17.IdleGame.Coin
import Evergreen.V17.IdleGame.Kinds
import Evergreen.V17.IdleGame.Location
import Evergreen.V17.IdleGame.Quest
import Evergreen.V17.IdleGame.Resource
import Evergreen.V17.IdleGame.Timer
import Evergreen.V17.IdleGame.Xp
import Random


type alias TimePassesXpGain =
    { originalXp : Evergreen.V17.IdleGame.Xp.Xp
    , currentXp : Evergreen.V17.IdleGame.Xp.Xp
    , skill : Evergreen.V17.IdleGame.Kinds.Skill
    }


type TimePassesDiscovery
    = DiscoveredMonster Evergreen.V17.IdleGame.Kinds.Monster
    | DiscoveredQuest Evergreen.V17.IdleGame.Kinds.Quest
    | DiscoveredResource Evergreen.V17.IdleGame.Kinds.Resource


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , discoveries : List TimePassesDiscovery
    , coinGains : Maybe Evergreen.V17.IdleGame.Coin.Coin
    , resourcesDiff : Evergreen.V17.IdleGame.Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , xp : Evergreen.V17.IdleGame.Kinds.SkillRecord Evergreen.V17.IdleGame.Xp.Xp
    , mxp : Evergreen.V17.IdleGame.Kinds.ActivityRecord Evergreen.V17.IdleGame.Xp.Xp
    , locations : Evergreen.V17.IdleGame.Kinds.LocationRecord Evergreen.V17.IdleGame.Location.State
    , quests : Evergreen.V17.IdleGame.Kinds.QuestRecord Evergreen.V17.IdleGame.Quest.State
    , choresMxp : Evergreen.V17.IdleGame.Xp.Xp
    , activitySkilling : Maybe ( Evergreen.V17.IdleGame.Kinds.Activity, Evergreen.V17.IdleGame.Timer.Timer )
    , activityAdventuring : Maybe ( Evergreen.V17.IdleGame.Kinds.Activity, Evergreen.V17.IdleGame.Timer.Timer )
    , monster : Maybe Evergreen.V17.IdleGame.Kinds.Monster
    , coin : Evergreen.V17.IdleGame.Coin.Coin
    , resources : Evergreen.V17.IdleGame.Kinds.ResourceRecord Int
    , ownedShopUpgrades : Evergreen.V17.IdleGame.Kinds.ShopUpgradeRecord Bool
    , combatsWon : Int
    , combatsLost : Int
    , spellSelectors : Evergreen.V17.IdleGame.Kinds.ActivityRecord (Maybe Evergreen.V17.IdleGame.Kinds.Spell)
    }
