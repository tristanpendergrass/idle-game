module IdleGame.Views.DetailView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Event as Event exposing (Event)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Chores as ChoresView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Percent exposing (Percent)
import Types exposing (..)


render : Game -> Maybe Preview -> Bool -> Html FrontendMsg
render game maybePreview detailViewExpanded =
    div [ class "bg-base-300" ]
        [ -- Right rail version for full size screen
          div [ class "hidden xl:block h-full" ]
            [ div [ class "w-[20rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
                [ renderContentWrapper game maybePreview detailViewExpanded ]
            ]

        -- Collapsible version for mobile
        , div [ class "xl:hidden" ]
            [ renderCollapsible game maybePreview detailViewExpanded ]
        ]


type CollapsibleHeight
    = Expanded
    | Collapsed
    | StatusBar


{-| renderCollapsible is the version of DetailView shown when the screen is less than its widest.
It will display either a full screen detail view or be collapsed. In its collapsed state it may show a
status bar or not depending on the state of the game.
-}
renderCollapsible : Game -> Maybe Preview -> Bool -> Html FrontendMsg
renderCollapsible game maybePreview detailViewExpanded =
    let
        height : CollapsibleHeight
        height =
            case ( game.activity, maybePreview ) of
                ( Nothing, Nothing ) ->
                    Collapsed

                ( _, Just _ ) ->
                    Expanded

                -- Note that we're ignoring detailViewExpanded here. That's just for the real activity not the preview
                ( Just _, Nothing ) ->
                    if detailViewExpanded then
                        Expanded

                    else
                        StatusBar
    in
    div
        [ class "fixed right-0 w-screen h-screen bg-base-300 lg:w-[calc(100vw-20rem)]"
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
            [ renderContentWrapper game maybePreview detailViewExpanded
            ]
        , div
            [ class "absolute top-0 left-0 ml-3 mt-3"
            , classList [ ( "hidden", height /= Expanded ) ]
            ]
            [ collapseButton ]
        , case game.activity of
            Nothing ->
                div [] []

            Just activity ->
                div
                    [ class "absolute top-0 left-0 w-full"
                    , classList [ ( "hidden", detailViewExpanded ) ]
                    ]
                    [ renderStatusBar game activity ]
        ]


collapseButton : Html FrontendMsg
collapseButton =
    button
        [ class ""
        , onClick CollapseDetailView
        ]
        [ Icon.chevronDown
            |> Icon.toHtml
        ]


renderStatusBar : Game -> Activity -> Html FrontendMsg
renderStatusBar game activity =
    let
        stats : Chore.Stats
        stats =
            case activity of
                ActivityChore kind _ ->
                    Chore.getStats kind

        percentComplete : Percent
        percentComplete =
            case activity of
                ActivityChore _ timer ->
                    Timer.percentComplete timer
    in
    div [ class "w-full h-[4rem] bg-base-300 text-accent-content flex items-center overflow-hidden p-2 gap-3 rounded-t relative", onClick ExpandDetailView ]
        [ div [ class "w-[3rem] h-full overflow-hidden bg-red rounded" ]
            [ img [ src stats.imgSrc, class "object-cover h-full w-full object-center" ] []
            ]
        , div [ class "grow overflow-hidden h-full flex flex-col items-start justify-center" ]
            [ div [ class "font-bold text-sm leading-tight" ] [ text stats.title ]
            , div [ class "text-xs text-base-content/70 leading-tight" ] [ text "Chores" ]
            ]
        , div [ class "absolute bottom-0 left-0 w-full h-[2px]" ]
            [ div
                [ class "absolute top-0 left-0 w-[50%] h-full bg-base-content/50"
                , style "width" (String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
                ]
                []
            ]
        ]



{--| Render all the detail content of activity or preview in full height for mobile or full screen
-}


renderContentWrapper : Game -> Maybe Preview -> Bool -> Html FrontendMsg
renderContentWrapper game maybePreview detailViewExpanded =
    case ( game.activity, maybePreview ) of
        ( Nothing, Nothing ) ->
            div [] []

        ( _, Just preview ) ->
            renderContent (DetailViewPreview preview) game

        ( Just activity, Nothing ) ->
            renderContent (DetailViewActivity activity) game


type DetailViewObject
    = DetailViewActivity Activity
    | DetailViewPreview Preview


renderContent : DetailViewObject -> Game -> Html FrontendMsg
renderContent obj game =
    let
        event : Event
        event =
            Game.completeChoreEvent game kind

        mods : List Event.Mod
        mods =
            Game.getAllMods game

        kind : ChoreKind
        kind =
            case obj of
                DetailViewActivity (ActivityChore k _) ->
                    k

                DetailViewPreview (PreviewChore k) ->
                    k

        effects : List Event.Effect
        effects =
            Event.getEffects event

        orderedEffects : List Event.Effect
        orderedEffects =
            List.sortWith Event.orderEffects effects

        playButtonState : PlayButtonState
        playButtonState =
            case obj of
                DetailViewActivity _ ->
                    Pause

                DetailViewPreview _ ->
                    Play
    in
    div [ class "t-column w-full h-full p-3 relative gap-4" ]
        [ -- category of activity
          div [ class "text-sm font-semibold" ] [ text "Chores" ]

        -- preview image
        , div
            [ class "h-[12rem] w-[calc(12rem*1.618)] relative max-w-full rounded-lg overflow-hidden"
            ]
            [ ChoresView.choreImage kind
            ]

        -- title
        , h2 [ class "text-lg font-semibold" ]
            [ text (Chore.getStats kind).title
            ]

        -- Progress bar
        , case obj of
            DetailViewActivity (ActivityChore _ timer) ->
                activityProgress timer

            _ ->
                div [ class "h-1" ] []

        -- Play/pause button
        , playPauseButton playButtonState kind
        , ChoresView.choreDuration (Game.getModdedDuration game kind)
        , div [ class "t-column" ]
            (List.map (EffectView.render mods) orderedEffects)
        ]


activityProgress : Timer -> Html FrontendMsg
activityProgress timer =
    let
        percentComplete =
            Timer.percentComplete timer
    in
    div
        [ class "w-full h-1 bg-base-content bg-opacity-25 rounded-full" ]
        [ div
            [ class "bg-base-content h-1 rounded-full"
            , attribute "style" ("width:" ++ String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
            ]
            []
        ]


type PlayButtonState
    = Play
    | Pause


playPauseButton : PlayButtonState -> ChoreKind -> Html FrontendMsg
playPauseButton state kind =
    let
        icon : Icon
        icon =
            case state of
                Play ->
                    Icon.play

                Pause ->
                    Icon.pause

        handleClick : FrontendMsg
        handleClick =
            case state of
                Play ->
                    HandlePlayClick kind

                Pause ->
                    HandlePauseClick kind
    in
    button
        [ class "btn btn-circle btn-icon"
        , classList [ ( "pl-[0.3rem]", state == Play ) ]
        , onClick handleClick
        ]
        [ icon
            |> Icon.toHtml
        ]
