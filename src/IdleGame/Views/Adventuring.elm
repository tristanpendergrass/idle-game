module IdleGame.Views.Adventuring exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        listItem : ( Resource.Kind, Int ) -> Html FrontendMsg
        listItem ( resource, quantity ) =
            let
                stats =
                    Resource.getStats resource
            in
            li []
                [ div [ class "t-column gap-4" ]
                    [ div [ class "border-2 border-primary bg-primary/50 rounded relative" ]
                        [ stats.icon
                            |> Icon.withSize Icon.Large
                            |> Icon.toHtml

                        -- , div [ class "absolute left-1/2 transform -translate-x-1/2 bottom-0" ]
                        , div [ class "t-absolute-center-x -bottom-5" ]
                            [ span [ class "px-4 bg-base-100 text-base-content border border-primary-content rounded-xl text-sm font-semibold" ]
                                [ text <| IdleGame.Views.Utils.intToString quantity
                                ]
                            ]
                        ]
                    , span [ class "inline-block truncate" ] [ text stats.title ]
                    ]
                ]
    in
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ text "Adventuring"
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
