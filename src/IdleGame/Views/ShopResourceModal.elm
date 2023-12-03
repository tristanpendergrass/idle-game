module IdleGame.Views.ShopResourceModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Svg.Attributes exposing (in_)
import Types exposing (..)


render : Game -> Int -> ( Resource, Coin ) -> Html FrontendMsg
render game quantity ( resource, price ) =
    let
        resourceStats : Resource.Stats
        resourceStats =
            Resource.getStats resource

        owned : Int
        owned =
            getByResource resource game.resources

        minMaxButtonWidth : Attribute msg
        minMaxButtonWidth =
            class "w-[60px]"

        totalPrice : Coin
        totalPrice =
            Game.priceToPurchaseResource quantity ( resource, price ) game

        buyButtonAccessibleName : String
        buyButtonAccessibleName =
            "Buy "
                ++ String.fromInt quantity
                ++ " "
                ++ resourceStats.title
                ++ " for "
                ++ String.fromInt (Coin.toInt totalPrice)
                ++ " coin"

        canPurchase : Bool
        canPurchase =
            case Game.attemptPurchaseResource quantity resource game of
                Ok _ ->
                    True

                Err _ ->
                    False
    in
    div [ class "t-column gap-6" ]
        [ h3 [ class "font-bold text-lg" ] [ text resourceStats.title ]
        , div [ class "flex w-full items-center justify-center gap-4" ]
            [ IdleGame.Views.Utils.resource { resource = resource, iconSize = Icon.ExtraLarge }
            , div [ class "t-column w-auto" ]
                [ span [ class "text-sm" ] [ text "Owned:" ]
                , IdleGame.Views.Utils.resourceQuantity { quantity = owned }
                ]
            ]
        , div [ class "divider divider-vertical" ] []
        , div [ class "flex items-center gap-2" ]
            [ span [ class "flex items-center gap-1" ]
                [ IdleGame.Views.Utils.priceLabel
                    { price = price
                    , isError = Coin.toInt price > Coin.toInt game.coin
                    }
                ]
            , span [ class "text-sm" ] [ text "each" ]
            ]
        , div [ class "flex items-center gap-2 xl:gap-4" ]
            [ button [ class "btn btn-sm btn-outline", minMaxButtonWidth, disabled (quantity == 1), onClick HandleMinButtonClick ]
                [ text "Min"
                ]
            , button [ class "btn btn-square btn-sm btn-outline", disabled (quantity == 1), onClick HandleOneLessButtonClick ]
                [ Icon.chevronLeft
                    |> Icon.toHtml
                ]
            , input
                [ class "input input-bordered w-[5.5rem] text-center"
                , value (String.fromInt quantity)
                , onInput HandleShopResourceQuantityChange
                , id "shop-resource-quantity"
                ]
                []
            , button [ class "btn btn-square btn-sm btn-outline", onClick HandleOneMoreButtonClick ]
                [ Icon.chevronRight
                    |> Icon.toHtml
                ]
            , button [ class "btn btn-sm btn-outline", minMaxButtonWidth, onClick HandleMaxButtonClick ]
                [ text "Max"
                ]
            ]
        , div
            [ class "alert alert-error flex justify-start w-auto"
            , classList [ ( "hidden", canPurchase ) ]
            ]
            [ Icon.insufficientFunds
                |> Icon.toHtml
            , span [] [ text "Insufficient funds" ]
            ]
        , div [ class "modal-action flex items-center gap-4" ]
            [ button [ class "btn btn-outline", onClick CloseModal ] [ text "Cancel" ]
            , button
                [ class "btn btn-primary flex items-center gap-2"
                , onClick HandleShopResourceBuyClick
                , attribute "aria-label" buyButtonAccessibleName
                , disabled (not canPurchase)
                ]
                [ IdleGame.Views.Utils.priceLabel { price = totalPrice, isError = False }
                ]
            ]
        ]
