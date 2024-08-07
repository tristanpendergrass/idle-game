module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils exposing (cardImage)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


getBySkill : Skill -> List Activity
getBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getActivityStats kind).skill == skill
            )


allAnatomy : List Activity
allAnatomy =
    getBySkill Anatomy


updateModCount : (Int -> Int) -> MasteryMod -> MasteryMod
updateModCount fn mod =
    case mod of
        IntervalMod intervalMod ->
            IntervalMod { intervalMod | count = fn intervalMod.count }

        GameMod gameMod ->
            GameMod { gameMod | count = fn gameMod.count }


perLevelModCount : { modInterval : Int, mxpLevel : Int } -> Int
perLevelModCount { modInterval, mxpLevel } =
    mxpLevel // modInterval


masteryModsAtLevel : Int -> Mastery -> List MasteryMod
masteryModsAtLevel playerLevel mastery =
    let
        perLevelMods : List MasteryMod
        perLevelMods =
            mastery.perLevel
                |> List.filterMap
                    (\{ interval, mod } ->
                        let
                            n : Int
                            n =
                                perLevelModCount { modInterval = interval, mxpLevel = playerLevel }
                        in
                        if n > 0 then
                            Just (updateModCount (\count -> count * n) mod)

                        else
                            Nothing
                    )

        atLevelMods : List MasteryMod
        atLevelMods =
            mastery.atLevel
                |> List.filterMap
                    (\{ level, mod } ->
                        if playerLevel >= level then
                            Just mod

                        else
                            Nothing
                    )
    in
    perLevelMods ++ atLevelMods


hasMasteryMods : Mastery -> Bool
hasMasteryMods mastery =
    not (List.isEmpty mastery.atLevel && List.isEmpty mastery.perLevel)


type alias Mastery =
    { perLevel : List { interval : Int, mod : MasteryMod } -- The Int is the number of levels you gain to get an instance of the mod
    , atLevel : List { level : Int, mod : MasteryMod }
    }


type MasteryMod
    = IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias EffectStats =
    { effects : List Effect
    , mastery : Mastery
    }


knowledgeResource : Skill -> Maybe Resource
knowledgeResource skill =
    case skill of
        Anatomy ->
            Just AnatomyK

        Biochemistry ->
            Just BiochemistryK

        Physiology ->
            Just PhysiologyK

        Pharmacology ->
            Just PharmacologyK

        Microbiology ->
            Just MicrobiologyK

        Pathology ->
            Just PathologyK

        MedicalEthics ->
            Just MedicalEthicsK

        _ ->
            Nothing


getMicriobiologyActivityBonus : Activity -> Resource
getMicriobiologyActivityBonus activity =
    -- This mapping is for the mastery bonus in microbiology where you get a certain type of K as a bonus
    case activity of
        Bacteriology ->
            PharmacologyK

        Virology ->
            PathologyK

        Mycology ->
            PhysiologyK

        Parasitology ->
            PathologyK

        Immunology ->
            BiochemistryK

        MicrobialGenetics ->
            BiochemistryK

        HostPathogenInteractions ->
            PhysiologyK

        ClinicalMicrobiology ->
            AnatomyK

        AntimicrobialResistance ->
            MedicalEthicsK

        _ ->
            AnatomyK


