module IdleGame.Spell exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod
import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra


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


allStats : SpellRecord Stats
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
