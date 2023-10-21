module IdleGame.Spell exposing (..)

import List.Extra


type
    Kind
    -- Don't forget to update `allSpells` when you add stuff here!
    = Hex1
    | Hex2


allSpells : List Kind
allSpells =
    [ Hex1
    , Hex2
    ]


type alias Record a =
    { hex1 : a
    , hex2 : a
    }


getByKind : Kind -> Record a -> a
getByKind kind data =
    case kind of
        Hex1 ->
            data.hex1

        Hex2 ->
            data.hex2


setByKind : Kind -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Hex1 ->
            { data | hex1 = value }

        Hex2 ->
            { data | hex2 = value }


updateByKind : Kind -> (a -> a) -> Record a -> Record a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


getStats : Kind -> Stats
getStats kind =
    getByKind kind allStats


getByTitle : String -> Maybe Kind
getByTitle title =
    List.Extra.find (\kind -> (getStats kind).title == title) allSpells


type alias Stats =
    { title : String
    }


allStats : Record Stats
allStats =
    { hex1 = { title = "Hex 1" }
    , hex2 = { title = "Hex 2" }
    }
