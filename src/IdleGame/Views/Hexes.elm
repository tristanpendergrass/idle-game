module IdleGame.Views.Hexes exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity
import IdleGame.Views.Effect
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)
import Quantity
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    div [ Utils.skills.wrapper ]
        [ Utils.xpSection Hexes game.xp.hexes
        , div [ Utils.skills.grid ]
            (List.map (IdleGame.Views.Activity.renderActivityListItem game) (Game.getActivityListItems Hexes game))
        ]
