module IdleGame.Views.Bag exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import Types exposing (..)


render : Game -> Html FrontendMsg
render _ =
    div [ class "t-column gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        []


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
