module IdleGame.Views.DetailViewContent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
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


renderStatusBar : ( Activity, Timer ) -> Html FrontendMsg
renderStatusBar ( activity, timer ) =
    let
        stats : Activity.Stats
        stats =
            Activity.getStats activity

        percentComplete : Percent
        percentComplete =
            Timer.percentComplete timer

        belongsLabel : String
        belongsLabel =
            Activity.belongsToLabel stats.belongsTo

        image : Html FrontendMsg
        image =
            case stats.image of
                CardLandscape imgSrc ->
                    img [ src imgSrc, class "object-cover h-full w-full object-center" ] []

                CardIcon icon ->
                    div [ class "h-full w-full flex items-center justify-center bg-accent" ] [ Icon.toHtml icon ]
    in
    div [ class "w-full h-full bg-base-200 text-accent-content flex items-center overflow-hidden p-2 gap-3 relative cursor-pointer", onClick ExpandDetailView ]
        [ div [ class "w-[3rem] h-full overflow-hidden bg-red rounded" ]
            [ image
            ]
        , div [ class "grow overflow-hidden h-full flex flex-col items-start justify-center" ]
            [ div [ class "font-bold text-sm leading-tight" ] [ text stats.title ]
            , div [ class "text-xs text-base-content/70 leading-tight" ] [ text belongsLabel ]
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
    = DetailViewActivity ( Activity, Timer )
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
        activity : Activity
        activity =
            case obj of
                DetailViewActivity ( k, _ ) ->
                    k

                DetailViewPreview (Preview k) ->
                    k

        stats : Activity.Stats
        stats =
            Activity.getStats activity

        mxp : Xp
        mxp =
            getByActivity activity game.mxp

        effects : List Effect
        effects =
            (Activity.getStats activity).effects

        mods : List Mod
        mods =
            Game.getAllMods game

        orderedEffects : List Effect
        orderedEffects =
            List.sortWith Effect.order effects

        playButtonState : PlayButtonState
        playButtonState =
            case obj of
                DetailViewActivity _ ->
                    Stop

                DetailViewPreview _ ->
                    Play

        isPreview : Bool
        isPreview =
            case obj of
                DetailViewActivity _ ->
                    False

                DetailViewPreview _ ->
                    True

        belongsToLabel : String
        belongsToLabel =
            Activity.belongsToLabel (Activity.getStats activity).belongsTo
    in
    div
        [ class "t-column w-full h-full overflow-y-auto p-3 relative gap-4 bg-base-300"
        , classList [ ( "pb-20", extraBottomPadding ) ]
        ]
        [ -- category of activity
          div [ class "text-sm font-semibold" ] [ text belongsToLabel ]

        -- preview image
        , div
            [ class "min-h-[12rem] h-[12rem] w-[calc(12rem*1.618)] relative max-w-full rounded-lg overflow-hidden"
            ]
            [ Utils.cardImage (Activity.getStats activity).image
            , fade isPreview
            ]
        , div [ Utils.card.activityTypeBadge ] [ text (Activity.typeToString stats.activityType) ]

        -- title
        , h2 [ class "text-lg font-semibold relative" ]
            [ text (Activity.getStats activity).title
            , fade isPreview
            ]

        -- Progress bar
        , case obj of
            DetailViewActivity ( _, timer ) ->
                activityProgress timer

            _ ->
                div [ class "invisible" ] [ activityProgress Timer.create ]

        -- Play/stop button
        , playStopButton playButtonState activity

        -- Duration
        , div [ class "relative" ]
            [ ActivityView.activityDuration (Game.getModdedDuration game activity)
            , fade isPreview
            ]

        -- The effects of the activity
        , div [ class "t-column relative" ]
            (List.map
                (\taggedEffect ->
                    EffectView.render
                        { game = game
                        , mods = mods
                        , effect = taggedEffect
                        , renderType = EffectView.DetailView
                        }
                )
                orderedEffects
                ++ [ fade isPreview ]
            )
        , div [ class "divider" ] []

        -- The current mastery level
        , if stats.mastery /= Nothing then
            mxpSection mxp

          else
            -- Don't show the current mastery level if there are no mastery rewards for this activity
            div [] []

        -- The mastery rewards for this activity
        , case stats.mastery of
            Just mastery ->
                masterySection mxp mastery

            Nothing ->
                div [] []
        ]


intervalModLabelToString : IntervalModLabel -> String
intervalModLabelToString modLabel =
    case modLabel of
        IntervalModLabel buff ->
            "+" ++ Utils.floatToString 2 (Percent.toPercentage buff) ++ "% faster"


masterySection : Xp -> Activity.Mastery -> Html msg
masterySection mxp mastery =
    let
        renderMasteryReward : ( Int, Activity.MasteryReward ) -> Html msg
        renderMasteryReward ( level, reward ) =
            let
                rewardText : String
                rewardText =
                    case reward of
                        Activity.GameMod mod ->
                            Utils.modToString mod

                        Activity.IntervalMod mod ->
                            intervalModLabelToString mod.label

                isAchieved : Bool
                isAchieved =
                    Xp.level Xp.defaultSchedule mxp >= level

                textColor : String
                textColor =
                    if isAchieved then
                        "text-success"

                    else
                        ""

                checkIcon : Icon
                checkIcon =
                    if isAchieved then
                        Icon.checkboxMarked

                    else
                        Icon.checkboxEmpty
            in
            div [ class "flex justify-between w-full" ]
                [ span [ class "flex items-center gap-4" ]
                    [ checkIcon
                        |> Icon.withSize Icon.Medium
                        |> Icon.toHtml
                    , span [] [ text (Utils.intToString level) ]
                    ]
                , span [ class textColor ] [ text rewardText ]
                ]
    in
    div [ class "t-column w-full" ]
        (mastery
            |> List.map renderMasteryReward
        )


mxpSection : Xp -> Html msg
mxpSection mxp =
    let
        skillLevel : Int
        skillLevel =
            Xp.level Xp.defaultSchedule mxp

        skillPercent : Percent
        skillPercent =
            Xp.levelPercent Xp.defaultSchedule mxp
    in
    div [ class "w-full" ]
        [ div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-between" ]
                [ div [ class "text-2xs font-bold" ] [ text "Mastery level" ]
                ]
            , Utils.progressBar
                { progressText = Utils.intToString skillLevel
                , percent = skillPercent
                , primaryOrSecondary = Utils.Secondary
                , size = Utils.ProgressBarLarge
                }
            ]
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
    | Stop


playStopButton : PlayButtonState -> Activity -> Html FrontendMsg
playStopButton state kind =
    let
        icon : Icon
        icon =
            case state of
                Play ->
                    Icon.play

                Stop ->
                    Icon.stop

        handleClick : FrontendMsg
        handleClick =
            case state of
                Play ->
                    HandlePlayClick kind

                Stop ->
                    HandleStopClick kind
    in
    button
        [ class "btn btn-circle btn-icon"
        , classList [ ( "pl-[0.3rem]", state == Play ) ]
        , onClick handleClick
        ]
        [ icon
            |> Icon.toHtml
        ]
