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
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Types exposing (..)


render : Game -> Location -> Html FrontendMsg
render game location =
    let
        monsters : List Monster
        monsters =
            Location.foundMonsters location (Location.getByKind location game.locations)

        monsterListItems : List Game.ActivityListItem
        monsterListItems =
            monsters
                |> List.map Activity.activityForMonster
                |> List.map Game.ActivityListItem
    in
    div [ Utils.skills.wrapper ]
        [ renderLocationInfo game location
        , div [ Utils.skills.grid ]
            (List.concat
                [ [ ActivityView.renderActivityListItem game (Game.ActivityListItem (Location.getStats location).exploreActivity) ]
                , List.map
                    (ActivityView.renderActivityListItem game)
                    monsterListItems
                ]
            )
        ]


locationGridItemClasses : Attribute FrontendMsg
locationGridItemClasses =
    class "h-48 rounded-xl bg-base-100"


renderLocationInfo : Game -> Location -> Html FrontendMsg
renderLocationInfo game location =
    div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-primary" ]
        [ div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-between" ]
                [ div [ class "text-2xs font-bold" ] [ text "Completion" ]
                ]
            , Utils.progressBar { progressText = "15%", percent = Percent.float 0.15, primaryOrSecondary = Utils.Primary, size = Utils.ProgressBarLarge }
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
    { pane = class "t-column w-full p-1 xl:p-2"
    , title = class "text-sm"
    }


renderQuestsPane : Game -> Location -> Html FrontendMsg
renderQuestsPane game location =
    div [ paneClasses.pane ]
        [ div [ paneClasses.title ] [ text "Quests" ]
        ]


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
        , div [] [ text <| "Discovered: " ++ Utils.intToString foundResourcesCount ++ "/" ++ Utils.intToString resourcesCount ]
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
        , div [] [ text <| "Discovered: " ++ Utils.intToString foundMonstersCount ++ "/" ++ Utils.intToString monstersCount ]
        ]
