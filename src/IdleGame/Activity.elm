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


getBySkill : Skill -> List Activity
getBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getActivityStats kind).subject == skill
            )


allAnatomy : List Activity
allAnatomy =
    getBySkill Anatomy



-- type Skill
--     = Anatomy
--     | Biochemistry
--     | Physiology
--     | Pharmacology
--     | Microbiology
--     | Pathology
--     | MedicalEthics
-- allActivities : List Activity
-- allActivities =
--     [ BackAndSpine
--     , UpperLimb
--     , LowerLimb
--     , MetabolicPathways
--     , Enzymology
--     , MolecularBiology
--     , CellularPhysiology
--     , CardiovascularPhysiology
--     , RespiratoryPhysiology
--     , Pharmacokinetics
--     , Pharmacodynamics
--     , Toxicology
--     , Bacteriology
--     , Virology
--     , Mycology
--     , CellInjury
--     , Inflammation
--     , HemodynamicDisorders
--     , PrinciplesOfMedicalEthics
--     , InformedConsent
--     , ConfidentialityAndPrivacy
--     ]


type MasteryReward
    = IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )



-- type BelongsTo
--     = BelongsToSkill Skill
-- belongsToLabel : BelongsTo -> String
-- belongsToLabel belongsTo =
--     case belongsTo of
--         BelongsToSkill skill ->
--             (getSkillStats skill).title
-- type ActivityType
--     = Study
-- typeToString : ActivityType -> String
-- typeToString activityType =
--     case activityType of
--         Study ->
--             "Study"
-- type alias Stats =
--     { belongsTo : Skill
--     , title : String
--     , activityType : ActivityType
--     , duration : Duration
--     , image : CardImage
--     , unlockRequirements : Maybe ( Skill, Int ) -- Changing to just Int
--     , effects : List Effect
--     , mastery : Maybe Mastery
--     , showDuration : Bool -- Getting rid of, they're all yes now.
--     }


type alias EffectStats =
    { effects : List Effect
    , mastery : Maybe Mastery
    }


getEffectStats : Activity -> EffectStats
getEffectStats _ =
    { effects = []
    , mastery = Nothing
    }



-- getStats : Activity -> Stats
-- getStats kind =
--     getByActivity kind allStats
-- Anatomy topics
-- 1.	Back and Spine
-- 2.	Upper Limb
-- 3.	Lower Limb
-- allStats : ActivityRecord Stats
-- allStats =
--     { backAndSpine = backAndSpineStats
--     , upperLimb = upperLimbStats
--     , lowerLimb = lowerLimbStats
--     , metabolicPathways = metabolicPathwaysStats
--     , enzymology = enzymologyStats
--     , molecularBiology = molecularBiologyStats
--     , cellularPhysiology = cellularPhysiologyStats
--     , cardiovascularPhysiology = cardiovascularPhysiologyStats
--     , respiratoryPhysiology = respiratoryPhysiologyStats
--     , pharmacokinetics = pharmacokineticsStats
--     , pharmacodynamics = pharmacodynamicsStats
--     , toxicology = toxicologyStats
--     , bacteriology = bacteriologyStats
--     , virology = virologyStats
--     , mycology = mycologyStats
--     , cellInjury = cellInjuryStats
--     , inflammation = inflammationStats
--     , hemodynamicDisorders = hemodynamicDisordersStats
--     , principlesOfMedicalEthics = principlesOfMedicalEthicsStats
--     , informedConsent = informedConsentStats
--     , confidentialityAndPrivacy = confidentialityAndPrivacyStats
--     }


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



