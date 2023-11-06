module IdleGame.Kinds exposing (..)

{-| This module contains all the kinds of things in the game.
This module gets imported everywhere, so it's not allowed to import _anything_ to prevent import cycles!
-}


type Skill
    = Chores
    | Hexes


type
    Resource
    -- Don't forget to update IdleGame.Resource! Record + allResources
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


type
    Activity
    -- Don't forget to update IdleGame.Activity! Record + allActivities
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
    | ExploreLocation1
    | ExploreLocation2
    | FightMonster1
    | FightMonster2
    | FightMonster3
    | FightMonster4
    | FightMonster5
    | FightMonster6


type
    Spell
    -- Don't forget to update IdleGame.Spell! Record + allSpells
    = Hex1
    | Hex2
    | Hex3
    | Jinx1
    | Jinx2
    | Jinx3
    | Curse1
    | Curse2
    | Curse3


type
    Location
    -- Don't forget to update IdleGame.Location! Record + allLocations
    = Location1
    | Location2


type
    Monster
    -- Don't forget to update IdleGame.Monster! Record + allMonsters
    = Monster1
    | Monster2


type
    ShopUpgrade
    -- Don't forget to update IdleGame.ShopUpgrade! Record + allShopUpgrades
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag
