module IdleGame.Kinds exposing (..)

{-| This module contains all the kinds of things in the game.
This module gets imported everywhere, so it's not allowed to import _anything_ to prevent import cycles!
-}


type Activity
    = -- Chores
      CleanStables
    | CleanBigBubba
    | SweepChimneys
    | WaterGreenhousePlants
    | WashAndIronRobes
    | OrganizePotionIngredients
    | RepairInstruments
    | FlushDrainDemons
    | OrganizeSpellBooks
      -- Hexes
    | StudyHex1
    | StudyJinx1
    | StudyCurse1
    | StudyHex2
    | StudyJinx2
    | StudyCurse2
    | StudyHex3
    | StudyJinx3
    | StudyCurse3
      -- Adventuring
    | FightMonster1
    | FightMonster2
    | FightMonster3
    | FightMonster4
    | FightMonster5
    | FightMonster6


type
    Spell
    -- Don't forget to update `Spell.allSpells` when you add stuff here!
    = Hex1
    | Hex2
    | Hex3
    | Jinx1
    | Jinx2
    | Jinx3
    | Curse1
    | Curse2
    | Curse3