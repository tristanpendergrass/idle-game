module IdleGame.Views.FastForward exposing (..)

import Config
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


type Speed
    = SpeedCalculating
    | Speed Float


render : Speed -> Html FrontendMsg
render speed =
    div
        [ class "w-screen h-full flex flex-col gap-2 items-center justify-center"
        ]
        [ div [] [ text "Fast Forwarding..." ]
        , progress [ class "progress progress-primary w-56" ] []
        , div [ classList [ ( "invisible", not Config.flags.showFastForwardSpeed ) ] ]
            [ case speed of
                SpeedCalculating ->
                    div [] [ text "Calculating speed..." ]

                Speed s ->
                    div [] [ text <| "Speed (ms/ms): " ++ String.fromInt (floor s) ]
            ]
        ]
