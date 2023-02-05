module IdleGame.Views.ModalWrapper exposing (Modal, create, render, renderCloseButton, withBorderColor)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Views.Utils
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


renderCloseButton : Html FrontendMsg
renderCloseButton =
    button [ class "btn btn-primary", onClick CloseModal ]
        [ text "Done" ]


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
        [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 flex justify-center items-center cursor-pointer"
        , IdleGame.Views.Utils.zIndexes.modalWrapper
        , onClick CloseModal
        ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in border-t-4"
            , borderColorAttr
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            [ children ]
        ]
