module IdleGame.Views.Activity exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType, effect)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Json.Decode as D
import Maybe.Extra
import Percent exposing (Percent)
import Types exposing (..)


renderActivityListItem : Game -> Game.ActivityListItem -> Html FrontendMsg
renderActivityListItem game item =
    case item of
        Game.ActivityListItem activity ->
            renderActivityCard activity game
                |> Utils.withScreenWidth

        Game.LockedActivity ( unlockSkill, unlockLevel ) ->
            renderLockedActivity unlockSkill unlockLevel


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)



-- Activity title


activityDuration : Duration -> Html msg
activityDuration duration =
    div [ class "text-2xs" ] [ text <| Utils.floatToString 1 (Duration.inSeconds duration) ++ " seconds" ]


getTimerForActivity : Activity -> Game -> Maybe Timer
getTimerForActivity activity game =
    case game.activity of
        Just ( activeType, timer ) ->
            if activity == activeType then
                Just timer

            else
                Nothing

        _ ->
            Nothing


notMasteryXpEffect : Effect -> Bool
notMasteryXpEffect taggedEffect =
    case taggedEffect.effect of
        Effect.GainMxp _ ->
            False

        _ ->
            True


renderActivityCard : ( Activity, List Effect ) -> Game -> ScreenWidth -> Html FrontendMsg
renderActivityCard ( activity, moddedEffects ) game screenWidth =
    let
        maybeTimer : Maybe Timer
        maybeTimer =
            getTimerForActivity activity game

        stats : ActivityStats
        stats =
            getActivityStats activity

        mods : List Mod
        mods =
            Game.getAllMods game

        orderedAndFilteredEffects : List Effect
        orderedAndFilteredEffects =
            moddedEffects
                |> List.sortWith Effect.order
                |> List.filter notMasteryXpEffect

        duration : Duration
        duration =
            Game.getModdedDuration game activity

        pointerDownState : PointerState
        pointerDownState =
            { click = HandleActivityClick { screenWidth = screenWidth } activity

            -- , longPress = Just ( Timer.create, 500, HandlePreviewClick activity )
            , longPress = Nothing
            }

        mxp : Xp
        mxp =
            getByActivity activity game.mxp

        masteryLevel : Int
        masteryLevel =
            Xp.level Xp.defaultSchedule mxp

        masteryPercent : Percent
        masteryPercent =
            Xp.levelPercent Xp.defaultSchedule mxp

        showMastery : Bool
        showMastery =
            Activity.hasMasteryMods (Activity.getEffectStats activity).mastery

        activityStats : ActivityStats
        activityStats =
            getActivityStats activity
    in
    div [ class "relative" ]
        [ div
            [ Utils.card.container
            , Utils.card.containerClickable
            , class "overflow-hidden"

            -- , onClick (HandleActivityClick { screenWidth = screenWidth } activity)
            , preventDefaultOn "pointerdown" (D.succeed ( HandlePointerDown pointerDownState, True ))
            , preventDefaultOn "pointerup" (D.succeed ( HandlePointerUp, True ))
            , preventDefaultOn "pointerleave" (D.succeed ( HandlePointerCancel, True ))
            ]
            [ -- preview image
              div [ Utils.card.imageContainer, class "relative rounded-t-lg overflow-hidden" ]
                [ Utils.cardImage (CardLandscape activityStats.image)
                ]
            , div [ Utils.card.body, Utils.zIndexes.cardBody ]
                -- [ div [ class "text-xs bg-neutral text-neutral-content rounded py-[0.125rem] px-1" ] [ text "Study" ]
                [ div [ Utils.card.activityTypeBadge ] [ text stats.type_ ]
                , div [ class "t-column gap-0" ]
                    [ h2 [ Utils.card.title ] [ text (getActivityStats activity).title ]
                    , div [] [ activityDuration duration ]

                    -- The effects of the activity
                    , div [ class "t-column relative" ]
                        (List.map
                            (\moddedEffect ->
                                EffectView.render
                                    { game = game
                                    , effect = moddedEffect
                                    , renderType = EffectView.DetailView
                                    }
                            )
                            orderedAndFilteredEffects
                        )
                    ]
                , div [ class "w-full", classList [ ( "hidden", not showMastery ) ] ]
                    [ Utils.progressBar
                        { progressText = Utils.intToString masteryLevel
                        , percent = masteryPercent
                        , primaryOrSecondary = Utils.Secondary
                        , size = Utils.ProgressBarSmall
                        }
                    ]
                ]

            -- Progress bar
            , case Maybe.map Timer.percentComplete maybeTimer of
                Nothing ->
                    div [] []

                Just percentComplete ->
                    div
                        -- [ class "absolute h-full bg-base-content opacity-20 top-0 left-0 rounded-l-xl"
                        [ class "absolute h-full bg-base-content opacity-20 top-0 left-0"
                        , Utils.zIndexes.activityProgressBar
                        , attribute "style" ("width:" ++ String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
                        ]
                        []
            ]
        ]


renderLockedActivity : Skill -> Int -> Html FrontendMsg
renderLockedActivity unlockSubject unlockLevel =
    div
        [ Utils.card.container
        , class "text-error"

        -- Bring this back when we figure out how to solve the problem where the shake happens on every page render?
        -- , class "bubble-shake"
        ]
        -- Activity image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24 bg-error text-error-content" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column h-full gap-4", Utils.zIndexes.cardBody ]
                -- Activity title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ]
                    [ text <|
                        (getSkillStats unlockSubject).title
                            ++ " level "
                            ++ Utils.intToString unlockLevel
                    ]
                ]
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    -- button [ class "btn btn-square btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
    -- This is used in Melvor to show e.g. item quick-equip and mastery panel, but we don't need yet as we'll show the mastery info in another place.
    div [] []
