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
    , onCollapse : msg
    }


render : Props a p msg -> Html msg
render props =
    div [ class "bg-base-300" ]
        [ -- Right rail version for full size screen
          div [ class "hidden xl:block h-full" ]
            [ renderBrowserView props ]

        -- Collapsible version for mobile
        , div [ class "xl:hidden" ]
            [ renderMobileView props ]
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


collapseButton : Props a p msg -> Html msg
collapseButton props =
    button
        [ class ""
        , onClick props.onCollapse
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
            , classList [ ( "hidden", height /= Expanded ) ]
            ]
            [ collapseButton props ]

        -- , case game.activity of
        --     Nothing ->
        --         div [] []
        --     Just activity ->
        --         div
        --             [ class "absolute top-0 left-0 w-full"
        --             , classList [ ( "hidden", height /= StatusBar ) ]
        --             ]
        --             [ renderStatusBar activity ]
        ]



-- type State a p
--     = Blank --
--     | ActivityExpanded a
--     | ActivityCollapsed a
--     | Preview p
--     | PreviewWithActivity p a


renderContent : Props a p msg -> Html msg
renderContent props =
    -- case ( game.activity, maybePreview ) of
    --     ( Nothing, Nothing ) ->
    --         div [ class "t-column w-full h-full p-2" ] []
    --     ( _, Just preview ) ->
    --         renderContent (DetailViewPreview preview) game
    --     ( Just activity, Nothing ) ->
    --         renderContent (DetailViewActivity activity) game
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
                    [ props.renderStatusBar activity ]
                ]

        Preview preview ->
            props.renderPreview preview

        PreviewWithActivity preview activity ->
            div [ class "w-full h-full" ]
                [ props.renderPreview preview
                , div
                    [ class "absolute top-0 bottom-0 w-full"
                    ]
                    [ props.renderStatusBar activity ]
                ]
