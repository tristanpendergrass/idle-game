module IdleGame.Views.MasteryCheckpoints exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Types exposing (..)


render : Html FrontendMsg
render =
    div
        [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 z-10 flex justify-center items-center cursor-pointer" ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in"
            , class "flex flex-col justify-center items-center gap-4"
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            []
        ]
