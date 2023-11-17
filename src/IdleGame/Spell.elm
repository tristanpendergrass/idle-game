module IdleGame.Spell exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod
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
    , Weather1
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
    , weather1 : a
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

        Weather1 ->
            data.weather1


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

        Weather1 ->
            { data | weather1 = value }


updateBySpell : Spell -> (a -> a) -> Record a -> Record a
updateBySpell kind update data =
    setBySpell kind (update (getBySpell kind data)) data


getStats : Spell -> Stats
getStats kind =
    getBySpell kind allStats


getByTitle : String -> Maybe Spell
getByTitle title =
    List.Extra.find (\kind -> (getStats kind).title == title) allSpells



-- Stats


type alias Stats =
    { title : String
    , icon : Icon
    , mods : List Mod.Mod -- When this spell is selected these mods are in effect
    , inclusions : List InclusionCriteria -- Which activites this spell can be selected for
    }


type InclusionCriteria
    = IfActivity Activity
    | IfSkill Skill
    | IfCombat


allStats : Record Stats
allStats =
    { hex1 =
        { title = "Hex I"
        , icon = Icon.fromString "Hx1"
        , mods = [ Mod.powerBuff 5 ]
        , inclusions = [ IfCombat ]
        }
    , jinx1 =
        { title = "Jinx I"
        , icon = Icon.fromString "Jx1"
        , mods = [ Mod.powerBuff 10 ]
        , inclusions = [ IfCombat ]
        }
    , curse1 =
        { title = "Curse I"
        , icon = Icon.fromString "Cs1"
        , mods = [ Mod.powerBuff 15 ]
        , inclusions = [ IfCombat ]
        }
    , hex2 =
        { title = "Hex II"
        , icon = Icon.fromString "Hx2"
        , mods = [ Mod.powerBuff 20 ]
        , inclusions = [ IfCombat ]
        }
    , jinx2 =
        { title = "Jinx II"
        , icon = Icon.fromString "Jx2"
        , mods = [ Mod.powerBuff 25 ]
        , inclusions = [ IfCombat ]
        }
    , curse2 =
        { title = "Curse II"
        , icon = Icon.fromString "Cs2"
        , mods = [ Mod.powerBuff 30 ]
        , inclusions = [ IfCombat ]
        }
    , hex3 =
        { title = "Hex III"
        , icon = Icon.fromString "Hx3"
        , mods = [ Mod.powerBuff 35 ]
        , inclusions = [ IfCombat ]
        }
    , jinx3 =
        { title = "Jinx III"
        , icon = Icon.fromString "Jx3"
        , mods = [ Mod.powerBuff 40 ]
        , inclusions = [ IfCombat ]
        }
    , curse3 =
        { title = "Curse III"
        , icon = Icon.fromString "Cs3"
        , mods = [ Mod.powerBuff 45 ]
        , inclusions = [ IfCombat ]
        }
    , weather1 =
        { title = "Weather I"
        , icon = Icon.fromString "Wt1"
        , mods = []
        , inclusions = [ IfSkill Chores ]
        }
    }
