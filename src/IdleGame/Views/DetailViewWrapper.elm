module IdleGame.Views.DetailViewWrapper exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Views.Icon as Icon
import IdleGame.Views.Utils



{--| Rewritten DetailViewWrapper. Kept as "2" for now while we wait to see if bugs with new version.
-}


type
    State a p
    -- TODO: rename from State which is confusing name
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
        [ onClick handleCollapseActivity
        ]
        [ Icon.chevronDown
            |> Icon.toHtml
        ]


topTransitionClasses : Attribute msg
topTransitionClasses =
    class "transition-[top] duration-100 ease-in motion-reduce:transition-none lg:transition-none"


emptyContent : Html msg
emptyContent =
    div [ class "t-column w-full h-full p-2" ] []


renderStatusBarWrapper : (a -> Html msg) -> a -> Html msg
renderStatusBarWrapper renderStatusBar activity =
    div [ class "w-full h-[4rem] rounded-t overflow-hidden status-bar-wrapper" ]
        [ renderStatusBar activity ]


renderSidebar : Props a p msg -> Html msg
renderSidebar props =
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
        [ class "hidden xl:block"
        , class "w-[375px] right-0 h-full border-l-8 border-base-200 overflow-hidden relative"
        ]
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
        , div
            [ class "absolute top-0 left-0 ml-3 mt-3"
            ]
            [ collapseOrCloseButton ]
        ]


renderFullScreen : Props a p msg -> Html msg
renderFullScreen props =
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

        bottomStyle : Attribute msg
        bottomStyle =
            case height of
                Expanded ->
                    attribute "style" "bottom:0;"

                Collapsed ->
                    attribute "style" "bottom:-100%;"

                StatusBar ->
                    attribute "style" "bottom:calc(-100% + 4rem);"

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
        [ class "xl:hidden"
        , class "absolute right-0 w-full h-full bg-base-300"
        , bottomStyle
        , IdleGame.Views.Utils.zIndexes.detailViewMobile
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
        , div
            [ class "absolute top-0 left-0 ml-3 mt-3"
            ]
            [ collapseOrCloseButton ]
        ]
