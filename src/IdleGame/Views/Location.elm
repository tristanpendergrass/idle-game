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
        [ div [ Utils.skills.grid ]
            (List.concat
                [ [ ActivityView.renderExploreActivity location game ]
                , List.map
                    (ActivityView.renderActivityListItem game)
                    monsterListItems
                ]
            )
        ]
