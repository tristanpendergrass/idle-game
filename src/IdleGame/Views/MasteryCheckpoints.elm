module IdleGame.Views.MasteryCheckpoints exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.XpFormulas
import Json.Decode
import Round
import Types exposing (..)


render : { mxp : Float, checkpoints : IdleGame.Game.MasteryCheckpoints } -> Html FrontendMsg
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
            [ div [ class "w-full flex" ]
                [ div [] [ text "10%" ]
                , div [] [ text checkpoints.ten.label ]
                ]
            , div [ class "w-full flex" ]
                [ div [] [ text "25%" ]
                , div [] [ text checkpoints.twentyFive.label ]
                ]
            , div [ class "w-full flex" ]
                [ div [] [ text "50%" ]
                , div [] [ text checkpoints.fifty.label ]
                ]
            , div [ class "w-full flex" ]
                [ div [] [ text "95%" ]
                , div [] [ text checkpoints.ninetyFive.label ]
                ]
            ]
        ]
