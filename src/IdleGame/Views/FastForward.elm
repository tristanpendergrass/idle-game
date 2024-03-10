module IdleGame.Views.FastForward exposing (..)

import Config
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


render : Html FrontendMsg
render =
    div
        [ class "w-screen h-full flex flex-col gap-2 items-center justify-center"
        ]
        [ div [] [ text "Fast Forwarding..." ]
        , progress [ class "progress progress-primary w-56" ] []
        ]
