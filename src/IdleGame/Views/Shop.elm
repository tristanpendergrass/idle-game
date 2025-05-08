module IdleGame.Views.Shop exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        ownedLabel =
            div [ class "flex-0 px-2 py-1 bg-primary text-primary-content rounded min-w-[3rem] text-center" ]
                [ text "Owned"
                ]

        renderShopUpgrade : ShopUpgradeRecord Bool -> ShopUpgrade -> Html FrontendMsg
        renderShopUpgrade ownedItems kind =
            let
                stats =
                    ShopUpgrade.getStats kind

                owned =
                    getByShopUpgrade kind ownedItems
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer bubble-pop"
                , onClick <| HandleShopUpgradeClick kind
                ]
                [ stats.icon
                    |> Icon.withSize Icon.ExtraLarge
                    |> Icon.toHtml
                , div [ class "flex-1", IdleGame.Views.Utils.classes.column ]
                    [ span [ class "font-bold" ] [ text stats.title ]
                    , span [ class "text-sm" ] [ text stats.description ]
                    ]
                , if owned then
                    ownedLabel

                  else
                    IdleGame.Views.Utils.priceLabel
                        { price = stats.price
                        , isError = Coin.toInt stats.price > Coin.toInt game.coin
                        }
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
                , div [ class "flex-1", IdleGame.Views.Utils.classes.column ]
                    [ span [ class "font-bold" ] [ text "???" ]
                    , span [ class "text-sm" ] [ text <| "Requires Chore level " ++ IdleGame.Views.Utils.intToString levelNeeded ]
                    ]
                ]

        renderResource : ( Resource, Coin ) -> Html FrontendMsg
        renderResource ( resource, price ) =
            let
                resourceStats : ResourceStats
                resourceStats =
                    getResourceStats resource
            in
            div
                [ class "flex gap-4 items-center bg-base-200 shadow-lg rounded-lg p-4 cursor-pointer bubble-pop"
                , onClick <| HandleShopResourceClick resource
                ]
                [ resourceStats.icon
                    |> Icon.withSize Icon.ExtraLarge
                    |> Icon.toHtml
                , div [ class "flex-1", IdleGame.Views.Utils.classes.column ]
                    [ span [ class "font-bold" ] [ text resourceStats.title ]
                    ]
                , IdleGame.Views.Utils.priceLabel
                    { price = price
                    , isError = Coin.toInt price > Coin.toInt game.coin
                    }
                ]

        purchasableResources : List ( Resource, Coin )
        purchasableResources =
            allResources
                |> List.filterMap
                    (\kind ->
                        Maybe.map (\price -> ( kind, price )) (getResourceStats kind).buyPrice
                    )
    in
    div [ IdleGame.Views.Utils.classes.column, class "p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
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
        , div [ class "text-xl font-bold" ] [ text "Buy Items" ]
        , div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map renderResource purchasableResources)
        , div [ class "divider", classList [ ( "hidden", List.isEmpty purchasableResources ) ] ] []
        , div [ class "text-xl font-bold" ] [ text "Upgrades" ]
        , div [ class "w-full grid grid-cols-1 md:grid-cols-2 2xl:grid-cols-3 gap-4" ]
            (List.map
                (\kind ->
                    renderShopUpgrade game.ownedShopUpgrades kind
                )
                ShopUpgrade.allShopUpgrades
            )
        ]
