module IdleGame.Views.UnderConstruction exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Mod exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
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
    div [ IdleGame.Views.Utils.classes.column, class "p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex gap-2" ]
                [ Icon.underConstruction
                    |> Icon.toHtml
                , span [] [ text "Under construction" ]
                ]
            ]
        ]