-- backAndSpineStats : Stats
-- backAndSpineStats =
--     { belongsTo = BelongsToSkill Anatomy
--     , title = "Back and Spine"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "BS")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Anatomy
--         , Effect.gainMxp BackAndSpine
--         , Effect.gainResource 1 AnatomyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Anatomy, Effect.ActivityTag BackAndSpine ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- upperLimbStats : Stats
-- upperLimbStats =
--     { belongsTo = BelongsToSkill Anatomy
--     , title = "Upper Limb"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "UL")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Anatomy
--         , Effect.gainMxp UpperLimb
--         , Effect.gainResource 1 AnatomyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Anatomy, Effect.ActivityTag UpperLimb ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- lowerLimbStats : Stats
-- lowerLimbStats =
--     { belongsTo = BelongsToSkill Anatomy
--     , title = "Lower Limb"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "LL")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Anatomy
--         , Effect.gainMxp LowerLimb
--         , Effect.gainResource 1 AnatomyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Anatomy, Effect.ActivityTag LowerLimb ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- metabolicPathwaysStats : Stats
-- metabolicPathwaysStats =
--     { belongsTo = BelongsToSkill Biochemistry
--     , title = "Metabolic Pathways"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "MP")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Biochemistry
--         , Effect.gainMxp MetabolicPathways
--         , Effect.gainResource 1 BiochemistryK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Biochemistry, Effect.ActivityTag MetabolicPathways ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- enzymologyStats : Stats
-- enzymologyStats =
--     { belongsTo = BelongsToSkill Biochemistry
--     , title = "Enzymology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "E")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Biochemistry
--         , Effect.gainMxp Enzymology
--         , Effect.gainResource 1 BiochemistryK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Biochemistry, Effect.ActivityTag Enzymology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- molecularBiologyStats : Stats
-- molecularBiologyStats =
--     { belongsTo = BelongsToSkill Biochemistry
--     , title = "Molecular Biology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "MB")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Biochemistry
--         , Effect.gainMxp MolecularBiology
--         , Effect.gainResource 1 BiochemistryK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Biochemistry, Effect.ActivityTag MolecularBiology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- cellularPhysiologyStats : Stats
-- cellularPhysiologyStats =
--     { belongsTo = BelongsToSkill Physiology
--     , title = "Cellular Physiology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "CP")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Physiology
--         , Effect.gainMxp CellularPhysiology
--         , Effect.gainResource 1 PhysiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Physiology, Effect.ActivityTag CellularPhysiology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- cardiovascularPhysiologyStats : Stats
-- cardiovascularPhysiologyStats =
--     { belongsTo = BelongsToSkill Physiology
--     , title = "Cardiovascular Physiology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "CV")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Physiology
--         , Effect.gainMxp CardiovascularPhysiology
--         , Effect.gainResource 1 PhysiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Physiology, Effect.ActivityTag CardiovascularPhysiology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- respiratoryPhysiologyStats : Stats
-- respiratoryPhysiologyStats =
--     { belongsTo = BelongsToSkill Physiology
--     , title = "Respiratory Physiology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "RP")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Physiology
--         , Effect.gainMxp RespiratoryPhysiology
--         , Effect.gainResource 1 PhysiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Physiology, Effect.ActivityTag RespiratoryPhysiology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- pharmacokineticsStats : Stats
-- pharmacokineticsStats =
--     { belongsTo = BelongsToSkill Pharmacology
--     , title = "Pharmacokinetics"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "PK")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pharmacology
--         , Effect.gainMxp Pharmacokinetics
--         , Effect.gainResource 1 PharmacologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pharmacology, Effect.ActivityTag Pharmacokinetics ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- pharmacodynamicsStats : Stats
-- pharmacodynamicsStats =
--     { belongsTo = BelongsToSkill Pharmacology
--     , title = "Pharmacodynamics"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "PD")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pharmacology
--         , Effect.gainMxp Pharmacodynamics
--         , Effect.gainResource 1 PharmacologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pharmacology, Effect.ActivityTag Pharmacodynamics ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- toxicologyStats : Stats
-- toxicologyStats =
--     { belongsTo = BelongsToSkill Pharmacology
--     , title = "Toxicology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "T")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pharmacology
--         , Effect.gainMxp Toxicology
--         , Effect.gainResource 1 PharmacologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pharmacology, Effect.ActivityTag Toxicology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- bacteriologyStats : Stats
-- bacteriologyStats =
--     { belongsTo = BelongsToSkill Microbiology
--     , title = "Bacteriology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "B")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Microbiology
--         , Effect.gainMxp Bacteriology
--         , Effect.gainResource 1 MicrobiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Microbiology, Effect.ActivityTag Bacteriology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- virologyStats : Stats
-- virologyStats =
--     { belongsTo = BelongsToSkill Microbiology
--     , title = "Virology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "V")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Microbiology
--         , Effect.gainMxp Virology
--         , Effect.gainResource 1 MicrobiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Microbiology, Effect.ActivityTag Virology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- mycologyStats : Stats
-- mycologyStats =
--     { belongsTo = BelongsToSkill Microbiology
--     , title = "Mycology"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "M")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Microbiology
--         , Effect.gainMxp Mycology
--         , Effect.gainResource 1 MicrobiologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Microbiology, Effect.ActivityTag Mycology ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- cellInjuryStats : Stats
-- cellInjuryStats =
--     { belongsTo = BelongsToSkill Pathology
--     , title = "Cell Injury"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "CI")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pathology
--         , Effect.gainMxp CellInjury
--         , Effect.gainResource 1 PathologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pathology, Effect.ActivityTag CellInjury ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- inflammationStats : Stats
-- inflammationStats =
--     { belongsTo = BelongsToSkill Pathology
--     , title = "Inflammation"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "I")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pathology
--         , Effect.gainMxp Inflammation
--         , Effect.gainResource 1 PathologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pathology, Effect.ActivityTag Inflammation ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- hemodynamicDisordersStats : Stats
-- hemodynamicDisordersStats =
--     { belongsTo = BelongsToSkill Pathology
--     , title = "Hemodynamic Disorders"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "HD")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) Pathology
--         , Effect.gainMxp HemodynamicDisorders
--         , Effect.gainResource 1 PathologyK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag Pathology, Effect.ActivityTag HemodynamicDisorders ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- principlesOfMedicalEthicsStats : Stats
-- principlesOfMedicalEthicsStats =
--     { belongsTo = BelongsToSkill MedicalEthics
--     , title = "Principles of Medical Ethics"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "PME")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) MedicalEthics
--         , Effect.gainMxp PrinciplesOfMedicalEthics
--         , Effect.gainResource 1 MedicalEthicsK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag MedicalEthics, Effect.ActivityTag PrinciplesOfMedicalEthics ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- informedConsentStats : Stats
-- informedConsentStats =
--     { belongsTo = BelongsToSkill MedicalEthics
--     , title = "Informed Consent"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "IC")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) MedicalEthics
--         , Effect.gainMxp InformedConsent
--         , Effect.gainResource 1 MedicalEthicsK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag MedicalEthics, Effect.ActivityTag InformedConsent ])
--     , mastery = Nothing
--     , showDuration = False
--     }
-- confidentialityAndPrivacyStats : Stats
-- confidentialityAndPrivacyStats =
--     { belongsTo = BelongsToSkill MedicalEthics
--     , title = "Confidentiality and Privacy"
--     , activityType = Study
--     , image = CardIcon (Icon.fromString "CP")
--     , unlockRequirements = Nothing
--     , duration = Duration.seconds 3
--     , effects =
--         [ Effect.gainXp (Xp.int 10) MedicalEthics
--         , Effect.gainMxp ConfidentialityAndPrivacy
--         , Effect.gainResource 1 MedicalEthicsK
--         ]
--             |> List.map (Effect.withTags [ Effect.SkillTag MedicalEthics, Effect.ActivityTag ConfidentialityAndPrivacy ])
--     , mastery = Nothing
--     , showDuration = False
--     }
