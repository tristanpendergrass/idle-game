module IdleGame.Views.Shop exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Game exposing (Game, attemptPurchaseResource)
import IdleGame.Mod exposing (..)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        choresSkillLevel : Int
        choresSkillLevel =
            game.xp.chores
                |> Xp.level Xp.defaultSchedule

        ownedLabel =
            div [ class "flex-0 px-2 py-1 bg-primary text-primary-content rounded min-w-[3rem] text-center" ]
                [ text "Owned"
                ]

        priceLabel : Coin -> Html FrontendMsg
        priceLabel price =
            div [ class "flex items-center gap-1" ]
                [ Icon.coin
                    |> Icon.toHtml
                , div
                    [ class "font-bold"
                    , classList [ ( "text-error", Coin.toInt price > Coin.toInt game.coin ) ]
                    ]
                    [ price
                        |> Coin.toInt
                        |> IdleGame.Views.Utils.intToString
                        |> text
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
                    , span [ class "text-sm" ] [ text stats.description ]
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
                    , span [ class "text-sm" ] [ text <| "Requires Chore level " ++ IdleGame.Views.Utils.intToString levelNeeded ]
                    ]
                ]

        renderResource : ( Resource.Kind, Coin ) -> Html FrontendMsg
        renderResource ( resource, price ) =
            let
                resourceStats : Resource.Stats
                resourceStats =
                    Resource.getStats resource
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer bubble-pop"
                , onClick <| HandleShopResourceClick resource
                ]
                [ resourceStats.icon
                    |> Icon.withSize Icon.ExtraLarge
                    |> Icon.toHtml
                , div [ class "flex-1 t-column" ]
                    [ span [ class "font-bold" ] [ text resourceStats.title ]
                    ]
                , priceLabel price
                ]

        purchasableResources : List ( Resource.Kind, Coin )
        purchasableResources =
            Resource.allResources
                |> List.filterMap
                    (\kind ->
                        case (Resource.getStats kind).purchasing of
                            Resource.Purchasable price ->
                                Just ( kind, price )

                            Resource.NotPurchasable ->
                                Nothing
                    )
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex items-center gap-1 px-2 py-1" ]
                [ span [ class "text-lg truncate" ]
                    [ Icon.coin
                        |> Icon.withSize Icon.Large
                        |> Icon.toHtml
                    ]
                , span [ class "text-log font-semibold" ]
                    [ game.coin
                        |> Coin.toInt
                        |> IdleGame.Views.Utils.intToString
                        |> text
                    ]
                ]
            ]
        , div [ class "divider" ] []
        , div [ class "text-xl font-bold" ] [ text "Reagents" ]
        , div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map renderResource purchasableResources)
        , div [ class "divider", classList [ ( "hidden", List.isEmpty purchasableResources ) ] ] []
        , div [ class "text-xl font-bold" ] [ text "Upgrades" ]
        , div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map
                (\kind ->
                    renderShopItem game.shopItems kind
                )
                ShopItems.allKinds
            )
        ]
