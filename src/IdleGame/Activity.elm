module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils exposing (cardImage)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


allActivitiesBySkill : Skill -> List Activity
allActivitiesBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getStats kind).belongsTo == BelongsToSkill skill
            )


allAnatomy : List Activity
allAnatomy =
    allActivitiesBySkill Anatomy


getBySkill : Skill -> List Activity
getBySkill skill =
    case skill of
        Anatomy ->
            allAnatomy

        MedicalEthics ->
            []


type MasteryReward
    = IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )


type BelongsTo
    = BelongsToSkill Skill


belongsToLabel : BelongsTo -> String
belongsToLabel belongsTo =
    case belongsTo of
        BelongsToSkill skill ->
            (Skill.getStats skill).title


type Type_
    = Study
    | Combat
    | ExploreAndGather


typeToString : Type_ -> String
typeToString type_ =
    case type_ of
        Study ->
            "Study"

        Combat ->
            "Combat"

        ExploreAndGather ->
            "Explore & Gather"


type alias Stats =
    { belongsTo : BelongsTo
    , title : String
    , type_ : Maybe Type_
    , image : CardImage
    , unlockRequirements : Maybe ( Skill, Int )
    , duration : Duration
    , effects : List Effect
    , mastery : Maybe Mastery
    , showDuration : Bool
    }


getStats : Activity -> Stats
getStats kind =
    getByActivity kind allStats


allStats : ActivityRecord Stats
allStats =
    { grossAnatomy = grossAnatomyStats
    , neuroanatomy = neuroanatomyStats
    }


activityEffects : { belongsTo : BelongsTo, activity : Activity, effects : List Effect } -> List Effect
activityEffects { belongsTo, activity, effects } =
    case belongsTo of
        BelongsToSkill skill ->
            List.map (Effect.withTags [ Effect.SkillTag skill, Effect.ActivityTag activity ]) effects


anatomyEffects :
    { activity : Activity
    , xp : Xp
    , coin : Coin
    , maybeResource : Maybe { resource : Resource, amount : Int, probability : Percent }
    }
    -> List Effect
anatomyEffects { activity, xp, coin, maybeResource } =
    activityEffects
        { belongsTo = BelongsToSkill Anatomy
        , activity = activity
        , effects =
            [ { effect = Effect.GainXp { base = xp, percentIncrease = Percent.zero, skill = Anatomy }, tags = [ Effect.XpTag ] }
            , { effect = Effect.GainCoin { base = coin, percentIncrease = Percent.zero }, tags = [] }
            , { effect = Effect.GainMxp { activity = activity, percentIncrease = Percent.zero }, tags = [ Effect.MxpTag ] }
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
                                                        , doublingChance = Percent.zero
                                                        , resource = resource
                                                        }
                                              , tags = []
                                              }
                                            ]
                                        , failureEffects = []
                                        }
                              , tags = []
                              }
                            ]
                   )
        }


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record


getAnatomyMastery : Activity -> Mastery
getAnatomyMastery activity =
    [ ( 25
      , GameMod
            (Mod.coinBuff (Percent.float 0.1)
                |> Mod.withTags [ Effect.ActivityTag activity ]
            )
      )
    , ( 50
      , GameMod
            (Mod.activityXpBuff activity (Percent.float 0.25)
                |> Mod.withTags [ Effect.ActivityTag activity ]
            )
      )
    , ( 75
      , IntervalMod
            { kind = activity
            , percentChange = Percent.float 0.1
            , label = IntervalModLabel (Percent.float 0.1)
            }
      )
    , ( 100
      , GameMod
            (Mod.skillXpBuff Anatomy (Percent.float 0.05)
                |> Mod.withTags [ Effect.SkillTag Anatomy ]
            )
      )
    ]


grossAnatomyStats : Stats
grossAnatomyStats =
    { belongsTo = BelongsToSkill Anatomy
    , title = "Gross Anatomy"
    , type_ = Nothing
    , image = CardIcon (Icon.fromString "GA")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3
    , effects =
        anatomyEffects
            { activity = GrossAnatomy
            , xp = Xp.int 10
            , coin = Coin.int 1
            , maybeResource = Nothing
            }
    , mastery = Just (getAnatomyMastery GrossAnatomy)
    , showDuration = True
    }


neuroanatomyStats : Stats
neuroanatomyStats =
    { belongsTo = BelongsToSkill Anatomy
    , title = "Neuroanatomy"
    , type_ = Nothing
    , image = CardIcon (Icon.fromString "GA")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3
    , effects =
        anatomyEffects
            { activity = GrossAnatomy
            , xp = Xp.int 10
            , coin = Coin.int 1
            , maybeResource = Nothing
            }
    , mastery = Just (getAnatomyMastery Neuroanatomy)
    , showDuration = True
    }
