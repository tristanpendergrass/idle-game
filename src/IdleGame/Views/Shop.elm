module IdleGame.Views.Shop exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        ownedLabel =
            div [ class "flex-0 px-2 py-1 bg-primary text-primary-content rounded min-w-[3rem] text-center" ]
                [ text "Owned"
                ]

        priceLabel price =
            div [ class "flex items-center gap-1" ]
                [ Icon.gold
                    |> Icon.toHtml
                , div
                    [ class "font-bold"
                    , classList [ ( "text-error", price > game.gold ) ]
                    ]
                    [ text <| IdleGame.Views.Utils.intToString price
                    ]
                ]

        renderShopItem : ShopItems.ShopItems -> ShopItems.Kind -> Html FrontendMsg
        renderShopItem shopItems kind =
            let
                stats =
                    ShopItems.getStats kind

                owned =
                    ShopItems.isOwned kind shopItems

                shakeOnClick =
                    not owned && stats.price > game.gold
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer"
                , classList [ ( "bubble-pop", not shakeOnClick ), ( "bubble-shake", shakeOnClick ) ]
                , onClick <| HandleShopItemClick kind
                ]
                [ div [ class "avatar" ]
                    [ div [ class "w-24 rounded-full" ]
                        [ stats.icon
                            |> Icon.toHtml
                        ]
                    ]
                , div [ class "flex-1 t-column" ]
                    [ span [ class "font-bold" ] [ text stats.title ]
                    , span [] [ text "Foobar" ]
                    ]
                , if owned then
                    ownedLabel

                  else
                    priceLabel stats.price
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map (renderShopItem game.shopItems) ShopItems.allKinds)
        ]
