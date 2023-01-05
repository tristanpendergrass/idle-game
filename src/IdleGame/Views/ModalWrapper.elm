module IdleGame.Views.ModalWrapper exposing (Modal, closeButton, create, render, withBorderColor)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Types exposing (..)


type alias Options =
    { borderColor : Maybe String }


type Modal
    = Modal Options (Html FrontendMsg)


create : Html FrontendMsg -> Modal
create children =
    Modal { borderColor = Nothing } children


withBorderColor : String -> Modal -> Modal
withBorderColor color (Modal opts children) =
    Modal { opts | borderColor = Just color } children


render : Modal -> Html FrontendMsg
render (Modal { borderColor } children) =
    let
        borderColorAttr =
            case borderColor of
                Nothing ->
                    class ""

                Just color ->
                    class <| "border-t-4 " ++ color
    in
    div
        [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 z-10 flex justify-center items-center cursor-pointer"
        , onClick CloseModal
        ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in border-t-4 border-secondary"
            , borderColorAttr
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            [ children ]
        ]


closeButton : Html FrontendMsg
closeButton =
    button [ class "btn btn-primary", onClick CloseModal ]
        [ text "Done" ]
