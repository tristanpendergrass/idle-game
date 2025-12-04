module Evergreen.V1.IdleGame.Kinds exposing (..)


type alias SkillRecord a =
    { herbGathering : a
    , wildMagic : a
    , chores : a
    }


type alias ActivityRecord a =
    { gatherSage : a
    , gatherNettle : a
    , gatherSorrel : a
    , craftSpellHerbSense : a
    , craftSpellBloom : a
    }


type Activity
    = GatherSage
    | GatherNettle
    | GatherSorrel
    | CraftSpellHerbSense
    | CraftSpellBloom


type alias ResourceRecord a =
    { sage : a
    , nettle : a
    , sorrel : a
    , parchment : a
    , herbSenseScroll : a
    , bloomScroll : a
    }


type alias ShopUpgradeRecord a =
    { glasses : a
    }


type Resource
    = Sage
    | Nettle
    | Sorrel
    | Parchment
    | SpellHerbSense
    | SpellBloom


type Skill
    = HerbGathering
    | WildMagic
    | Chores


type ShopUpgrade
    = Glasses
