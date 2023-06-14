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


type CollapsibleHeight
    = Expanded
    | Collapsed
    | StatusBar


collapseButton : Html FrontendMsg
collapseButton =
    button
        [ class ""
        , onClick CollapseDetailView
        ]
        [ Icon.chevronDown
            |> Icon.toHtml
        ]


renderStatusBar : Activity -> Html FrontendMsg
renderStatusBar activity =
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
    div [ class "w-full h-full bg-base-200 text-accent-content flex items-center overflow-hidden p-2 gap-3 relative cursor-pointer", onClick ExpandDetailView ]
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


type DetailViewObject
    = DetailViewActivity Activity
    | DetailViewPreview Preview


fade : Bool -> Html FrontendMsg
fade shouldFade =
    div
        [ class "absolute top-0 left-0 w-full h-full bg-base-200 bg-opacity-25 transition-opacity duration-100 ease-in-out pointer-events-none"
        , classList [ ( "opacity-0", not shouldFade ) ]
        ]
        []


renderContent : DetailViewObject -> Bool -> Game -> Html FrontendMsg
renderContent obj extraBottomPadding game =
    let
        event : Event
        event =
            Game.completeChoreEvent game kind

        mods : List Event.Mod
        mods =
            Game.getAllMods game

        kind : Chore.Kind
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

        isPreview : Bool
        isPreview =
            case obj of
                DetailViewActivity _ ->
                    False

                DetailViewPreview _ ->
                    True
    in
    div
        [ class "t-column w-full h-full overflow-y-auto p-3 relative gap-4 bg-base-300"
        , classList [ ( "pb-20", extraBottomPadding ) ]
        ]
        [ -- category of activity
          div [ class "text-sm font-semibold" ] [ text "Chores" ]

        -- preview image
        , div
            [ class "min-h-[12rem] h-[12rem] w-[calc(12rem*1.618)] relative max-w-full rounded-lg overflow-hidden"
            ]
            [ ChoresView.choreImage kind
            , fade isPreview
            ]

        -- title
        , h2 [ class "text-lg font-semibold relative" ]
            [ text (Chore.getStats kind).title
            , fade isPreview
            ]

        -- Progress bar
        , case obj of
            DetailViewActivity (ActivityChore _ timer) ->
                activityProgress timer

            _ ->
                div [ class "h-1" ] []

        -- Play/pause button
        , playPauseButton playButtonState kind
        , div [ class "relative" ]
            [ ChoresView.choreDuration (Game.getModdedDuration game kind)
            , fade isPreview
            ]
        , div [ class "t-column relative" ]
            (List.map (EffectView.render mods) orderedEffects
                ++ [ fade isPreview ]
            )
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


playPauseButton : PlayButtonState -> Chore.Kind -> Html FrontendMsg
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
