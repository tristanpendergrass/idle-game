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
    | Hex1
    | Jinx1
    | Curse1
    | Hex2
    | Jinx2
    | Curse2
    | Hex3
    | Jinx3
    | Curse3
      -- Adventuring
    | FightMonster1
    | FightMonster2
    | FightMonster3
    | FightMonster4
    | FightMonster5
    | FightMonster6
