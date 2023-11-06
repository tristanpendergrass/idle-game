module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)


type alias Record a =
    { chores : a
    , hexes : a
    }


getByKind : Skill -> Record a -> a
getByKind kind data =
    case kind of
        Chores ->
            data.chores

        Hexes ->
            data.hexes


setByKind : Skill -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Chores ->
            { data | chores = value }

        Hexes ->
            { data | hexes = value }


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
