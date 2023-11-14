module IdleGame.Spell exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Event
import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra


allSpells : List Spell
allSpells =
    [ Hex1
    , Jinx1
    , Curse1
    , Hex2
    , Jinx2
    , Curse2
    , Hex3
    , Jinx3
    , Curse3
    ]


type alias Record a =
    { hex1 : a
    , hex2 : a
    , hex3 : a
    , jinx1 : a
    , jinx2 : a
    , jinx3 : a
    , curse1 : a
    , curse2 : a
    , curse3 : a
    }


getBySpell : Spell -> Record a -> a
getBySpell kind data =
    case kind of
        Hex1 ->
            data.hex1

        Hex2 ->
            data.hex2

        Hex3 ->
            data.hex3

        Jinx1 ->
            data.jinx1

        Jinx2 ->
            data.jinx2

        Jinx3 ->
            data.jinx3

        Curse1 ->
            data.curse1

        Curse2 ->
            data.curse2

        Curse3 ->
            data.curse3


setBySpell : Spell -> a -> Record a -> Record a
setBySpell kind value data =
    case kind of
        Hex1 ->
            { data | hex1 = value }

        Hex2 ->
            { data | hex2 = value }

        Hex3 ->
            { data | hex3 = value }

        Jinx1 ->
            { data | jinx1 = value }

        Jinx2 ->
            { data | jinx2 = value }

        Jinx3 ->
            { data | jinx3 = value }

        Curse1 ->
            { data | curse1 = value }

        Curse2 ->
            { data | curse2 = value }

        Curse3 ->
            { data | curse3 = value }


updateBySpell : Spell -> (a -> a) -> Record a -> Record a
updateBySpell kind update data =
    setBySpell kind (update (getBySpell kind data)) data


getStats : Spell -> Stats
getStats kind =
    getBySpell kind allStats


getByTitle : String -> Maybe Spell
getByTitle title =
    List.Extra.find (\kind -> (getStats kind).title == title) allSpells


type alias Stats =
    { title : String
    , icon : Icon
    , mods : List Event.Mod -- When this spell is selected these mods are in effect
    }


allStats : Record Stats
allStats =
    { hex1 =
        { title = "Hex I"
        , icon = Icon.fromString "Hx1"
        , mods = [ Event.powerBuff 5 ]
        }
    , jinx1 =
        { title = "Jinx I"
        , icon = Icon.fromString "Jx1"
        , mods = [ Event.powerBuff 10 ]
        }
    , curse1 =
        { title = "Curse I"
        , icon = Icon.fromString "Cs1"
        , mods = [ Event.powerBuff 15 ]
        }
    , hex2 =
        { title = "Hex II"
        , icon = Icon.fromString "Hx2"
        , mods = [ Event.powerBuff 20 ]
        }
    , jinx2 =
        { title = "Jinx II"
        , icon = Icon.fromString "Jx2"
        , mods = [ Event.powerBuff 25 ]
        }
    , curse2 =
        { title = "Curse II"
        , icon = Icon.fromString "Cs2"
        , mods = [ Event.powerBuff 30 ]
        }
    , hex3 =
        { title = "Hex III"
        , icon = Icon.fromString "Hx3"
        , mods = [ Event.powerBuff 35 ]
        }
    , jinx3 =
        { title = "Jinx III"
        , icon = Icon.fromString "Jx3"
        , mods = [ Event.powerBuff 40 ]
        }
    , curse3 =
        { title = "Curse III"
        , icon = Icon.fromString "Cs3"
        , mods = [ Event.powerBuff 45 ]
        }
    }
