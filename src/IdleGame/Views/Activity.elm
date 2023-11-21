module IdleGame.Views.Activity exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Spell as SpellView
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


activityImage : Activity -> Html FrontendMsg
activityImage kind =
    case (Activity.getStats kind).image of
        Activity.ActivityLandscape imgSrc ->
            renderImage imgSrc

        Activity.ActivityIcon icon ->
            renderIcon icon


renderImage : String -> Html FrontendMsg
renderImage imgSrc =
    img
        [ src imgSrc
        , class "h-full w-full object-cover"
        ]
        []


renderIcon : Icon -> Html FrontendMsg
renderIcon icon =
    div
        [ class "h-full w-full flex items-center justify-center bg-accent" ]
        [ icon
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        ]


monsterImage : Monster -> Html FrontendMsg
monsterImage kind =
    div
        [ class "h-full w-full flex items-center justify-center bg-accent" ]
        [ (Monster.getStats kind).icon
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        ]


activityDuration : Duration -> Html msg
activityDuration duration =
    div [ class "text-2xs" ] [ text <| Utils.floatToString 1 (Duration.inSeconds duration) ++ " seconds" ]


either : Maybe a -> Maybe a -> Maybe a
either a b =
    case a of
        Just _ ->
            a

        _ ->
            b


getTimerForActivity : Activity -> Game -> Maybe Timer
getTimerForActivity activity game =
    let
        maybeTimerSkilling : Maybe Timer
        maybeTimerSkilling =
            case game.activitySkilling of
                Just ( activeType, timer ) ->
                    if activity == activeType then
                        Just timer

                    else
                        Nothing

                _ ->
                    Nothing

        maybeTimerAdventuring : Maybe Timer
        maybeTimerAdventuring =
            case game.activityAdventuring of
                Just ( activeType, timer ) ->
                    if activity == activeType then
                        Just timer

                    else
                        Nothing

                _ ->
                    Nothing
    in
    either maybeTimerSkilling maybeTimerAdventuring


notMasteryXpEffect : Effect.TaggedEffect -> Bool
notMasteryXpEffect taggedEffect =
    case taggedEffect.effect of
        Effect.GainMxp _ ->
            False

        _ ->
            True


renderActivityCard : Activity -> Game -> Utils.ScreenWidth -> Html FrontendMsg
renderActivityCard activity game screenWidth =
    let
        maybeTimer : Maybe Timer
        maybeTimer =
            getTimerForActivity activity game

        stats : Activity.Stats
        stats =
            Activity.getStats activity

        effects : List Effect.TaggedEffect
        effects =
            stats.effects

        mods : List Mod
        mods =
            Game.getAllMods game

        orderedAndFilteredEffects : List Effect.TaggedEffect
        orderedAndFilteredEffects =
            List.sortWith Effect.order effects
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
            Activity.getByKind activity game.mxp

        masteryLevel : Int
        masteryLevel =
            Xp.level Xp.defaultSchedule mxp

        masteryPercent : Percent
        masteryPercent =
            Xp.levelPercent Xp.defaultSchedule mxp

        showMastery : Bool
        showMastery =
            Maybe.Extra.isJust stats.mastery
    in
    div [ class "relative" ]
        [ div
            [ Utils.card.container
            , Utils.card.containerClickable

            -- , onClick (HandleActivityClick { screenWidth = screenWidth } activity)
            , preventDefaultOn "pointerdown" (D.succeed ( HandlePointerDown pointerDownState, True ))
            , preventDefaultOn "pointerup" (D.succeed ( HandlePointerUp, True ))
            , preventDefaultOn "pointerleave" (D.succeed ( HandlePointerCancel, True ))
            ]
            [ -- preview image
              div [ Utils.card.imageContainer ]
                [ activityImage activity
                ]
            , div [ Utils.card.body, Utils.zIndexes.cardBody ]
                [ div [ class "t-column" ]
                    [ h2 [ Utils.card.title ] [ text (Activity.getStats activity).title ]
                    , div [ classList [ ( "hidden", not stats.showDuration ) ] ] [ activityDuration duration ]
                    ]
                , div [ class "t-column" ]
                    ((case stats.teachesSpell of
                        Nothing ->
                            []

                        Just spell ->
                            [ SpellView.renderSpellEffects spell ]
                     )
                        ++ List.map
                            (\taggedEffect ->
                                EffectView.render
                                    { game = game
                                    , mods = mods
                                    , effect = taggedEffect
                                    , renderType = EffectView.Card
                                    }
                            )
                            orderedAndFilteredEffects
                    )
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
                        [ class "absolute h-full bg-base-content opacity-20 top-0 left-0"
                        , Utils.zIndexes.activityProgressBar
                        , attribute "style" ("width:" ++ String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
                        ]
                        []
            ]
        ]


renderLockedActivity : Skill -> Int -> Html FrontendMsg
renderLockedActivity unlockSkill unlockLevel =
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
                        Skill.getLabel unlockSkill
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