getEffectStats : Activity -> EffectStats
getEffectStats activity =
    let
        stats : ActivityStats
        stats =
            getActivityStats activity

        tagsForThisActivity : List Effect.Tag
        tagsForThisActivity =
            [ Effect.ActivityTag activity, Effect.SkillTag stats.skill ]

        tagsForActivityCompletion : List Effect.Tag
        tagsForActivityCompletion =
            Effect.ActivityCompleteTag :: tagsForThisActivity

        tempEffects : List Effect
        tempEffects =
            case activity of
                _ ->
                    []

        costs : List Effect
        costs =
            case stats.skill of
                Physiology ->
                    [ Effect.spendResource 1 AnatomyK
                    , Effect.spendResource 1 BiochemistryK
                    ]
                        |> List.map (Effect.withTags tagsForThisActivity)

                Pharmacology ->
                    [ Effect.spendResource 1 BiochemistryK
                    , Effect.spendResource 1 PhysiologyK
                    ]
                        |> List.map (Effect.withTags tagsForThisActivity)

                Microbiology ->
                    [ Effect.spendResource 1 BiochemistryK
                    , Effect.spendResource 1 PhysiologyK
                    ]
                        |> List.map (Effect.withTags tagsForThisActivity)

                Pathology ->
                    [ AnatomyK, BiochemistryK, PhysiologyK, PharmacologyK, MicrobiologyK, MedicalEthicsK ]
                        |> List.map
                            (\resource ->
                                Effect.spendResource 2 resource
                                    |> Effect.withTags tagsForThisActivity
                            )

                _ ->
                    []

        coinEffects : List Effect
        coinEffects =
            case stats.coin of
                Nothing ->
                    []

                Just amount ->
                    if stats.skill == Labs then
                        []

                    else
                        [ Effect.gainCoin (Coin.int amount)
                            |> Effect.withTags tagsForThisActivity
                        ]

        knowledgeEffects : List Effect
        knowledgeEffects =
            case ( knowledgeResource stats.skill, stats.knowledge ) of
                ( Just resource, Just amount ) ->
                    [ Effect.gainResource amount resource
                        |> Effect.withTags tagsForThisActivity
                    ]

                _ ->
                    []

        labEffects : List Effect
        labEffects =
            let
                oneTimeRewardId : Maybe OneTime.OneTimeId
                oneTimeRewardId =
                    case activity of
                        Lab1 ->
                            Just OneTime.Lab1

                        Lab2 ->
                            Just OneTime.Lab2

                        Lab3 ->
                            Just OneTime.Lab3

                        Lab4 ->
                            Just OneTime.Lab4

                        Lab5 ->
                            Just OneTime.Lab5

                        Lab6 ->
                            Just OneTime.Lab6

                        _ ->
                            Nothing

                isLab : Bool
                isLab =
                    List.member activity [ Lab1, Lab2, Lab3, Lab4, Lab5, Lab6 ]

                resourceToSpend : Resource
                resourceToSpend =
                    case activity of
                        Lab1 ->
                            AnatomyK

                        Lab2 ->
                            BiochemistryK

                        Lab3 ->
                            PhysiologyK

                        Lab4 ->
                            PharmacologyK

                        Lab5 ->
                            MicrobiologyK

                        Lab6 ->
                            PathologyK

                        _ ->
                            AnatomyK
            in
            if isLab then
                [ Effect.spendResource 1 resourceToSpend
                , Effect.gainWithProbability (Percent.float 0.245)
                    (List.concat
                        [ case stats.coin of
                            Just amount ->
                                [ Effect.gainCoin (Coin.int amount)
                                    |> Effect.withTags tagsForThisActivity
                                ]

                            Nothing ->
                                []
                        , case ( stats.uniqueReward, oneTimeRewardId ) of
                            ( Just reward, Just rewardId ) ->
                                [ Effect.gainWithProbability (Percent.float 0.00001)
                                    [ Effect.gainResource 1 reward
                                        |> Effect.withOneTime rewardId
                                        |> Effect.withTags tagsForThisActivity
                                    ]
                                ]

                            _ ->
                                []
                        ]
                    )
                ]
                    |> List.map (Effect.withTags tagsForThisActivity)

            else
                []

        activityCompletedEffect : List Effect
        activityCompletedEffect =
            [ Effect.noOp
                |> Effect.withTags
                    (List.concat
                        [ [ Effect.ActivityCompleteTag ]
                        , tagsForThisActivity
                        ]
                    )
            ]

        gainMxpEffects : List Effect
        gainMxpEffects =
            [ Effect.gainMxp activity
                |> Effect.withTags tagsForThisActivity
            ]

        gainXpEffects : List Effect
        gainXpEffects =
            [ Effect.gainXp (Xp.int 5) stats.skill
                |> Effect.withTags tagsForThisActivity
            ]

        mastery : Mastery
        mastery =
            case (getActivityStats activity).skill of
                Anatomy ->
                    { perLevel = []
                    , atLevel =
                        [ { level = 25
                          , mod =
                                GameMod
                                    (Mod.mxpBuff (Percent.float 0.05)
                                        |> Mod.withLabel "+5% Mastery XP for this topic only"
                                        |> Mod.withTags [ Effect.ActivityTag activity ]
                                    )
                          }
                        , { level = 50
                          , mod =
                                GameMod
                                    (Mod.xpBuff (Percent.float 0.0025)
                                        |> Mod.withLabel "+0.25% Global XP"
                                    )
                          }
                        , { level = 75
                          , mod =
                                GameMod
                                    (Mod.mxpBuff (Percent.float 0.0025)
                                        |> Mod.withLabel "+0.25% Global Mastery XP"
                                    )
                          }
                        , { level = 99
                          , mod =
                                GameMod
                                    (Mod.xpAndMxpBuff (Percent.float 0.0075)
                                        |> Mod.withLabel "Global bonuses increased to 1%"
                                    )
                          }
                        ]
                    }

                Biochemistry ->
                    { perLevel = []
                    , atLevel =
                        [ { level = 15
                          , mod =
                                GameMod
                                    (Mod.resourceBaseBuff 1
                                        |> Mod.withLabel "Base knowledge gain +1"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        , { level = 25
                          , mod =
                                GameMod
                                    (Mod.resourceDoublingBuff (Percent.float 0.05)
                                        |> Mod.withLabel "+5% chance to gain double knowledge"
                                    )
                          }
                        , { level = 35
                          , mod =
                                GameMod
                                    (Mod.resourceBaseBuff 1
                                        |> Mod.withLabel "Base knowledge gain +1"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        , { level = 45
                          , mod =
                                GameMod
                                    (Mod.resourceDoublingBuff (Percent.float 0.05)
                                        |> Mod.withLabel "+5% chance to gain double knowledge"
                                    )
                          }
                        , { level = 60
                          , mod =
                                GameMod
                                    (Mod.resourceBaseBuff 1
                                        |> Mod.withLabel "Base knowledge gain +1"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        , { level = 70
                          , mod =
                                GameMod
                                    (Mod.resourceDoublingBuff (Percent.float 0.05)
                                        |> Mod.withLabel "+5% chance to gain double knowledge"
                                    )
                          }
                        , { level = 85
                          , mod =
                                GameMod
                                    (Mod.resourceBaseBuff 1
                                        |> Mod.withLabel "Base knowledge gain +1"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        , { level = 99
                          , mod =
                                GameMod
                                    (Mod.resourceBaseBuff 5
                                        |> Mod.withLabel "Base knowledge gain +5"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        ]
                    }

                Microbiology ->
                    let
                        bonusResource : Resource
                        bonusResource =
                            getMicriobiologyActivityBonus activity

                        bonusResourceTitle : String
                        bonusResourceTitle =
                            (getResourceStats bonusResource).title
                    in
                    { perLevel =
                        [ { interval = 5
                          , mod =
                                GameMod
                                    (Mod.gainResourceWithProbability (Percent.float 0.01) (getMicriobiologyActivityBonus activity)
                                        |> Mod.withLabel ("+1% chance to also gain " ++ bonusResourceTitle)
                                        |> Mod.withTags [ Effect.ActivityTag activity, Effect.ActivityCompleteTag ]
                                    )
                          }
                        ]
                    , atLevel =
                        [ { level = 50
                          , mod =
                                GameMod
                                    (Mod.resourceDoublingBuff (Percent.float 0.1)
                                        |> Mod.withLabel "+10% chance to gain double knowledge"
                                    )
                          }
                        , { level = 99
                          , mod =
                                GameMod
                                    (Mod.gainResource 1
                                        (getMicriobiologyActivityBonus activity)
                                        |> Mod.withLabel ("Alway receive 1 " ++ bonusResourceTitle ++ " (n.b. doubling applies)")
                                        |> Mod.withTags [ Effect.ActivityTag activity, Effect.ActivityCompleteTag ]
                                    )
                          }
                        ]
                    }

                Pathology ->
                    { perLevel =
                        [ { interval = 1
                          , mod =
                                let
                                    ( firstResource, restResources ) =
                                        ( AnatomyK, [ BiochemistryK, PhysiologyK, PharmacologyK, MicrobiologyK, MedicalEthicsK ] )

                                    e : Effect
                                    e =
                                        Effect.gainWithProbability (Percent.float 0.01) [ Effect.oneOf (Effect.gainResource 1 firstResource) (List.map (Effect.gainResource 1) restResources) ]
                                in
                                GameMod
                                    (Mod.addEffects [ e ]
                                        |> Mod.withLabel "+1% chance to gain an additional knowledge other than Pathology"
                                        |> Mod.withTags tagsForActivityCompletion
                                    )
                          }
                        ]
                    , atLevel =
                        [ { level = 50
                          , mod =
                                GameMod
                                    (Mod.resourceSpendDecreaseBuff 1
                                        |> Mod.withLabel "-1 Knowledge cost of each type"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        , { level = 99
                          , mod =
                                GameMod
                                    (Mod.xpBuff (Percent.float 0.0025)
                                        |> Mod.withLabel "+0.25% Global MXP"
                                    )
                          }
                        ]
                    }

                Labs ->
                    { perLevel =
                        [ { interval = 1
                          , mod =
                                GameMod
                                    (Mod.successBuff (Percent.float 0.005)
                                        |> Mod.withLabel "+0.5% chance of success"
                                        |> Mod.withTags tagsForThisActivity
                                    )
                          }
                        ]
                    , atLevel = []
                    }

                _ ->
                    { perLevel = [], atLevel = [] }
    in
    { effects =
        List.concat
            [ costs
            , knowledgeEffects
            , labEffects
            , coinEffects
            , gainMxpEffects
            , gainXpEffects
            , tempEffects
            , activityCompletedEffect
            ]
    , mastery = mastery
    }


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record


createRecordByFn : (Activity -> a) -> ActivityRecord a
createRecordByFn fn =
    let
        emptyRecord : ActivityRecord a
        emptyRecord =
            -- Note: it doesn't matter what activity we put here, it will be overwritten
            activityRecord (fn BackAndSpine)
    in
    List.foldl
        (\activity record ->
            setByActivity activity (fn activity) record
        )
        emptyRecord
        allActivities
