module IdleGame.Views.CombatTab1 exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Effect, Event)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill exposing (Kind(..))
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    div [ Utils.skills.wrapper ]
        [ Utils.xpSection (Xp.int 0)
        , div [ Utils.skills.grid ]
            (List.map (ActivityView.renderActivityListItem game) (Game.getMonsterListItems game))
        ]