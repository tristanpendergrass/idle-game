module IdleGame.Views.MasteryUnlocks exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Views.ModalWrapper
import IdleGame.Views.Utils
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
            [ text <| IdleGame.Views.Utils.intToString number ++ "%" ]
        , div [ class "flex-grow" ] [ text label ]
        ]


render : Html FrontendMsg
render =
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-lg font-bold" ] [ text "Chores Mastery Unlocks" ]
        , div [ class "flex gap-1" ]
            [ span [ class "underline" ] [ text <| "Every 10 levels:" ]
            , span [ class "text-success" ] [ text "+5% chance to gain items" ]
            ]
        , div [ class "flex gap-1" ]
            [ span [ class "underline" ] [ text <| "50:" ]
            , span [ class "text-success" ] [ text "+10% faster at this chore" ]
            ]
        , div [ class "flex gap-1" ]
            [ span [ class "underline" ] [ text <| "99:" ]
            , span [ class "text-success" ] [ text "+10% faster at this chore" ]
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
