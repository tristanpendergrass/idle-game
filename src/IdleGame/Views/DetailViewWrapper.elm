module IdleGame.Views.DetailViewWrapper exposing (..)

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


topTransitionClasses : Attribute msg
topTransitionClasses =
    class "transition-[top] duration-100 ease-in motion-reduce:transition-none lg:transition-none"


emptyContent : Html msg
emptyContent =
    div [ class "t-column w-full h-full p-2" ] []


render : Props a p msg -> Html msg
render props =
    let
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
    div []
        [ div [ class "hidden xl:block h-full relative" ]
            [ renderBrowserView props
            , div
                [ class "absolute top-0 left-0 ml-3 mt-3"
                ]
                [ collapseOrCloseButton ]
            ]
        , div [ class "xl:hidden relative" ]
            [ renderMobileView props
            , div
                [ class "fixed top-0 left-0 ml-3 mt-3"
                , IdleGame.Views.Utils.zIndexes.detailViewMobile
                ]
                [ collapseOrCloseButton ]
            ]
        ]


renderBrowserView : Props a p msg -> Html msg
renderBrowserView props =
    -- In BrowserView we show the activity or preview on a div with variable height.
    -- We do need to make an excaption for when there's a preview and activity and in that case the preview shows on the background div instead.
    let
        foregroundHeight : ViewHeight
        foregroundHeight =
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
                    StatusBar

        backgroundContent : Html msg
        backgroundContent =
            case props.state of
                PreviewWithActivity preview _ ->
                    props.renderPreview preview

                _ ->
                    emptyContent

        foregroundContent : Html msg
        foregroundContent =
            case props.state of
                Blank ->
                    emptyContent

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
                    div [ class "t-column w-full h-full p-2" ]
                        [ div
                            [ class "absolute top-0 left-0 w-full"
                            ]
                            [ renderStatusBarWrapper props.renderStatusBar activity ]
                        ]
    in
    div [ class "w-[375px] h-screen border-l-8 border-base-200 overflow-hidden relative" ]
        [ backgroundContent
        , div
            [ class "absolute w-full h-full"
            , topTransitionClasses
            , case foregroundHeight of
                Expanded ->
                    class "top-0"

                Collapsed ->
                    class "top-full"

                StatusBar ->
                    class "top-[calc(100vh-4rem)]"
            ]
            [ foregroundContent
            ]
        ]


type ViewHeight
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
        [ class "foobaz"
        , onClick handleCollapseActivity
        ]
        [ Icon.chevronDown
            |> Icon.toHtml
        ]


renderMobileView : Props a p msg -> Html msg
renderMobileView props =
    let
        height : ViewHeight
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
    in
    div
        [ class "fixed right-0 w-screen h-screen bg-base-300"
        , topTransitionClasses
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
            [ case props.state of
                Blank ->
                    emptyContent

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
            ]
        , case props.state of
            Blank ->
                -- todo: replace with emptyContent?
                div [] []

            ActivityExpanded _ ->
                -- todo: replace with emptyContent?
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
