module IdleGame.Kinds exposing (..)

{-| This module contains all the kinds of things in the game.
This module gets imported everywhere, so it's not allowed to import _anything_ to prevent import cycles!
-}


type
    Skill
    -- Don't forget to update IdleGame.Skill! Record + allSkills
    = Chores
    | Hexes
    | Weathermancing



-- type
--     Resource
--     -- Don't forget to update IdleGame.Resource! Record + allResources
--     = Manure
--     | Soot
--     | GreenhouseDirt
--     | WashWater
--     | EmptyBottle
--     | Scrap
--     | Ectoplasm
--     | Parchment


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
    | ExploreSchoolGrounds
    | ExploreSecretGarden
    | FightPrefect
    | FightBookWyrm
    | FightWhisperingWind
      -- Weathermancing
    | StudyWeather1


type
    Spell
    -- Don't forget to update IdleGame.Spell! Record + allSpells
    -- Hexes
    = Hex1
    | Hex2
    | Hex3
    | Jinx1
    | Jinx2
    | Jinx3
    | Curse1
    | Curse2
    | Curse3
      -- Weathermancing
    | Weather1


type
    Location
    -- Don't forget to update IdleGame.Location! Record + allLocations
    = SchoolGrounds
    | SecretGarden


type
    Monster
    -- Don't forget to update IdleGame.Monster! Record + allMonsters
    = Prefect
    | BookWyrm
    | WhisperingWind


type
    ShopUpgrade
    -- Don't forget to update IdleGame.ShopUpgrade! Record + allShopUpgrades
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag


type
    Quest
    -- Don't forget to update IdleGame.Quest! Record + allQuests
    = MendCrackedBell
    | ChopFirewood
