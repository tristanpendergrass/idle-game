module IdleGame.Mocks exposing (..)

import Duration exposing (Duration)
import Html.Attributes exposing (download)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Skill as Skill
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
        duration : Duration
        duration =
            Duration.seconds 10

        time : Time.Posix
        time =
            Time.millisToPosix (1000 * 60 * 10)

        data : TimePassesData
        data =
            { xpGains =
                [ { originalXp = Xp.int 0, currentXp = Xp.int 100, skill = HerbGathering }
                ]
            , coinGains = Nothing
            , resourcesDiff = resourceRecord 0
            }
    in
    TimePassesModal duration time data
