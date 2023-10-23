module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Kinds.Spells as Spells exposing (Spell)
import IdleGame.Mod as Event
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


allActivitiesBySkill : Skill.Kind -> List Activity
allActivitiesBySkill skill =
    allActivities
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


allActivities : List Activity
allActivities =
    [ IdleGame.Kinds.Activities.CleanStables
    , IdleGame.Kinds.Activities.CleanBigBubba
    , IdleGame.Kinds.Activities.Hex1
    , IdleGame.Kinds.Activities.Hex2
    , IdleGame.Kinds.Activities.FightMonster1
    , IdleGame.Kinds.Activities.FightMonster2
    ]


type alias Record a =
    { cleanStables : a
    , cleanBigBubba : a
    , hex1 : a
    , hex2 : a
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

        IdleGame.Kinds.Activities.Hex2 ->
            record.hex2

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

        IdleGame.Kinds.Activities.Hex2 ->
            { record | hex2 = value }

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


choreEffects :
    { activity : Activity
    , xp : Xp
    , coin : Coin
    , maybeResource : Maybe { resource : Resource.Kind, amount : Int, probability : Float }
    }
    -> List Effect.TaggedEffect
choreEffects { activity, xp, coin, maybeResource } =
    let
        choreTags : List Effect.Tag
        choreTags =
            [ Effect.ActivityTag activity ]
    in
    [ { effect = Effect.GainXp { base = xp, multiplier = 1, skill = Skill.Chores }, tags = choreTags }
    , { effect = Effect.GainCoin { base = coin, multiplier = 1 }, tags = choreTags }
    , { effect = Effect.GainMxp { activity = activity, multiplier = 1 }, tags = choreTags }
    ]
        ++ (case maybeResource of
                Nothing ->
                    []

                Just { resource, amount, probability } ->
                    [ { effect =
                            Effect.VariableSuccess
                                { successProbability = probability
                                , successEffects =
                                    [ { effect =
                                            Effect.GainResource
                                                { base = amount
                                                , doublingChance = 0
                                                , resource = resource
                                                }
                                      , tags = choreTags
                                      }
                                    ]
                                , failureEffects = []
                                }
                      , tags = choreTags
                      }
                    ]
           )


type alias Stats =
    { skill : Skill.Kind
    , title : String
    , image : ActivityImage
    , unlockRequirements : Maybe ( Skill.Kind, Int )
    , duration : Duration
    , effects : List Effect.TaggedEffect
    , mastery : Maybe Mastery
    , hasSpellSelector : Bool -- Does this activity support assigning a spell to empower it
    , teachesSpell : Maybe Spell -- Does this activity represent training a specific spell
    }


getStats : Activity -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { cleanStables = cleanStablesStats
    , cleanBigBubba = cleanBigBubbaStats
    , hex1 = hex1Stats
    , hex2 = hex2Stats
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
    , effects =
        choreEffects
            { activity = IdleGame.Kinds.Activities.CleanStables
            , xp = Xp.int 5
            , coin = Coin.int 1
            , maybeResource = Just { resource = Resource.Manure, amount = 3, probability = 0.5 }
            }
    , mastery = Just (getChoresMastery IdleGame.Kinds.Activities.CleanStables)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { skill = Skill.Chores
    , title = "Clean Big Bubba's Stall"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Just ( Skill.Chores, 10 )
    , duration = Duration.seconds 5
    , effects =
        choreEffects
            { activity = IdleGame.Kinds.Activities.CleanBigBubba
            , xp = Xp.int 10
            , coin = Coin.int 2
            , maybeResource = Just { resource = Resource.Manure, amount = 5, probability = 0.5 }
            }
    , mastery = Just (getChoresMastery IdleGame.Kinds.Activities.CleanBigBubba)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


hex1Stats : Stats
hex1Stats =
    { skill = Skill.Hexes
    , title = "Hex I"
    , image = ActivityIcon (Resource.getStats Resource.Hex1).icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 5) Skill.Hexes
        , Effect.gainMxp IdleGame.Kinds.Activities.Hex1
        , Effect.gainResource -1 Resource.Parchment
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex1
    }


hex2Stats : Stats
hex2Stats =
    { skill = Skill.Hexes
    , title = "Hex II"
    , image = ActivityIcon (Resource.getStats Resource.Hex2).icon
    , unlockRequirements = Just ( Skill.Hexes, 10 )
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 10) Skill.Hexes
        , Effect.gainMxp IdleGame.Kinds.Activities.Hex2
        , Effect.gainResource -1 Resource.Parchment
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex2
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
    , effects =
        [ Effect.resolveCombat
            (Combat.create { monsterPower = 1, playerPower = 1 })
            [ Effect.gainCoin (Coin.int 1) ]
            |> Effect.withTags [ Effect.ActivityTag IdleGame.Kinds.Activities.FightMonster1 ]
        ]
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster2Stats : Stats
fightMonster2Stats =
    { skill = Skill.Adventuring
    , title = "Fight Monster II"
    , image = ActivityIcon (Icon.letter "M2")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , effects =
        [ Effect.resolveCombat
            (Combat.create { monsterPower = 2, playerPower = 1 })
            [ Effect.gainCoin (Coin.int 2) ]
            |> Effect.withTags [ Effect.ActivityTag IdleGame.Kinds.Activities.FightMonster2 ]
        ]
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


getBySpell : Spell -> Maybe Activity
getBySpell spell =
    List.Extra.find (\activity -> (getStats activity).teachesSpell == Just spell) allActivities
