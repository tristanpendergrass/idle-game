module IdleGame.Views.Bag exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        manureQuantity =
            String.fromInt game.manure

        stickQuantity =
            String.fromInt game.sticks

        listItem : String -> String -> Html FrontendMsg
        listItem label quantity =
            li [ class "flex gap-1" ]
                [ span [ class "w-full text-lg truncate" ] [ text label ]
                , span [ class "text-lg font-semibold" ] [ text quantity ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex items-center gap-1 px-2 py-1 bg-accent text-accent-content rounded" ]
                [ span [ class "text-lg truncate" ] [ text "Gold" ]
                , span [ class "text-log font-semibold" ] [ text <| String.fromInt game.gold ]
                ]
            ]
        , ul [ class "w-full grid gap-x-8 gap-y-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3" ]
            [ listItem "Manure" manureQuantity
            , listItem "Sticks" stickQuantity
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
