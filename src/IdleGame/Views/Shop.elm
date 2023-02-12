module IdleGame.Views.Shop exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import IdleGame.XpFormulas as XpFormulas
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        choresSkillLevel =
            XpFormulas.skillLevel game.choresXp

        ownedLabel =
            div [ class "flex-0 px-2 py-1 bg-primary text-primary-content rounded min-w-[3rem] text-center" ]
                [ text "Owned"
                ]

        priceLabel : Coin.Counter -> Html FrontendMsg
        priceLabel price =
            div [ class "flex items-center gap-1" ]
                [ Icon.coin
                    |> Icon.toHtml
                , div
                    [ class "font-bold"
                    , classList [ ( "text-error", Coin.getVal price > Coin.getVal game.coin ) ]
                    ]
                    [ text <| Coin.toString price
                    ]
                ]

        renderShopItem : ShopItems.ShopItems -> ShopItems.Kind -> Html FrontendMsg
        renderShopItem shopItems kind =
            let
                stats =
                    ShopItems.getStats kind

                owned =
                    ShopItems.isOwned kind shopItems
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer bubble-pop"
                , onClick <| HandleShopItemClick kind
                ]
                [ stats.icon
                    |> Icon.withSize Icon.ExtraLarge
                    |> Icon.toHtml
                , div [ class "flex-1 t-column" ]
                    [ span [ class "font-bold" ] [ text stats.title ]
                    , span [] [ text stats.description ]
                    ]
                , if owned then
                    ownedLabel

                  else
                    priceLabel stats.price
                ]

        renderLockedShopItem : Int -> Html FrontendMsg
        renderLockedShopItem levelNeeded =
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer bg-error text-error-content"
                ]
                [ div [ class "w-24 h-24 flex items-center justify-center" ]
                    [ Icon.unknownItem
                        |> Icon.toHtml
                    ]
                , div [ class "flex-1 t-column" ]
                    [ span [ class "font-bold" ] [ text "???" ]
                    , span [] [ text <| "Requires Chore level " ++ IdleGame.Views.Utils.intToString levelNeeded ]
                    ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map
                (\kind ->
                    let
                        unlockLevel =
                            (ShopItems.getStats kind).unlockLevel
                    in
                    if unlockLevel > choresSkillLevel then
                        renderLockedShopItem unlockLevel

                    else
                        renderShopItem game.shopItems kind
                )
                ShopItems.allKinds
            )
        ]
