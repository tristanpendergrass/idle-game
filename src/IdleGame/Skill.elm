module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


allSkills : List Skill
allSkills =
    [ Chores, Hexes, Weathermancing ]


type alias Record a =
    { chores : a
    , hexes : a
    , weathermancing : a
    }


getByKind : Skill -> Record a -> a
getByKind kind data =
    case kind of
        Chores ->
            data.chores

        Hexes ->
            data.hexes

        Weathermancing ->
            data.weathermancing


setByKind : Skill -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Chores ->
            { data | chores = value }

        Hexes ->
            { data | hexes = value }

        Weathermancing ->
            { data | weathermancing = value }


updateByKind : Skill -> (a -> a) -> Record a -> Record a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


getLabel : Skill -> String
getLabel kind =
    case kind of
        Chores ->
            "Chores"

        Hexes ->
            "Hexes"

        Weathermancing ->
            "Weathermancing"


getIcon : Skill -> Icon
getIcon kind =
    case kind of
        Chores ->
            Icon.chores

        Hexes ->
            Icon.hexes

        Weathermancing ->
            Icon.weathermancing
