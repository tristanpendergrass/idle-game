module IdleGame.Views.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


renderMain : Html msg
renderMain =
    div [ class "text-red-500" ] [ text "Why hello there" ]
