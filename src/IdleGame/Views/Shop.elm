module IdleGame.Views.Shop exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Resource as Resource exposing (Resource, Resources)
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Views.Icon as Icon exposing (Icon)
import Types exposing (..)


render : ShopItems -> Html FrontendMsg
render shopItems =
    let
        renderShopItem : ShopItems.ViewItem -> Html FrontendMsg
        renderShopItem { icon, title } =
            div [ class "flex gap-2 items-center bg-base-200 shadow-lg rounded-lg p-4" ]
                [ div [ class "avatar" ]
                    [ div [ class "w-24 rounded-full" ]
                        [ icon
                            |> Icon.toFeatherIcon
                            |> FeatherIcons.withSize 96
                            |> FeatherIcons.toHtml []
                        ]
                    ]
                , div [] [ text title ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (shopItems
                |> ShopItems.toList
                |> List.map renderShopItem
            )
        ]
