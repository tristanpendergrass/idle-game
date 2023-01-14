module IdleGame.Views.MasteryUnlocks exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Views.ModalWrapper
import IdleGame.XpFormulas
import Json.Decode
import Round
import Types exposing (..)


renderCheckpoint : { number : Int, label : String, isActive : Bool } -> Html FrontendMsg
renderCheckpoint { number, label, isActive } =
    div
        [ class "flex w-full items-center gap-4 p-2"
        ]
        [ div
            [ class "text-xl font-bold leading-none"
            , class <|
                if isActive then
                    "text-success underline"

                else
                    ""
            ]
            [ text <| String.fromInt number ++ "%" ]
        , div [ class "flex-grow" ] [ text label ]
        ]


render : { masteryUnlocks : IdleGame.Game.MasteryUnlocks } -> Html FrontendMsg
render { masteryUnlocks } =
    let
        mod =
            case masteryUnlocks of
                IdleGame.Game.EveryTenLevels m ->
                    m
    in
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-lg font-bold" ] [ text "Chores Mastery Unlocks" ]
        , div [ class "flex gap-1" ]
            [ span [] [ text <| "Every 10 levels provides" ]
            , span [ class "text-success" ] [ text mod.label ]
            ]
        , IdleGame.Views.ModalWrapper.closeButton
        ]
