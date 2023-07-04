module IdleGame.Skill exposing (..)


type Kind
    = Chores
    | Hexes


type alias Record a =
    { chores : a
    , hexes : a
    }


getByKind : Kind -> Record a -> a
getByKind kind data =
    case kind of
        Chores ->
            data.chores

        Hexes ->
            data.hexes


setByKind : Kind -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Chores ->
            { data | chores = value }

        Hexes ->
            { data | hexes = value }


updateByKind : Kind -> (a -> a) -> Record a -> Record a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


getLabel : Kind -> String
getLabel kind =
    case kind of
        Chores ->
            "Chores"

        Hexes ->
            "Hexes"
