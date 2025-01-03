module IdleGame.Views.MainMenu exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


render : MainMenuFrontend -> Html FrontendMsg
render mainMenuFrontend =
    div [ class "w-full h-full flex justify-center p-20" ]
        [ case mainMenuFrontend.mainMenuRoute of
            MainMenuGatekeeper ->
                div [ class "t-column w-[320px] bg-base-200 rounded-log p-4" ]
                    [ h1 [ class "text-2xl font-bold text-center" ] [ text "Welcome to Idle Game" ]
                    ]

            MainMenuLogin ->
                div [ class "t-column w-[320px] bg-base-200 rounded-lg shadow-lg p-4" ]
                    [ h1 [ class "text-2xl font-bold text-center" ] [ text "Welcome to Idle Game" ]
                    ]

            MainMenuGameList ->
                Debug.todo ""
        ]
