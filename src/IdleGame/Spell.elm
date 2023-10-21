module IdleGame.Spell exposing (..)

import IdleGame.Event as Event
import IdleGame.Kinds.Spells as Spells exposing (Spell(..))
import List.Extra


allSpells : List Spell
allSpells =
    [ Hex1
    , Hex2
    ]


type alias Record a =
    { hex1 : a
    , hex2 : a
    }


getBySpell : Spell -> Record a -> a
getBySpell kind data =
    case kind of
        Hex1 ->
            data.hex1

        Hex2 ->
            data.hex2


setBySpell : Spell -> a -> Record a -> Record a
setBySpell kind value data =
    case kind of
        Hex1 ->
            { data | hex1 = value }

        Hex2 ->
            { data | hex2 = value }


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
    , mods : List Event.Mod -- When this spell is selected these mods are in effect
    }


allStats : Record Stats
allStats =
    { hex1 =
        { title = "Hex 1"
        , mods = [ Event.powerBuff 5 ]
        }
    , hex2 =
        { title = "Hex 2"
        , mods = [ Event.powerBuff 10 ]
        }
    }
