module IdleGame.Views.Bag exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        listItem : ( Resource, Int ) -> Html FrontendMsg
        listItem ( resource, quantity ) =
            let
                stats =
                    getResourceStats resource
            in
            li []
                [ div [ IdleGame.Views.Utils.classes.column, class "gap-4" ]
                    [ IdleGame.Views.Utils.resourceAndQuantity { resource = resource, quantity = quantity, iconSize = Icon.Large }
                    , span [ class "inline-block truncate" ] [ text stats.title ]
                    ]
                ]
    in
    div [ IdleGame.Views.Utils.classes.column, class "p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex items-center gap-1 px-2 py-1 rounded bg-accent text-accent-content" ]
                [ span [ class "text-lg truncate" ]
                    [ Icon.coin
                        |> Icon.withSize Icon.Large
                        |> Icon.toHtml
                    ]
                , span [ class "text-log font-semibold" ]
                    [ text <| IdleGame.Views.Utils.intToString (Coin.toInt game.coin)
                    ]
                ]
            ]
        , div [ class "divider" ] []
        , ul [ class "w-full flex flex-wrap gap-4 lg:gap-8" ]
            (game.resources
                |> Resource.toList
                |> List.filter (\( _, amount ) -> amount > 0)
                |> List.map listItem
            )
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
