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
masteryModsAtLevel level mastery =
    let
        perLevel : ( Int, MasteryMod ) -> Maybe MasteryMod
        perLevel ( modInterval, mod ) =
            case perLevelModCount { modInterval = modInterval, mxpLevel = level } of
                0 ->
                    Nothing

                n ->
                    Just (updateModCount (\count -> count * n) mod)

        atLevelMods : List MasteryMod
        atLevelMods =
            mastery.atLevel
                |> List.filterMap
                    (\( requiredLevel, mod ) ->
                        if level >= requiredLevel then
                            Just mod

                        else
                            Nothing
                    )
    in
    List.concat [ List.filterMap perLevel mastery.perLevel, atLevelMods ]


hasMasteryMods : Mastery -> Bool
hasMasteryMods mastery =
    not (List.isEmpty mastery.atLevel && List.isEmpty mastery.perLevel)


type alias Mastery =
    { perLevel : List ( Int, MasteryMod ) -- The Int is the number of levels you gain to get an instance of the mod
    , atLevel : List ( Int, MasteryMod )
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

        tempEffects : List Effect
        tempEffects =
            case activity of
                MetabolicPathways ->
                    [ Effect.spendResource 1 AnatomyK
                        |> Effect.withReducedBy (Effect.ReducedByFlat AnatomyPK)
                    ]

                UpperLimb ->
                    [ Effect.gainResource 1 AnatomyPK
                    ]

                _ ->
                    []

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
            case activity of
                Lab1 ->
                    [ Effect.gainWithProbability (Percent.float 0.5)
                        [ Effect.gainCoin (Coin.int 5)
                            |> Effect.withTags tagsForThisActivity
                        , Effect.gainWithProbability (Percent.float 0.01)
                            [ Effect.gainResource 1 AnatomyPK
                                |> Effect.withOneTime OneTime.Lab1
                            ]
                            |> Effect.withTags tagsForThisActivity
                        ]
                    ]

                _ ->
                    []

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
                    { perLevel =
                        [ ( 10
                          , GameMod
                                (Mod.resourceDoublingBuff (Percent.float 0.05)
                                    |> Mod.withTags [ Effect.ActivityTag activity ]
                                )
                          )
                        ]
                    , atLevel =
                        [ ( 25
                          , GameMod
                                (Mod.gainResourceWithProbability (Percent.float 0.01) AnatomyK
                                    |> Mod.withTags [ Effect.ActivityTag activity ]
                                )
                          )
                        ]
                    }

                Microbiology ->
                    { perLevel =
                        [ ( 5
                          , GameMod
                                (Mod.gainResourceWithProbability (Percent.float 0.01) (getMicriobiologyActivityBonus activity)
                                    |> Mod.withTags [ Effect.ActivityTag activity ]
                                )
                          )
                        ]
                    , atLevel =
                        [ ( 50
                          , GameMod (Mod.resourceDoublingBuff (Percent.float 0.1))
                          )
                        , ( 99
                            -- ISSUE FOUND with this: the mod is adding the extra resource to each effect. So we get more than one per micriobiology completion (one for the K, one for the mxp reward, one for xp, etc)
                          , GameMod
                                (Mod.gainResource 1 (getMicriobiologyActivityBonus activity)
                                    |> Mod.withTags [ Effect.ActivityTag activity ]
                                )
                          )
                        ]
                    }

                _ ->
                    { perLevel = [], atLevel = [] }
    in
    { effects = List.concat [ tempEffects, knowledgeEffects, labEffects, gainMxpEffects, gainXpEffects ]
    , mastery = mastery
    }


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record
