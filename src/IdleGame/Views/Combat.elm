module IdleGame.Views.Combat exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Combat
import IdleGame.Game
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    div [] [ text "Combat" ]
