module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


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


getActivities : Skill.Kind -> List Activity
getActivities skill =
    case skill of
        Skill.Chores ->
            allChores

        Skill.Hexes ->
            allHexes


allKinds : List Activity
allKinds =
    [ IdleGame.Kinds.Activities.CleanStables
    , IdleGame.Kinds.Activities.CleanBigBubba
    , IdleGame.Kinds.Activities.Hex1
    , IdleGame.Kinds.Activities.Jinx1
    ]


type alias Record a =
    { cleanStables : a
    , cleanBigBubba : a
    , hex1 : a
    , jinx1 : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d d d


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


updateByKind : Activity -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


type ActivityImage
    = ActivityLandscape String
    | ActivityIcon Icon


type alias Stats =
    { skill : Skill.Kind
    , title : String
    , image : ActivityImage
    , unlockSkill : Skill.Kind
    , unlockLevel : Int
    , duration : Duration
    , event : Event
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
    }


cleanStablesStats : Stats
cleanStablesStats =
    { skill = Skill.Chores
    , title = "Clean Stables"
    , image = ActivityLandscape "/chores/stable.png"
    , unlockLevel = 1
    , unlockSkill = Skill.Chores
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.int 5) Skill.Chores
                , Event.gainCoin (Coin.int 1)
                , Event.gainMxp IdleGame.Kinds.Activities.CleanStables
                , Event.gainWithProbability 0.5
                    [ Event.gainResource 3 Resource.Manure
                    ]
                ]
            }
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { skill = Skill.Chores
    , title = "Clean Big Bubba's Stall"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockLevel = 10
    , unlockSkill = Skill.Chores
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.int 10) Skill.Chores
                , Event.gainCoin (Coin.int 1)
                , Event.gainMxp IdleGame.Kinds.Activities.CleanBigBubba
                , Event.gainWithProbability 0.5
                    [ Event.gainResource 3 Resource.Manure
                    ]
                ]
            }
    }


hex1Stats : Stats
hex1Stats =
    { skill = Skill.Hexes
    , title = "Hex I"
    , image = ActivityIcon (Resource.getStats Resource.Hex1).icon
    , unlockLevel = 1
    , unlockSkill = Skill.Hexes
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.int 5) Skill.Hexes
                , Event.gainResource -1 Resource.Parchment
                , Event.gainResource 1 Resource.Hex1
                ]
            }
    }


jinx1Stats : Stats
jinx1Stats =
    { skill = Skill.Hexes
    , title = "Jinx I"
    , image = ActivityIcon (Resource.getStats Resource.Jinx1).icon
    , unlockLevel = 10
    , unlockSkill = Skill.Hexes
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.int 10) Skill.Hexes
                , Event.gainResource -1 Resource.Parchment
                , Event.gainResource 1 Resource.Jinx1
                ]
            }
    }
