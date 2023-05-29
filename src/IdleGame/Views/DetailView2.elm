module IdleGame.Views.DetailView2 exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils


type State a p
    = Blank --
    | ActivityExpanded a
    | ActivityCollapsed a
    | Preview p
    | PreviewWithActivity p a


type alias Props a p msg =
    { state : State a p
    , renderActivity : a -> Html msg
    , renderPreview : p -> Html msg
    , renderStatusBar : a -> Html msg
    , onClosePreview : msg
    , onCollapseActivity : msg
    , onExpandActivity : msg
    }


render : Props a p msg -> Html msg
render props =
    div []
        [ div [ class "hidden xl:block h-full" ] [ renderBrowserView props ]
        , div [ class "xl:hidden" ] [ renderMobileView props ]
        ]


renderBrowserView : Props a p msg -> Html msg
renderBrowserView props =
    div [ class "w-[375px] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
        [ renderContent props
        ]


type MobileViewHeight
    = Expanded
    | Collapsed
    | StatusBar


closePreviewButton : msg -> Html msg
closePreviewButton handleClosePreview =
    button
        [ class ""
        , onClick handleClosePreview
        ]
        [ Icon.close
            |> Icon.toHtml
        ]


collapseActivityButton : msg -> Html msg
collapseActivityButton handleCollapseActivity =
    button
        [ class ""
        , onClick handleCollapseActivity
        ]
        [ Icon.chevronDown
            |> Icon.toHtml
        ]


renderMobileView : Props a p msg -> Html msg
renderMobileView props =
    let
        height : MobileViewHeight
        height =
            case props.state of
                Blank ->
                    Collapsed

                ActivityExpanded _ ->
                    Expanded

                ActivityCollapsed _ ->
                    StatusBar

                Preview _ ->
                    Expanded

                PreviewWithActivity _ _ ->
                    Expanded

        collapseOrCloseButton : Html msg
        collapseOrCloseButton =
            case props.state of
                Blank ->
                    div [] []

                ActivityExpanded _ ->
                    collapseActivityButton props.onCollapseActivity

                ActivityCollapsed _ ->
                    div [] []

                Preview _ ->
                    closePreviewButton props.onClosePreview

                PreviewWithActivity _ _ ->
                    closePreviewButton props.onClosePreview
    in
    div
        [ class "fixed right-0 w-screen h-screen bg-base-300"
        , class "transition-[top] duration-100 ease-in motion-reduce:transition-none"
        , IdleGame.Views.Utils.zIndexes.detailViewMobile
        , case height of
            Expanded ->
                class "top-0"

            Collapsed ->
                class "top-full"

            StatusBar ->
                class "top-[calc(100vh-4rem)]"
        ]
        [ div
            [ class "w-full h-full"
            , classList [ ( "hidden", height /= Expanded ) ]
            ]
            [ renderContent props
            ]
        , div
            [ class "absolute top-0 left-0 ml-3 mt-3"
            ]
            [ collapseOrCloseButton
            ]
        , case props.state of
            Blank ->
                div [] []

            ActivityExpanded _ ->
                div [] []

            ActivityCollapsed activity ->
                div
                    [ class "absolute top-0 left-0 w-full"
                    ]
                    [ renderStatusBarWrapper props.renderStatusBar activity
                    ]

            Preview _ ->
                div [] []

            PreviewWithActivity _ activity ->
                div
                    [ class "absolute bottom-0 left-0 w-full"
                    ]
                    [ renderStatusBarWrapper props.renderStatusBar activity
                    ]
        ]


renderStatusBarWrapper : (a -> Html msg) -> a -> Html msg
renderStatusBarWrapper renderStatusBar activity =
    div [ class "w-full h-[4rem] rounded-t overflow-hidden status-bar-wrapper" ]
        [ renderStatusBar activity ]


renderContent : Props a p msg -> Html msg
renderContent props =
    case props.state of
        Blank ->
            div [ class "t-column w-full h-full p-2" ] []

        ActivityExpanded activity ->
            props.renderActivity activity

        ActivityCollapsed activity ->
            div [ class "t-column w-full h-full p-2" ]
                [ div
                    [ class "absolute top-0 left-0 w-full"
                    ]
                    [ renderStatusBarWrapper props.renderStatusBar activity ]
                ]

        Preview preview ->
            props.renderPreview preview

        PreviewWithActivity preview activity ->
            div [ class "w-full h-full relative" ]
                [ props.renderPreview preview
                , div
                    [ class "absolute bottom-0 left-0 w-full"
                    ]
                    [ renderStatusBarWrapper props.renderStatusBar activity ]
                ]
