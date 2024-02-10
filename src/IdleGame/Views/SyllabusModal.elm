module IdleGame.Views.SyllabusModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Svg.Attributes exposing (d, in_)
import Types exposing (..)


render : Game -> Skill -> Html FrontendMsg
render game skill =
    let
        skillStats : Skill.Stats
        skillStats =
            Skill.getStats skill
    in
    div [ class "t-column gap-6" ]
        [ h3 [ class "font-bold text-lg" ] [ text ("Syllabus: " ++ skillStats.title) ]
        ]
