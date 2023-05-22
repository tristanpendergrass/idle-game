module IdleGame.Views.DetailView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (..)
import IdleGame.Views.Chores
import IdleGame.Views.Icon
import Types exposing (..)


statusBarTopExpanded : String
statusBarTopExpanded =
    "top-0"


statusBarTopCollapsed : String
statusBarTopCollapsed =
    "top-[calc(100vh-4rem)]"


render : Game -> Bool -> Html FrontendMsg
render game detailViewExpanded =
    div [ class "bg-base-100" ]
        [ div [ class "hidden lg:block" ]
            [ renderRightRail game
                [ div [] [ text "Why hello there" ]
                ]
            ]
        , div [ class "lg:hidden" ]
            [ renderCollapsible
                game
                detailViewExpanded
                [ div [] [ text "Why hello mobile" ]
                ]
            ]
        ]


renderRightRail : Game -> List (Html FrontendMsg) -> Html FrontendMsg
renderRightRail game children =
    div [ class "w-[20rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
        [ IdleGame.Views.Chores.detailView game ]


renderCollapsible : Game -> Bool -> List (Html FrontendMsg) -> Html FrontendMsg
renderCollapsible game detailViewExpanded children =
    div
        [ class "fixed left-0 w-screen h-screen bg-base-100"
        , classList [ ( statusBarTopExpanded, detailViewExpanded ) ]
        , classList [ ( statusBarTopCollapsed, not detailViewExpanded ) ]
        ]
        [ IdleGame.Views.Chores.detailView game
        , div [ class "absolute top-0 left-0 ml-2 mt-2" ]
            [ collapseButton ]
        , div
            [ class "absolute top-0 left-0 w-full"
            , classList [ ( "hidden", detailViewExpanded ) ]
            ]
            [ renderStatusBar game ]
        ]


collapseButton : Html FrontendMsg
collapseButton =
    button
        [ class "btn btn-icon btn-ghost btn-circle"
        , onClick CollapseDetailView
        ]
        [ IdleGame.Views.Icon.chevronDown
            |> IdleGame.Views.Icon.toHtml
        ]


renderStatusBar : Game -> Html FrontendMsg
renderStatusBar game =
    div [ class "w-full h-[4rem] bg-accent text-accent-content" ]
        [ text "Status bar" ]
