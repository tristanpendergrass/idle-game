module IdleGame.Views.ModalWrapper exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import Json.Decode
import Types exposing (..)


renderModal : List (Html FrontendMsg) -> Html FrontendMsg
renderModal children =
    div [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 z-10 flex justify-center items-center cursor-pointer", onClick CloseModal ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in"
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            children
        ]


renderCloseButton : Html FrontendMsg
renderCloseButton =
    button [ class "btn btn-primary", onClick CloseModal ]
        [ text "Done" ]
