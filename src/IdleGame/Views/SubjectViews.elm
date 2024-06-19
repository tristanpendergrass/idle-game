module IdleGame.Views.SubjectViews exposing (..)

import Html exposing (..)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Utils as Utils
import Types exposing (..)


renderSubject : Skill -> Game -> Html FrontendMsg
renderSubject skill game =
    div [ Utils.skills.wrapper ]
        [ Utils.classTopNav { xp = getBySkill skill game.xp, skill = skill }
        , div [ Utils.skills.grid ]
            (List.map (ActivityView.renderActivityListItem game) (Game.getActivityListItems skill game))
        ]
