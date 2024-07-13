module IdleGame.Views.SubjectViews exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect exposing (Effect)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Types exposing (..)


renderSubject : Skill -> Game -> ActivityRecord (List Effect) -> Html FrontendMsg
renderSubject skill game cachedActivityEffects =
    div [ Utils.skills.wrapper ]
        [ Utils.classTopNav { xp = getBySkill skill game.xp, skill = skill }
        , div [ Utils.skills.grid ]
            (List.map (ActivityView.renderActivityListItem game) (Game.getActivityListItems skill game cachedActivityEffects))
        ]
