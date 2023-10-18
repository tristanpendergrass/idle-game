module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)


allActivitiesBySkill : Skill.Kind -> List Activity
allActivitiesBySkill skill =
    allKinds
        |> List.filter
            (\kind ->
                (getStats kind).skill == skill
            )


allChores : List Activity
allChores =
    allActivitiesBySkill Skill.Chores


allHexes : List Activity
allHexes =
    allActivitiesBySkill Skill.Hexes


allAdventuring : List Activity
allAdventuring =
    allActivitiesBySkill Skill.Adventuring


getActivities : Skill.Kind -> List Activity
getActivities skill =
    case skill of
        Skill.Chores ->
            allChores

        Skill.Hexes ->
            allHexes

        Skill.Adventuring ->
            allAdventuring


allKinds : List Activity
allKinds =
    [ IdleGame.Kinds.Activities.CleanStables
    , IdleGame.Kinds.Activities.CleanBigBubba
    , IdleGame.Kinds.Activities.Hex1
    , IdleGame.Kinds.Activities.Jinx1
    , IdleGame.Kinds.Activities.FightMonster1
    , IdleGame.Kinds.Activities.FightMonster2
    ]


type alias Record a =
    { cleanStables : a
    , cleanBigBubba : a
    , hex1 : a
    , jinx1 : a
    , fightMonster1 : a
    , fightMonster2 : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d d d d d


getByKind : Activity -> Record a -> a
getByKind kind record =
    case kind of
        IdleGame.Kinds.Activities.CleanStables ->
            record.cleanStables

        IdleGame.Kinds.Activities.CleanBigBubba ->
            record.cleanBigBubba

        IdleGame.Kinds.Activities.Hex1 ->
            record.hex1

        IdleGame.Kinds.Activities.Jinx1 ->
            record.jinx1

        IdleGame.Kinds.Activities.FightMonster1 ->
            record.fightMonster1

        IdleGame.Kinds.Activities.FightMonster2 ->
            record.fightMonster2


setByKind : Activity -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        IdleGame.Kinds.Activities.CleanStables ->
            { record | cleanStables = value }

        IdleGame.Kinds.Activities.CleanBigBubba ->
            { record | cleanBigBubba = value }

        IdleGame.Kinds.Activities.Hex1 ->
            { record | hex1 = value }

        IdleGame.Kinds.Activities.Jinx1 ->
            { record | jinx1 = value }

        IdleGame.Kinds.Activities.FightMonster1 ->
            { record | fightMonster1 = value }

        IdleGame.Kinds.Activities.FightMonster2 ->
            { record | fightMonster2 = value }


updateByKind : Activity -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


type ActivityImage
    = ActivityLandscape String
    | ActivityIcon Icon


type MasteryReward
    = SpellAvailable -- Spell can now be used
    | SecondaryEnabled -- Spell can be used as secondary
    | ImbueEnabled -- Spell can be embued with elements
    | BoostEffects -- Spell effects are boosted
    | IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Event.Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )



-- Todos:
-- Refactor event into ActivityDetails with a list of types like ResourceCreator, MonsterFighter, ResourceTransformer, etc.


type alias Stats =
    { skill : Skill.Kind
    , title : String
    , image : ActivityImage
    , unlockRequirements : Maybe ( Skill.Kind, Int )
    , duration : Duration
    , event : Event
    , mastery : Maybe Mastery
    }


getStats : Activity -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { cleanStables = cleanStablesStats
    , cleanBigBubba = cleanBigBubbaStats
    , hex1 = hex1Stats
    , jinx1 = jinx1Stats
    , fightMonster1 = fightMonster1Stats
    , fightMonster2 = fightMonster2Stats
    }


