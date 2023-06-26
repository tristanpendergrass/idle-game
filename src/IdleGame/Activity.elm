module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Xp as Xp exposing (Xp)


allChores : List Activity
allChores =
    [ IdleGame.Kinds.Activities.CleanStables
    , IdleGame.Kinds.Activities.CleanBigBubba
    ]


allHexes : List Activity
allHexes =
    [ IdleGame.Kinds.Activities.Hex1
    , IdleGame.Kinds.Activities.Jinx1
    ]


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


type alias Stats =
    { title : String
    , imgSrc : String
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
    { title = "Clean Stables"
    , imgSrc = "/chores/stable.png"
    , unlockLevel = 1
    , unlockSkill = Skill.Chores
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.fromInt 5) Skill.Chores
                , Event.gainCoin 1
                , Event.gainMxp IdleGame.Kinds.Activities.CleanStables
                , Event.gainWithProbability 0.5
                    [ Event.gainResource 3 Resource.Manure
                    ]
                ]
            }
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { title = "Clean Big Bubba's Stall"
    , imgSrc = "/chores/bubba4.png"
    , unlockLevel = 10
    , unlockSkill = Skill.Chores
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.fromInt 10) Skill.Chores
                , Event.gainCoin 1
                , Event.gainMxp IdleGame.Kinds.Activities.CleanBigBubba
                , Event.gainWithProbability 0.5
                    [ Event.gainResource 3 Resource.Manure
                    ]
                ]
            }
    }


hex1Stats : Stats
hex1Stats =
    { title = "Hex I"
    , imgSrc = "/chores/stable.png"
    , unlockLevel = 1
    , unlockSkill = Skill.Hexes
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.fromInt 5) Skill.Hexes
                ]
            }
    }


jinx1Stats : Stats
jinx1Stats =
    { title = "Jinx I"
    , imgSrc = "/chores/stable.png"
    , unlockLevel = 10
    , unlockSkill = Skill.Hexes
    , duration = Duration.seconds 5
    , event =
        Event.Event
            { effects =
                [ Event.gainXp (Xp.fromInt 10) Skill.Hexes
                ]
            }
    }
