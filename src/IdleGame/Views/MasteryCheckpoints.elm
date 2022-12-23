module IdleGame.Views.MasteryCheckpoints exposing (..)

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


render : { mxp : Float, checkpoints : IdleGame.Game.MasteryPoolCheckpoints } -> Html FrontendMsg
render { mxp, checkpoints } =
    let
        masteryPercent =
            IdleGame.XpFormulas.masteryPoolPercent mxp

        masteryPercentLabel =
            Round.round 2 masteryPercent
    in
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-lg font-bold" ] [ text "Mastery Pool Checkpoints" ]
        , div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-end" ]
                [ div [ class "text-2xs flex gap-1" ] [ span [] [ text <| String.fromInt (floor mxp) ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
                ]
            , div [ class "w-full flex items-center gap-2" ]
                [ div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                    [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat masteryPercent ++ "%") ] []
                    ]
                ]
            ]
        , div [ class "t-column" ]
            [ renderCheckpoint { number = 10, label = checkpoints.ten.label, isActive = masteryPercent >= 10.0 }
            , renderCheckpoint { number = 25, label = checkpoints.twentyFive.label, isActive = masteryPercent >= 25.0 }
            , renderCheckpoint { number = 50, label = checkpoints.fifty.label, isActive = masteryPercent >= 50.0 }
            , renderCheckpoint { number = 95, label = checkpoints.ninetyFive.label, isActive = masteryPercent >= 95.0 }
            ]
        , IdleGame.Views.ModalWrapper.closeButton
        ]
