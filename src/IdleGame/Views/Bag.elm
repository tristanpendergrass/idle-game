module IdleGame.Views.Bag exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        listItem : Int -> Resource.Kind -> Html FrontendMsg
        listItem quantity resource =
            let
                stats =
                    Resource.getStats resource
            in
            li [ class "flex gap-1" ]
                [ div [ class "border-2 border-primary bg-primary/50 rounded" ]
                    [ stats.icon
                        |> Icon.withSize Icon.Large
                        |> Icon.toHtml
                    ]
                , span [ class "w-full text-lg truncate" ] [ text stats.title ]
                , span [ class "text-lg font-semibold" ] [ text <| String.fromInt quantity ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-start items-center" ]
            [ div [ class "flex items-center gap-1 px-2 py-1 rounded" ]
                [ span [ class "text-lg truncate" ]
                    [ Icon.gold
                        |> Icon.withSize Icon.Large
                        |> Icon.toHtml
                    ]
                , span [ class "text-log font-semibold" ] [ text <| String.fromInt game.gold ]
                ]
            ]
        , ul [ class "w-full grid gap-x-8 gap-y-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3" ]
            (Resource.mapResources listItem game.resources)
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
