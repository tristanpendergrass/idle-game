module IdleGame.Views.Location exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Quest as QuestView
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Types exposing (..)


render : FrontendModel -> Game -> Location -> Html FrontendMsg
render model game location =
    let
        monsters : List Monster
        monsters =
            Location.foundMonsters location (Location.getByKind location game.locations)

        monsterListItems : List Game.ActivityListItem
        monsterListItems =
            monsters
                |> List.map Activity.activityForMonster
                |> List.map Game.ActivityListItem

        quests : List Quest
        quests =
            Location.foundQuests location (Location.getByKind location game.locations)

        locationFilter : LocationFilter
        locationFilter =
            Location.getByKind location model.locationFilters

        exploreItem : Html FrontendMsg
        exploreItem =
            ActivityView.renderActivityListItem game (Game.ActivityListItem (Location.getStats location).exploreActivity)

        monsterItems : List (Html FrontendMsg)
        monsterItems =
            List.map
                (ActivityView.renderActivityListItem game)
                monsterListItems

        questItems : List (Html FrontendMsg)
        questItems =
            List.map
                (QuestView.renderQuest game)
                quests
    in
    div [ Utils.skills.wrapper ]
        [ renderLocationInfo game location
        , renderLocationFilters locationFilter location
        , div [ Utils.skills.grid ]
            (case locationFilter of
                LocationAll ->
                    List.concat
                        [ [ exploreItem ]
                        , monsterItems
                        , questItems
                        ]

                LocationMonsters ->
                    monsterItems

                LocationQuests ->
                    questItems
            )
        ]


locationGridItemClasses : Attribute FrontendMsg
locationGridItemClasses =
    class "h-48 rounded-xl bg-base-100"


renderLocationInfo : Game -> Location -> Html FrontendMsg
renderLocationInfo game location =
    let
        percent : Percent
        percent =
            Location.getCompletion location (Location.getByKind location game.locations)
    in
    div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-primary" ]
        [ div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-between" ]
                [ div [ class "text-2xs font-bold" ] [ text "Completion" ]
                ]
            , Utils.progressBar
                { progressText = Utils.floatToString 0 (Percent.toPercentage percent) ++ "%"
                , percent = percent
                , primaryOrSecondary = Utils.Primary
                , size = Utils.ProgressBarLarge
                }
            , div [ class "w-full md:hidden grid grid-cols-4 gap-1" ]
                -- TODO: mobile view
                []
            , div [ class "w-full hidden md:grid grid-cols-4 gap-1 lg:gap-2 xl:gap-4" ]
                [ div [ locationGridItemClasses ] [ renderQuestsPane game location ]
                , div [ locationGridItemClasses ] [ renderResourcesPane game location ]
                , div [ locationGridItemClasses ] [ renderCharactersPane game location ]
                , div [ locationGridItemClasses ] [ renderMonstersPane game location ]
                ]
            ]
        ]


paneClasses =
    { pane = class "t-column h-full w-full p-1 xl:p-2 justify-between"
    , title = class "text-sm"
    , body = class "flex-grow"
    , footer = class "text-xs"
    }


renderResourcesPane : Game -> Location -> Html FrontendMsg
renderResourcesPane game location =
    let
        locationState : Location.State
        locationState =
            Location.getByKind location game.locations

        resourcesAtLocation : List Resource
        resourcesAtLocation =
            Location.resourcesAtLocation location

        resourcesCount : Int
        resourcesCount =
            List.length resourcesAtLocation

        foundResources : List Resource
        foundResources =
            Location.foundResources location locationState

        foundResourcesCount : Int
        foundResourcesCount =
            List.length foundResources
    in
    div [ paneClasses.pane ]
        [ div [ paneClasses.title ] [ text "Resources" ]
        , div [ paneClasses.body, class "grid max-w-full" ]
            (List.concat
                [ List.map (\resource -> (Resource.getStats resource).icon |> Icon.toHtml) foundResources
                , List.repeat (resourcesCount - foundResourcesCount) (Icon.undiscoveredItem |> Icon.toHtml)
                ]
            )
        , div [ paneClasses.footer ]
            [ text <| Utils.intToString foundResourcesCount ++ "/" ++ Utils.intToString resourcesCount ++ " discovered" ]
        ]


renderCharactersPane : Game -> Location -> Html FrontendMsg
renderCharactersPane game location =
    div [ paneClasses.pane ]
        [ div [ paneClasses.title ] [ text "Characters" ]
        ]


renderMonstersPane : Game -> Location -> Html FrontendMsg
renderMonstersPane game location =
    let
        locationState : Location.State
        locationState =
            Location.getByKind location game.locations

        monstersAtLocation : List Monster
        monstersAtLocation =
            Location.monstersAtLocation location

        monstersCount : Int
        monstersCount =
            List.length monstersAtLocation

        foundMonsters : List Monster
        foundMonsters =
            Location.foundMonsters location locationState

        foundMonstersCount : Int
        foundMonstersCount =
            List.length foundMonsters
    in
    div [ paneClasses.pane ]
        [ div [ paneClasses.title ] [ text "Monsters" ]
        , div [ paneClasses.body, class "grid max-w-full" ]
            (List.concat
                [ List.map (\monster -> (Monster.getStats monster).icon |> Icon.toHtml) foundMonsters
                , List.repeat (monstersCount - foundMonstersCount) (Icon.undiscoveredMonster |> Icon.toHtml)
                ]
            )
        , div [ paneClasses.footer ] [ text <| Utils.intToString foundMonstersCount ++ "/" ++ Utils.intToString monstersCount ++ " discovered" ]
        ]


renderQuestsPane : Game -> Location -> Html FrontendMsg
renderQuestsPane game location =
    let
        locationState : Location.State
        locationState =
            Location.getByKind location game.locations

        questsAtLocation : List Quest
        questsAtLocation =
            Location.questsAtLocation location

        questsCount : Int
        questsCount =
            List.length questsAtLocation

        foundQuests : List Quest
        foundQuests =
            Location.foundQuests location locationState

        foundQuestsCount : Int
        foundQuestsCount =
            List.length foundQuests
    in
    div [ paneClasses.pane ]
        [ div [ paneClasses.title ] [ text "Quests" ]
        , button [ class "btn btn-sm btn-primary" ] [ text "Open quest log" ]
        , div [ paneClasses.footer ] [ text <| Utils.intToString foundQuestsCount ++ "/" ++ Utils.intToString questsCount ++ " discovered" ]
        ]


renderLocationFilters : LocationFilter -> Location -> Html FrontendMsg
renderLocationFilters filterState location =
    let
        filterButtonClasses : Attribute FrontendMsg
        filterButtonClasses =
            class "btn btn-sm rounded-3xl focus:bg-neutral"
    in
    div [ class "w-full flex items-center gap-1" ]
        [ button
            [ filterButtonClasses
            , classList [ ( "btn-primary", filterState == LocationMonsters ) ]
            , onClick (HandleLocationFilterClick location LocationMonsters)
            ]
            [ text "Monsters" ]
        , button
            [ filterButtonClasses
            , classList [ ( "btn-primary", filterState == LocationQuests ) ]
            , onClick (HandleLocationFilterClick location LocationQuests)
            ]
            [ text "Quests" ]
        ]