cleanStablesStats : Stats
cleanStablesStats =
    { skill = Skill.Chores
    , title = "Clean Stables"
    , image = ActivityLandscape "/chores/stable.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Effect.gainXp (Xp.int 5) Skill.Chores
                , Effect.gainCoin (Coin.int 1)
                , Effect.gainMxp IdleGame.Kinds.Activities.CleanStables
                , Effect.gainWithProbability 0.5
                    [ Effect.gainResource 3 Resource.Manure
                    ]
                    |> Effect.withTags [ Effect.ActivityTag IdleGame.Kinds.Activities.CleanStables ]
                ]
            }
    , mastery = Just (getChoresMastery IdleGame.Kinds.Activities.CleanStables)
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { skill = Skill.Chores
    , title = "Clean Big Bubba's Stall"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Just ( Skill.Chores, 10 )
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Effect.gainXp (Xp.int 10) Skill.Chores
                , Effect.gainCoin (Coin.int 1)
                , Effect.gainMxp IdleGame.Kinds.Activities.CleanBigBubba
                , Effect.gainWithProbability 0.5
                    [ Effect.gainResource 3 Resource.Manure
                    ]
                    |> Effect.withTags [ Effect.ActivityTag IdleGame.Kinds.Activities.CleanBigBubba ]
                ]
            }
    , mastery = Just (getChoresMastery IdleGame.Kinds.Activities.CleanBigBubba)
    }


hex1Stats : Stats
hex1Stats =
    { skill = Skill.Hexes
    , title = "Hex I"
    , image = ActivityIcon (Resource.getStats Resource.Hex1).icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Effect.gainXp (Xp.int 5) Skill.Hexes
                , Effect.gainResource -1 Resource.Parchment
                , Effect.gainResource 1 Resource.Hex1
                ]
            }
    , mastery = Just (getActivityMastery IdleGame.Kinds.Activities.Hex1)
    }


jinx1Stats : Stats
jinx1Stats =
    { skill = Skill.Hexes
    , title = "Jinx I"
    , image = ActivityIcon (Resource.getStats Resource.Jinx1).icon
    , unlockRequirements = Just ( Skill.Hexes, 10 )
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Effect.gainXp (Xp.int 10) Skill.Hexes
                , Effect.gainResource -1 Resource.Parchment
                , Effect.gainResource 1 Resource.Jinx1
                ]
            }
    , mastery = Just (getActivityMastery IdleGame.Kinds.Activities.Jinx1)
    }


getActivityMastery : Activity -> Mastery
getActivityMastery chore =
    [ ( 10
      , GameMod
            (Event.xpBuff 0.25
                |> Event.modWithTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 35, GameMod (Event.xpBuff 0.25) )
    , ( 65, GameMod (Event.xpBuff 0.25) )
    , ( 95, GameMod (Event.xpBuff 0.35) )
    ]


getChoresMastery : Activity -> Mastery
getChoresMastery chore =
    [ ( 10
      , GameMod
            (Event.mxpBuff 0.25
                |> Event.modWithTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 35
      , IntervalMod
            { kind = chore
            , percentChange = Percent.fromFloat 0.15
            , label = IntervalModLabel (Percent.fromFloat 0.15)
            }
      )
    , ( 65
      , GameMod
            (Event.resourceBuff 0.2
                |> Event.modWithTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 95
      , GameMod
            (Event.successBuff 0.2
                |> Event.modWithTags [ Effect.ActivityTag chore ]
            )
      )
    ]


defaultSpellMastery : Mastery
defaultSpellMastery =
    [ ( 25, SpellAvailable )
    , ( 50, SecondaryEnabled )
    , ( 75, ImbueEnabled )
    , ( 100, BoostEffects )
    ]


fightMonster1Stats : Stats
fightMonster1Stats =
    { skill = Skill.Adventuring
    , title = "Fight Monster I"
    , image = ActivityIcon (Icon.letter "M1")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , event = Event.Event { effects = [] }
    , mastery = Just defaultSpellMastery
    }


fightMonster2Stats : Stats
fightMonster2Stats =
    { skill = Skill.Adventuring
    , title = "Fight Monster II"
    , image = ActivityIcon (Icon.letter "M2")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , event = Event.Event { effects = [] }
    , mastery = Just defaultSpellMastery
    }
