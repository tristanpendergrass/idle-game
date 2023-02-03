module IdleGame.Views.UnderConstruction exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Resource as Resource exposing (Resource, Resources)
import IdleGame.Views.Icon as Icon exposing (Icon)
import Types exposing (..)


render : Html FrontendMsg
render =
    let
        listItem : String -> String -> Html FrontendMsg
        listItem label quantity =
            li [ class "flex gap-1" ]
                [ span [ class "w-full text-lg truncate" ] [ text label ]
                , span [ class "text-lg font-semibold" ] [ text quantity ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex gap-2" ]
                [ Icon.underConstruction
                    |> Icon.toHtml
                , span [] [ text "Under construction" ]
                ]
            ]
        ]
