module IdleGame.Views.Activity exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Effect, Event)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Kinds.Monsters exposing (Monster)
import IdleGame.Monster as Monster
import IdleGame.Resource as Resource
import IdleGame.Skill exposing (Kind(..))
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Json.Decode as D
import Percent exposing (Percent)
import Types exposing (..)


renderActivityListItem : Game -> Game.ActivityListItem -> Html FrontendMsg
renderActivityListItem game item =
    case item of
        Game.ActivityListItem activity ->
            renderActivity activity game
                |> Utils.withScreenWidth

        Game.LockedActivity level ->
            renderLockedActivity level

        Game.MonsterListItem monster ->
            renderMonster monster game
                |> Utils.withScreenWidth


activityHeight : String
activityHeight =
    "h-[425px] xl:h-[405px]"


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)



-- Activity title


activityImage : Activity -> Html FrontendMsg
activityImage kind =
    case (Activity.getStats kind).image of
        Activity.ActivityLandscape imgSrc ->
            img
                [ src imgSrc
                , class "h-full w-full object-cover"
                ]
                []

        Activity.ActivityIcon icon ->
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
        [ (Monster.getStats kind).image
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        ]


activityTitle : Activity -> Html FrontendMsg
activityTitle kind =
    h2 [ class "text-sm  md:text-lg text-center flex items-center gap-2" ]
        [ span [] [ text (Activity.getStats kind).title ]
        ]


monsterTitle : Monster -> Html FrontendMsg
monsterTitle kind =
    h2 [ class "text-sm  md:text-lg text-center flex items-center gap-2" ]
        [ span [] [ text (Monster.getStats kind).title ]
        ]


activityDuration : Duration -> Html msg
activityDuration duration =
    div [ class "text-2xs" ] [ text <| Utils.floatToString 1 (Duration.inSeconds duration) ++ " seconds" ]


activityCoin : Counter -> Html msg
activityCoin coin =
    div [ class "flex items-center gap-1" ]
        [ div [ class "flex items-center gap-1" ]
            [ span [] [ text (Counter.toString coin) ]
            , Icon.coin
                |> Icon.toHtml
            ]
        ]


renderMonster : Monster -> Game -> Utils.ScreenWidth -> Html FrontendMsg
renderMonster monster game screenWidth =
    -- TODO: Move to its own file
    div [ class "relative" ]
        [ div
            [ class "card card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
            , onClick (HandleMonsterClick { screenWidth = screenWidth } monster)
            ]
            [ -- preview image
              div [ class "h-24 relative" ]
                [ monsterImage monster
                ]
            , div [ class "relative card-body" ]
                [ div [ class "t-column gap-2 h-full", Utils.zIndexes.cardBody ]
                    -- Activity title
                    [ monsterTitle monster
                    ]
                ]
            ]
        ]


renderActivity : Activity -> Game -> Utils.ScreenWidth -> Html FrontendMsg
renderActivity activity game screenWidth =
    let
        maybeTimer : Maybe Timer
        maybeTimer =
            game.activity
                |> Maybe.andThen
                    (\( activeType, timer ) ->
                        if activity == activeType then
                            Just timer

                        else
                            Nothing
                    )

        stats : Activity.Stats
        stats =
            Activity.getStats activity

        event : Event
        event =
            stats.event

        mods : List Event.Mod
        mods =
            Game.getAllMods game

        effects : List Event.Effect
        effects =
            Event.getEffects event

        orderedEffects : List Event.Effect
        orderedEffects =
            List.sortWith Event.orderEffects effects

        duration : Duration
        duration =
            Game.getModdedDuration game activity

        pointerDownState : PointerState
        pointerDownState =
            { click = HandleActivityClick { screenWidth = screenWidth } activity
            , longPress = Just ( Timer.create, 500, HandlePreviewClick activity )
            }
    in
    div [ class "relative" ]
        [ div
            [ class "card card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"

            -- , onClick (HandleActivityClick { screenWidth = screenWidth } activity)
            , preventDefaultOn "pointerdown" (D.succeed ( HandlePointerDown pointerDownState, True ))
            , preventDefaultOn "pointerup" (D.succeed ( HandlePointerUp, True ))
            , preventDefaultOn "pointerleave" (D.succeed ( HandlePointerCancel, True ))
            ]
            [ -- preview image
              div [ class "h-24 relative" ]
                [ activityImage activity
                ]
            , div [ class "relative card-body" ]
                [ div [ class "t-column gap-2 h-full", Utils.zIndexes.cardBody ]
                    -- Activity title
                    ([ activityTitle activity
                     , activityDuration duration
                     ]
                        ++ List.map (EffectView.render game mods) orderedEffects
                    )
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


renderLockedActivity : Int -> Html FrontendMsg
renderLockedActivity level =
    div
        [ class "card card-compact bg-base-100 shadow-xl relative text-error cursor-pointer"

        -- Bring this back when we figure out how to solve the problem where the shake happens on every page render?
        -- , class "bubble-shake"
        , class activityHeight
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
                , div [ class "text-lg font-semibold" ] [ text <| "Level " ++ Utils.intToString level ]
                ]
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    -- button [ class "btn btn-square btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
    -- This is used in Melvor to show e.g. item quick-equip and mastery panel, but we don't need yet as we'll show the mastery info in another place.
    div [] []
