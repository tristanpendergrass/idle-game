module IdleGame.Spell exposing (..)

import IdleGame.Effect as Effect exposing (Effect, TaggedEffect)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod
import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra
import Percent exposing (Percent)


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
    , cost : List TaggedEffect -- Cost to cast this spell
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
        , cost = [ Effect.spendResource 1 Hex1Scroll ]
        }
    , jinx1 =
        { title = "Jinx I"
        , icon = Icon.fromString "Jx1"
        , mods = [ Mod.powerBuff 10 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Jinx1Scroll ]
        }
    , curse1 =
        { title = "Curse I"
        , icon = Icon.fromString "Cs1"
        , mods = [ Mod.powerBuff 15 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Curse1Scroll ]
        }
    , hex2 =
        { title = "Hex II"
        , icon = Icon.fromString "Hx2"
        , mods = [ Mod.powerBuff 20 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Hex2Scroll ]
        }
    , jinx2 =
        { title = "Jinx II"
        , icon = Icon.fromString "Jx2"
        , mods = [ Mod.powerBuff 25 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Jinx2Scroll ]
        }
    , curse2 =
        { title = "Curse II"
        , icon = Icon.fromString "Cs2"
        , mods = [ Mod.powerBuff 30 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Curse2Scroll ]
        }
    , hex3 =
        { title = "Hex III"
        , icon = Icon.fromString "Hx3"
        , mods = [ Mod.powerBuff 35 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Hex3Scroll ]
        }
    , jinx3 =
        { title = "Jinx III"
        , icon = Icon.fromString "Jx3"
        , mods = [ Mod.powerBuff 40 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Jinx3Scroll ]
        }
    , curse3 =
        { title = "Curse III"
        , icon = Icon.fromString "Cs3"
        , mods = [ Mod.powerBuff 45 ]
        , inclusions = [ IfCombat ]
        , cost = [ Effect.spendResource 1 Curse3Scroll ]
        }
    , wind =
        { title = "Envigorating Breeze"
        , icon = Icon.fromString "Wd1"
        , mods = [ Mod.xpBuff (Percent.float 0.1) ]
        , inclusions = [ IfSkill Chores ]
        , cost = []
        }
    , water =
        { title = "Refreshing Mizzle"
        , icon = Icon.fromString "Wt1"
        , mods = [ Mod.successBuff (Percent.float 0.1) ]
        , inclusions = [ IfSkill Chores ]
        , cost = []
        }
    , sun =
        { title = "Warming Sunrays"
        , icon = Icon.fromString "Sn1"
        , mods = [ Mod.mxpBuff (Percent.float 0.15) ]
        , inclusions = [ IfSkill Chores ]
        , cost = []
        }
    }
