module IdleGame.Views.DetailViewContent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
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
        stats : ActivityStats
        stats =
            getActivityStats activity

        percentComplete : Percent
        percentComplete =
            Timer.percentComplete timer

        belongsLabel : String
        belongsLabel =
            (getSkillStats stats.skill).title

        image : Html FrontendMsg
        image =
            img [ src stats.image, class "object-cover h-full w-full object-center" ] []
    in
    div [ class "w-full h-full bg-base-200 text-accent-content flex items-center overflow-hidden p-2 gap-3 relative cursor-pointer", onClick ExpandDetailView ]
        [ div [ class "w-[3rem] h-full overflow-hidden bg-red rounded" ]
            [ image
            ]
        , div [ class "grow overflow-hidden h-full flex flex-col items-start justify-center" ]
            [ div [ class "font-bold text-sm text-base-content leading-tight" ] [ text stats.title ]
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
    = DetailViewActivity ( ( Activity, List Effect ), Timer )
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
        ( activity, effects ) =
            case obj of
                DetailViewActivity ( ( k, e ), _ ) ->
                    ( k, e )

                DetailViewPreview (Preview ( k, e )) ->
                    ( k, e )

        stats : ActivityStats
        stats =
            getActivityStats activity

        effectStats : Activity.EffectStats
        effectStats =
            Activity.getEffectStats activity

        mxp : Xp
        mxp =
            getByActivity activity game.mxp

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
            (getSkillStats stats.skill).title
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
            [ Utils.cardImage (CardLandscape (getActivityStats activity).image)
            , fade isPreview
            ]
        , div [ Utils.classes.card.activityTypeBadge ] [ text stats.type_ ]

        -- title
        , h2 [ class "text-lg font-semibold relative" ]
            [ text (getActivityStats activity).title
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
                        , effect = taggedEffect
                        , renderType = EffectView.DetailView
                        }
                )
                orderedEffects
                ++ [ fade isPreview ]
            )
        , div [ class "divider" ] []

        -- The current mastery level
        , if Activity.hasMasteryMods effectStats.mastery then
            mxpSection mxp

          else
            -- Don't show the current mastery level if there are no mastery rewards for this activity
            div [] []

        -- The mastery rewards for this activity
        , masterySection mxp effectStats.mastery
        ]


intervalModLabelToString : IntervalModLabel -> String
intervalModLabelToString modLabel =
    case modLabel of
        IntervalModLabel buff ->
            "+" ++ Utils.floatToString 2 (Percent.toPercentage buff) ++ "% faster"


masterySection : Xp -> Activity.Mastery -> Html FrontendMsg
masterySection mxp mastery =
    let
        renderPerLevelMastery : { interval : Int, mod : Activity.MasteryMod } -> Html FrontendMsg
        renderPerLevelMastery { interval, mod } =
            let
                rewardText : String
                rewardText =
                    case mod of
                        Activity.GameMod gameMod ->
                            gameMod.label

                        Activity.IntervalMod intervalMod ->
                            intervalModLabelToString intervalMod.label

                rowText : String
                rowText =
                    if interval == 1 then
                        "Every level gives " ++ rewardText

                    else
                        "Every " ++ Utils.intToString interval ++ " levels gives " ++ rewardText

                mxpLevel : Int
                mxpLevel =
                    Xp.level Xp.defaultSchedule mxp

                atLeastOneBonus : Bool
                atLeastOneBonus =
                    Activity.perLevelModCount { modInterval = interval, mxpLevel = mxpLevel } >= 1

                atMaxMasteryLevel : Bool
                atMaxMasteryLevel =
                    mxpLevel >= 99
            in
            tr []
                [ th []
                    [ div [ class "h-full flex items-center" ]
                        [ input
                            [ type_ "checkbox"
                            , class "checkbox checkbox-secondary checkbox-xs rounded-md cursor-default inline-block"
                            , onClickPreventDefault NoOp
                            , checked atMaxMasteryLevel
                            , Utils.indeterminate (atLeastOneBonus && not atMaxMasteryLevel)
                            ]
                            []
                        ]
                    ]
                , td [] [ text (Utils.intToString interval) ]
                , td [ class "w-full" ] [ text rowText ]
                ]

        renderAtLevelMastery : { level : Int, mod : Activity.MasteryMod } -> Html FrontendMsg
        renderAtLevelMastery { level, mod } =
            let
                rewardText : String
                rewardText =
                    case mod of
                        Activity.GameMod gameMod ->
                            gameMod.label

                        Activity.IntervalMod intervalMod ->
                            intervalModLabelToString intervalMod.label

                isAchieved : Bool
                isAchieved =
                    Xp.level Xp.defaultSchedule mxp >= level
            in
            tr []
                [ th []
                    [ div [ class "h-full flex items-center" ]
                        [ input [ type_ "checkbox", checked isAchieved, class "checkbox checkbox-secondary checkbox-xs rounded-md cursor-default" ] []
                        ]
                    ]
                , td [] [ text (Utils.intToString level) ]
                , td [ class "w-full" ] [ text rewardText ]
                ]
    in
    table [ class "table table-xs" ]
        [ thead []
            [ tr []
                [ th [] []
                , th [] [ text "Level" ]
                , th [] [ text "Reward" ]
                ]
            ]
        , tbody []
            (List.concat
                [ List.map renderPerLevelMastery mastery.perLevel
                , List.map renderAtLevelMastery mastery.atLevel
                ]
            )
        ]


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
                , size = Utils.ProgressBarSmall
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
