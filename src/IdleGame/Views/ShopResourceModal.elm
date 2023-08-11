module IdleGame.Views.ShopResourceModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


render : Game -> Int -> Resource.Kind -> Html FrontendMsg
render game quantity resource =
    let
        resourceStats : Resource.Stats
        resourceStats =
            Resource.getStats resource

        owned : Int
        owned =
            Resource.getByKind resource game.resources
    in
    div [ class "t-column gap-6" ]
        [ h3 [ class "font-bold text-lg" ] [ text resourceStats.title ]
        , span [ class "flex items-center gap-1 text-sm" ]
            [ span [] [ text "Owned:" ]
            , span [ class "font-bold" ] [ text <| IdleGame.Views.Utils.intToString owned ]
            ]
        , IdleGame.Views.Utils.resourceAndQuantity { resource = resource, quantity = quantity, iconSize = Icon.ExtraLarge }
        , div [ class "flex items-center gap-4" ]
            -- [ button [ class "btn btn-square btn-sm btn-outline" ]
            --     [ Icon.chevronLeft
            --         |> Icon.toHtml
            --     ]
            [ input [ class "input input-bordered w-16 text-center", value (String.fromInt quantity), onInput HandleShopResourceQuantityChange ] []

            -- , button [ class "btn btn-square btn-sm btn-outline" ]
            --     [ Icon.chevronRight
            --         |> Icon.toHtml
            --     ]
            ]
        , div [ class "modal-action flex items-center gap-4" ]
            [ button [ class "btn btn-outline", onClick CloseModal ] [ text "Cancel" ]
            , button [ class "btn btn-primary", onClick HandleShopResourcePurchase ] [ text "Buy" ]
            ]
        ]
