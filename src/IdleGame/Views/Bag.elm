module IdleGame.Views.Bag exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import Types exposing (..)


render : Game -> Html FrontendMsg
render _ =
    let
        listItem =
            li [ class "flex gap-1" ]
                [ span [ class "w-full text-lg truncate" ] [ text "Manure" ]
                , span [ class "text-lg font-semibold" ] [ text "10" ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ ul [ class "w-full grid gap-x-8 gap-y-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3" ]
            [ listItem
            , listItem
            , listItem
            , listItem
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
