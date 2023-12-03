module IdleGame.Mocks exposing (..)

import Duration exposing (Duration)
import Html.Attributes exposing (download)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Maybe.Extra
import Percent exposing (Percent)
import Quantity
import Random exposing (Generator)
import Time
import Tuple
import Types exposing (..)


timePassesModal : Modal
timePassesModal =
    let
        time : Time.Posix
        time =
            Time.millisToPosix (1000 * 60 * 10)

        data : Game.TimePassesData
        data =
            { xpGains =
                [ { originalXp = Xp.int 0, currentXp = Xp.int 100, skill = Hexes }
                ]
            , discoveries = [ Game.DiscoveredMonster Prefect, Game.DiscoveredQuest MendCrackedBell, Game.DiscoveredResource EmptyBottle ]
            , coinGains = Nothing
            , resourcesDiff = resourceRecord 0
            , combatsWonDiff = 0
            , combatsLostDiff = 0
            }
    in
    TimePassesModal time data
