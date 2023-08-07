module IdleGame.Views.ShopResourceModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


render : Int -> Resource.Kind -> Html FrontendMsg
render quantity resource =
    let
        resourceStats : Resource.Stats
        resourceStats =
            Resource.getStats resource
    in
    div [ class "t-column gap-6" ]
        [ h3 [ class "font-bold text-lg" ] [ text resourceStats.title ]
        , IdleGame.Views.Utils.resourceAndQuantity { resource = resource, quantity = quantity, iconSize = Icon.ExtraLarge }
        , div [ class "flex items-center gap-4" ]
            [ button [ class "btn btn-icon" ]
                [ Icon.chevronLeft
                    |> Icon.toHtml
                ]
            , input [ class "input input-bordered w-16 text-center", value "1" ] []
            , button [ class "btn btn-icon" ]
                [ Icon.chevronRight
                    |> Icon.toHtml
                ]
            ]
        , div [ class "modal-action flex items-center gap-4" ]
            [ button [ class "btn", onClick CloseModal ] [ text "Cancel" ]
            , button [ class "btn btn-primary" ] [ text "Buy" ]
            ]
        ]
