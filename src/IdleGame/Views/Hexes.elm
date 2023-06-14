module IdleGame.Views.Hexes exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Multiplicable as Multiplicable exposing (Multiplicable)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
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
        [ Utils.xpSection game.xp.hexes
        , div [ Utils.skills.grid ]
            (List.map (renderHexListItem game) (Game.getChoreListItems game))
        ]


renderHexListItem _ _ =
    div [] []