module IdleGame.Views.MasteryCheckpoints exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event
import IdleGame.Game
import IdleGame.Views.ModalWrapper
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity exposing (Quantity)
import Round
import Types exposing (..)


masteryPoolPercent : Xp -> Percent
masteryPoolPercent amount =
    Percent.fromFloat (toFloat (Xp.toInt amount) / 4500000)


renderCheckpoint : { percent : Percent, label : Event.ModLabel, isActive : Bool } -> Html FrontendMsg
renderCheckpoint { percent, label, isActive } =
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
            [ text <| Utils.floatToString 0 (Percent.toPercentage percent) ++ "%" ]
        , div [ class "flex-grow text-success" ] [ text <| Event.modLabelToString label ]
        ]


render : { poolXp : Xp, checkpoints : IdleGame.Game.MasteryPoolCheckpoints } -> Html FrontendMsg
render { poolXp, checkpoints } =
    let
        poolPercent : Percent
        poolPercent =
            poolXp
                |> masteryPoolPercent

        poolPercentLabel : String
        poolPercentLabel =
            poolPercent
                |> Percent.toPercentage
                |> Utils.floatToString 2
    in
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-lg font-bold" ] [ text "Mastery Pool Checkpoints" ]
        , div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-end" ]
                [ div [ class "text-2xs flex gap-1" ] [ span [] [ text <| Xp.toString poolXp ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ poolPercentLabel ++ "%)" ] ]
                ]
            , div [ class "w-full flex items-center gap-2" ]
                [ div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                    [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat (Percent.toFloat poolPercent) ++ "%") ] []
                    ]
                ]
            ]
        , div [ class "t-column" ]
            [ renderCheckpoint
                { percent = Percent.fromFloat 0.1
                , label = checkpoints.ten.label
                , isActive = Quantity.greaterThan (Percent.fromFloat 0.1) poolPercent
                }
            , renderCheckpoint
                { percent = Percent.fromFloat 0.25
                , label = checkpoints.twentyFive.label
                , isActive = Quantity.greaterThan (Percent.fromFloat 0.25) poolPercent
                }
            , renderCheckpoint
                { percent = Percent.fromFloat 0.5
                , label = checkpoints.fifty.label
                , isActive = Quantity.greaterThan (Percent.fromFloat 0.5) poolPercent
                }
            , renderCheckpoint
                { percent = Percent.fromFloat 0.95
                , label = checkpoints.ninetyFive.label
                , isActive = Quantity.greaterThan (Percent.fromFloat 0.95) poolPercent
                }
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
