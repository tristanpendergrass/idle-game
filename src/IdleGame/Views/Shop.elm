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


render : Game -> Html FrontendMsg
render game =
    let
        ownedLabel =
            div [ class "flex-0 px-2 py-1 bg-primary text-primary-content rounded min-w-[3rem] text-center" ]
                [ text "Owned"
                ]

        priceLabel price =
            div
                [ class "flex-0 px-2 py-1 font-bold"
                , classList [ ( "text-error", price > game.gold ) ]
                ]
                [ text <| String.fromInt price
                ]

        renderShopItem : ShopItems.ViewItem -> Html FrontendMsg
        renderShopItem { item, icon, title, price, description, owned } =
            let
                shakeOnClick =
                    not owned && price > game.gold
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer"
                , classList [ ( "bubble-pop", not shakeOnClick ), ( "bubble-shake", shakeOnClick ) ]
                , onClick <| HandleShopItemClick item
                ]
                [ div [ class "avatar" ]
                    [ div [ class "w-24 rounded-full" ]
                        [ icon
                            |> Icon.toFeatherIcon
                            |> FeatherIcons.withSize 96
                            |> FeatherIcons.toHtml []
                        ]
                    ]
                , div [ class "flex-1 t-column" ]
                    [ span [ class "font-bold" ] [ text title ]
                    , span [] [ text description ]
                    ]
                , if owned then
                    ownedLabel

                  else
                    priceLabel price
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (game.shopItems
                |> ShopItems.toList
                |> List.map renderShopItem
            )
        ]
