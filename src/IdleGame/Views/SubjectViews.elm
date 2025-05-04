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
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Types exposing (..)


renderSubject : Skill -> Game -> ActivityRecord (List Effect) -> Html FrontendMsg
renderSubject skill game cachedActivityEffects =
    div [ IdleGame.Views.Utils.classes.column, class "gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ IdleGame.Views.Utils.classTopNav { xp = getBySkill skill game.xp, skill = skill }
        , div [ class "w-full grid grid-cols-2 md:grid-cols-3 2xl:grid-cols-4 gap-2 2xl:gap-4" ]
            (List.map (ActivityView.renderActivityListItem game) (Game.getActivityListItems skill game cachedActivityEffects))
        ]
