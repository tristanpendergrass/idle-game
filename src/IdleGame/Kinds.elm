module IdleGame.Kinds exposing (..)

import Duration
import IdleGame.Coin
import IdleGame.Views.Icon


{- !! Generated code, do not edit by hand !! -}


{- Skills -}


type Skill
    = Anatomy
    | Biochemistry
    | Physiology
    | Pharmacology
    | Microbiology
    | Pathology
    | MedicalEthics
    | Labs


allSkills : List Skill
allSkills =
    [ Anatomy
    , Biochemistry
    , Physiology
    , Pharmacology
    , Microbiology
    , Pathology
    , MedicalEthics
    , Labs
    ]


type alias SkillRecord a =
    { anatomy : a
    , biochemistry : a
    , physiology : a
    , pharmacology : a
    , microbiology : a
    , pathology : a
    , medicalEthics : a
    , labs : a
    }


skillRecord : a -> SkillRecord a
skillRecord a =
    { anatomy = a
    , biochemistry = a
    , physiology = a
    , pharmacology = a
    , microbiology = a
    , pathology = a
    , medicalEthics = a
    , labs = a
    }


getBySkill : Skill -> SkillRecord labs -> labs
getBySkill kind data =
    case kind of
        Anatomy ->
            data.anatomy

        Biochemistry ->
            data.biochemistry

        Physiology ->
            data.physiology

        Pharmacology ->
            data.pharmacology

        Microbiology ->
            data.microbiology

        Pathology ->
            data.pathology

        MedicalEthics ->
            data.medicalEthics

        Labs ->
            data.labs


setBySkill : Skill -> value -> SkillRecord value -> SkillRecord value
setBySkill kind value data =
    case kind of
        Anatomy ->
            { data | anatomy = value }

        Biochemistry ->
            { data | biochemistry = value }

        Physiology ->
            { data | physiology = value }

        Pharmacology ->
            { data | pharmacology = value }

        Microbiology ->
            { data | microbiology = value }

        Pathology ->
            { data | pathology = value }

        MedicalEthics ->
            { data | medicalEthics = value }

        Labs ->
            { data | labs = value }


mapSkills :
    (getBySkill -> getBySkill)
    -> SkillRecord getBySkill
    -> SkillRecord getBySkill
mapSkills fn record =
    let
        foldFn el accum =
            setBySkill el (fn (getBySkill el accum)) accum
    in
    List.foldl foldFn record allSkills


type alias SkillStats =
    { title : String, icon : IdleGame.Views.Icon.Icon }


skillStats : SkillRecord SkillStats
skillStats =
    { anatomy = { title = "Anatomy", icon = IdleGame.Views.Icon.accessibility }
    , biochemistry =
        { title = "Biochemistry", icon = IdleGame.Views.Icon.science }
    , physiology =
        { title = "Physiology", icon = IdleGame.Views.Icon.bloodtype }
    , pharmacology =
        { title = "Pharmacology", icon = IdleGame.Views.Icon.medication }
    , microbiology =
        { title = "Microbiology", icon = IdleGame.Views.Icon.biotech }
    , pathology = { title = "Pathology", icon = IdleGame.Views.Icon.biotech }
    , medicalEthics =
        { title = "Medical Ethics", icon = IdleGame.Views.Icon.policy }
    , labs = { title = "Labs", icon = IdleGame.Views.Icon.workspaces }
    }


getSkillStats : Skill -> SkillStats
getSkillStats kind =
    getBySkill kind skillStats


{- Activities -}


type Activity
    = BackAndSpine
    | UpperLimb
    | LowerLimb
    | Thorax
    | Abdomen
    | PelvisAndPerineum
    | HeadAndNeck
    | IntegumentarySystem
    | LymphaticAndImmuneSystem
    | MetabolicPathways
    | Enzymology
    | MolecularBiology
    | LipidMetabolism
    | CarbohydrateMetabolism
    | ProteinSynthesis
    | NucleicAcidMetabolism
    | BiochemicalSignaling
    | VitaminsAndCoenzymes
    | CellularFunction
    | CardiovascularSystem
    | RespiratorySystem
    | RenalFunction
    | DigestiveSystem
    | NervousSystem
    | EndocrineSystem
    | ReproductiveSystem
    | ImmuneResponse
    | Pharmacokinetics
    | Pharmacodynamics
    | Toxicology
    | DrugMetabolism
    | PharmacologicalTherapeutics
    | ClinicalPharmacology
    | Neuropharmacology
    | Chemotherapy
    | CardiovascularPharmacology
    | Bacteriology
    | Virology
    | Mycology
    | Parasitology
    | Immunology
    | MicrobialGenetics
    | HostPathogenInteractions
    | ClinicalMicrobiology
    | AntimicrobialResistance
    | CellInjury
    | Inflammation
    | HemodynamicDisorders
    | Immunopathology
    | GeneticDisorders
    | Neoplasia
    | InfectiousDiseases
    | EnvironmentalPathology
    | NutritionalDisorders
    | PrinciplesOfBioethics
    | InformedConsent
    | ConfidentialityAndPrivacy
    | EndOfLifeDecisionMaking
    | MedicalProfessionalism
    | ResearchEthics
    | Lab1
    | Lab2
    | Lab3
    | Lab4
    | Lab5
    | Lab6


allActivities : List Activity
allActivities =
    [ BackAndSpine
    , UpperLimb
    , LowerLimb
    , Thorax
    , Abdomen
    , PelvisAndPerineum
    , HeadAndNeck
    , IntegumentarySystem
    , LymphaticAndImmuneSystem
    , MetabolicPathways
    , Enzymology
    , MolecularBiology
    , LipidMetabolism
    , CarbohydrateMetabolism
    , ProteinSynthesis
    , NucleicAcidMetabolism
    , BiochemicalSignaling
    , VitaminsAndCoenzymes
    , CellularFunction
    , CardiovascularSystem
    , RespiratorySystem
    , RenalFunction
    , DigestiveSystem
    , NervousSystem
    , EndocrineSystem
    , ReproductiveSystem
    , ImmuneResponse
    , Pharmacokinetics
    , Pharmacodynamics
    , Toxicology
    , DrugMetabolism
    , PharmacologicalTherapeutics
    , ClinicalPharmacology
    , Neuropharmacology
    , Chemotherapy
    , CardiovascularPharmacology
    , Bacteriology
    , Virology
    , Mycology
    , Parasitology
    , Immunology
    , MicrobialGenetics
    , HostPathogenInteractions
    , ClinicalMicrobiology
    , AntimicrobialResistance
    , CellInjury
    , Inflammation
    , HemodynamicDisorders
    , Immunopathology
    , GeneticDisorders
    , Neoplasia
    , InfectiousDiseases
    , EnvironmentalPathology
    , NutritionalDisorders
    , PrinciplesOfBioethics
    , InformedConsent
    , ConfidentialityAndPrivacy
    , EndOfLifeDecisionMaking
    , MedicalProfessionalism
    , ResearchEthics
    , Lab1
    , Lab2
    , Lab3
    , Lab4
    , Lab5
    , Lab6
    ]


type alias ActivityRecord a =
    { backAndSpine : a
    , upperLimb : a
    , lowerLimb : a
    , thorax : a
    , abdomen : a
    , pelvisAndPerineum : a
    , headAndNeck : a
    , integumentarySystem : a
    , lymphaticAndImmuneSystem : a
    , metabolicPathways : a
    , enzymology : a
    , molecularBiology : a
    , lipidMetabolism : a
    , carbohydrateMetabolism : a
    , proteinSynthesis : a
    , nucleicAcidMetabolism : a
    , biochemicalSignaling : a
    , vitaminsAndCoenzymes : a
    , cellularFunction : a
    , cardiovascularSystem : a
    , respiratorySystem : a
    , renalFunction : a
    , digestiveSystem : a
    , nervousSystem : a
    , endocrineSystem : a
    , reproductiveSystem : a
    , immuneResponse : a
    , pharmacokinetics : a
    , pharmacodynamics : a
    , toxicology : a
    , drugMetabolism : a
    , pharmacologicalTherapeutics : a
    , clinicalPharmacology : a
    , neuropharmacology : a
    , chemotherapy : a
    , cardiovascularPharmacology : a
    , bacteriology : a
    , virology : a
    , mycology : a
    , parasitology : a
    , immunology : a
    , microbialGenetics : a
    , hostPathogenInteractions : a
    , clinicalMicrobiology : a
    , antimicrobialResistance : a
    , cellInjury : a
    , inflammation : a
    , hemodynamicDisorders : a
    , immunopathology : a
    , geneticDisorders : a
    , neoplasia : a
    , infectiousDiseases : a
    , environmentalPathology : a
    , nutritionalDisorders : a
    , principlesOfBioethics : a
    , informedConsent : a
    , confidentialityAndPrivacy : a
    , endOfLifeDecisionMaking : a
    , medicalProfessionalism : a
    , researchEthics : a
    , lab1 : a
    , lab2 : a
    , lab3 : a
    , lab4 : a
    , lab5 : a
    , lab6 : a
    }


activityRecord : a -> ActivityRecord a
activityRecord a =
    { backAndSpine = a
    , upperLimb = a
    , lowerLimb = a
    , thorax = a
    , abdomen = a
    , pelvisAndPerineum = a
    , headAndNeck = a
    , integumentarySystem = a
    , lymphaticAndImmuneSystem = a
    , metabolicPathways = a
    , enzymology = a
    , molecularBiology = a
    , lipidMetabolism = a
    , carbohydrateMetabolism = a
    , proteinSynthesis = a
    , nucleicAcidMetabolism = a
    , biochemicalSignaling = a
    , vitaminsAndCoenzymes = a
    , cellularFunction = a
    , cardiovascularSystem = a
    , respiratorySystem = a
    , renalFunction = a
    , digestiveSystem = a
    , nervousSystem = a
    , endocrineSystem = a
    , reproductiveSystem = a
    , immuneResponse = a
    , pharmacokinetics = a
    , pharmacodynamics = a
    , toxicology = a
    , drugMetabolism = a
    , pharmacologicalTherapeutics = a
    , clinicalPharmacology = a
    , neuropharmacology = a
    , chemotherapy = a
    , cardiovascularPharmacology = a
    , bacteriology = a
    , virology = a
    , mycology = a
    , parasitology = a
    , immunology = a
    , microbialGenetics = a
    , hostPathogenInteractions = a
    , clinicalMicrobiology = a
    , antimicrobialResistance = a
    , cellInjury = a
    , inflammation = a
    , hemodynamicDisorders = a
    , immunopathology = a
    , geneticDisorders = a
    , neoplasia = a
    , infectiousDiseases = a
    , environmentalPathology = a
    , nutritionalDisorders = a
    , principlesOfBioethics = a
    , informedConsent = a
    , confidentialityAndPrivacy = a
    , endOfLifeDecisionMaking = a
    , medicalProfessionalism = a
    , researchEthics = a
    , lab1 = a
    , lab2 = a
    , lab3 = a
    , lab4 = a
    , lab5 = a
    , lab6 = a
    }


getByActivity : Activity -> ActivityRecord lab6 -> lab6
getByActivity kind data =
    case kind of
        BackAndSpine ->
            data.backAndSpine

        UpperLimb ->
            data.upperLimb

        LowerLimb ->
            data.lowerLimb

        Thorax ->
            data.thorax

        Abdomen ->
            data.abdomen

        PelvisAndPerineum ->
            data.pelvisAndPerineum

        HeadAndNeck ->
            data.headAndNeck

        IntegumentarySystem ->
            data.integumentarySystem

        LymphaticAndImmuneSystem ->
            data.lymphaticAndImmuneSystem

        MetabolicPathways ->
            data.metabolicPathways

        Enzymology ->
            data.enzymology

        MolecularBiology ->
            data.molecularBiology

        LipidMetabolism ->
            data.lipidMetabolism

        CarbohydrateMetabolism ->
            data.carbohydrateMetabolism

        ProteinSynthesis ->
            data.proteinSynthesis

        NucleicAcidMetabolism ->
            data.nucleicAcidMetabolism

        BiochemicalSignaling ->
            data.biochemicalSignaling

        VitaminsAndCoenzymes ->
            data.vitaminsAndCoenzymes

        CellularFunction ->
            data.cellularFunction

        CardiovascularSystem ->
            data.cardiovascularSystem

        RespiratorySystem ->
            data.respiratorySystem

        RenalFunction ->
            data.renalFunction

        DigestiveSystem ->
            data.digestiveSystem

        NervousSystem ->
            data.nervousSystem

        EndocrineSystem ->
            data.endocrineSystem

        ReproductiveSystem ->
            data.reproductiveSystem

        ImmuneResponse ->
            data.immuneResponse

        Pharmacokinetics ->
            data.pharmacokinetics

        Pharmacodynamics ->
            data.pharmacodynamics

        Toxicology ->
            data.toxicology

        DrugMetabolism ->
            data.drugMetabolism

        PharmacologicalTherapeutics ->
            data.pharmacologicalTherapeutics

        ClinicalPharmacology ->
            data.clinicalPharmacology

        Neuropharmacology ->
            data.neuropharmacology

        Chemotherapy ->
            data.chemotherapy

        CardiovascularPharmacology ->
            data.cardiovascularPharmacology

        Bacteriology ->
            data.bacteriology

        Virology ->
            data.virology

        Mycology ->
            data.mycology

        Parasitology ->
            data.parasitology

        Immunology ->
            data.immunology

        MicrobialGenetics ->
            data.microbialGenetics

        HostPathogenInteractions ->
            data.hostPathogenInteractions

        ClinicalMicrobiology ->
            data.clinicalMicrobiology

        AntimicrobialResistance ->
            data.antimicrobialResistance

        CellInjury ->
            data.cellInjury

        Inflammation ->
            data.inflammation

        HemodynamicDisorders ->
            data.hemodynamicDisorders

        Immunopathology ->
            data.immunopathology

        GeneticDisorders ->
            data.geneticDisorders

        Neoplasia ->
            data.neoplasia

        InfectiousDiseases ->
            data.infectiousDiseases

        EnvironmentalPathology ->
            data.environmentalPathology

        NutritionalDisorders ->
            data.nutritionalDisorders

        PrinciplesOfBioethics ->
            data.principlesOfBioethics

        InformedConsent ->
            data.informedConsent

        ConfidentialityAndPrivacy ->
            data.confidentialityAndPrivacy

        EndOfLifeDecisionMaking ->
            data.endOfLifeDecisionMaking

        MedicalProfessionalism ->
            data.medicalProfessionalism

        ResearchEthics ->
            data.researchEthics

        Lab1 ->
            data.lab1

        Lab2 ->
            data.lab2

        Lab3 ->
            data.lab3

        Lab4 ->
            data.lab4

        Lab5 ->
            data.lab5

        Lab6 ->
            data.lab6


setByActivity :
    Activity -> value -> ActivityRecord value -> ActivityRecord value
setByActivity kind value data =
    case kind of
        BackAndSpine ->
            { data | backAndSpine = value }

        UpperLimb ->
            { data | upperLimb = value }

        LowerLimb ->
            { data | lowerLimb = value }

        Thorax ->
            { data | thorax = value }

        Abdomen ->
            { data | abdomen = value }

        PelvisAndPerineum ->
            { data | pelvisAndPerineum = value }

        HeadAndNeck ->
            { data | headAndNeck = value }

        IntegumentarySystem ->
            { data | integumentarySystem = value }

        LymphaticAndImmuneSystem ->
            { data | lymphaticAndImmuneSystem = value }

        MetabolicPathways ->
            { data | metabolicPathways = value }

        Enzymology ->
            { data | enzymology = value }

        MolecularBiology ->
            { data | molecularBiology = value }

        LipidMetabolism ->
            { data | lipidMetabolism = value }

        CarbohydrateMetabolism ->
            { data | carbohydrateMetabolism = value }

        ProteinSynthesis ->
            { data | proteinSynthesis = value }

        NucleicAcidMetabolism ->
            { data | nucleicAcidMetabolism = value }

        BiochemicalSignaling ->
            { data | biochemicalSignaling = value }

        VitaminsAndCoenzymes ->
            { data | vitaminsAndCoenzymes = value }

        CellularFunction ->
            { data | cellularFunction = value }

        CardiovascularSystem ->
            { data | cardiovascularSystem = value }

        RespiratorySystem ->
            { data | respiratorySystem = value }

        RenalFunction ->
            { data | renalFunction = value }

        DigestiveSystem ->
            { data | digestiveSystem = value }

        NervousSystem ->
            { data | nervousSystem = value }

        EndocrineSystem ->
            { data | endocrineSystem = value }

        ReproductiveSystem ->
            { data | reproductiveSystem = value }

        ImmuneResponse ->
            { data | immuneResponse = value }

        Pharmacokinetics ->
            { data | pharmacokinetics = value }

        Pharmacodynamics ->
            { data | pharmacodynamics = value }

        Toxicology ->
            { data | toxicology = value }

        DrugMetabolism ->
            { data | drugMetabolism = value }

        PharmacologicalTherapeutics ->
            { data | pharmacologicalTherapeutics = value }

        ClinicalPharmacology ->
            { data | clinicalPharmacology = value }

        Neuropharmacology ->
            { data | neuropharmacology = value }

        Chemotherapy ->
            { data | chemotherapy = value }

        CardiovascularPharmacology ->
            { data | cardiovascularPharmacology = value }

        Bacteriology ->
            { data | bacteriology = value }

        Virology ->
            { data | virology = value }

        Mycology ->
            { data | mycology = value }

        Parasitology ->
            { data | parasitology = value }

        Immunology ->
            { data | immunology = value }

        MicrobialGenetics ->
            { data | microbialGenetics = value }

        HostPathogenInteractions ->
            { data | hostPathogenInteractions = value }

        ClinicalMicrobiology ->
            { data | clinicalMicrobiology = value }

        AntimicrobialResistance ->
            { data | antimicrobialResistance = value }

        CellInjury ->
            { data | cellInjury = value }

        Inflammation ->
            { data | inflammation = value }

        HemodynamicDisorders ->
            { data | hemodynamicDisorders = value }

        Immunopathology ->
            { data | immunopathology = value }

        GeneticDisorders ->
            { data | geneticDisorders = value }

        Neoplasia ->
            { data | neoplasia = value }

        InfectiousDiseases ->
            { data | infectiousDiseases = value }

        EnvironmentalPathology ->
            { data | environmentalPathology = value }

        NutritionalDisorders ->
            { data | nutritionalDisorders = value }

        PrinciplesOfBioethics ->
            { data | principlesOfBioethics = value }

        InformedConsent ->
            { data | informedConsent = value }

        ConfidentialityAndPrivacy ->
            { data | confidentialityAndPrivacy = value }

        EndOfLifeDecisionMaking ->
            { data | endOfLifeDecisionMaking = value }

        MedicalProfessionalism ->
            { data | medicalProfessionalism = value }

        ResearchEthics ->
            { data | researchEthics = value }

        Lab1 ->
            { data | lab1 = value }

        Lab2 ->
            { data | lab2 = value }

        Lab3 ->
            { data | lab3 = value }

        Lab4 ->
            { data | lab4 = value }

        Lab5 ->
            { data | lab5 = value }

        Lab6 ->
            { data | lab6 = value }


mapActivities :
    (getByActivity -> getByActivity)
    -> ActivityRecord getByActivity
    -> ActivityRecord getByActivity
mapActivities fn record =
    let
        foldFn el accum =
            setByActivity el (fn (getByActivity el accum)) accum
    in
    List.foldl foldFn record allActivities


type alias ActivityStats =
    { skill : Skill
    , title : String
    , image : String
    , level : Int
    , duration : Duration.Duration
    , knowledge : Maybe Int
    , type_ : String
    , coin : Maybe Int
    , uniqueReward : Maybe Resource
    }


activityStats : ActivityRecord ActivityStats
activityStats =
    { backAndSpine =
        { skill = Anatomy
        , title = "Back and Spine"
        , image = "/activities/anatomy/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , upperLimb =
        { skill = Anatomy
        , title = "Upper Limb"
        , image = "/activities/anatomy/upperLimb.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , lowerLimb =
        { skill = Anatomy
        , title = "Lower Limb"
        , image = "/activities/anatomy/lowerLimb.webp"
        , level = 10
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , thorax =
        { skill = Anatomy
        , title = "Thorax"
        , image = "/activities/anatomy/thorax.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , abdomen =
        { skill = Anatomy
        , title = "Abdomen"
        , image = "/activities/anatomy/abdomen.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , pelvisAndPerineum =
        { skill = Anatomy
        , title = "Pelvis and Perineum"
        , image = "/activities/anatomy/pelvisAndPerineum.webp"
        , level = 45
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , headAndNeck =
        { skill = Anatomy
        , title = "Head and Neck"
        , image = "/activities/anatomy/headAndNeck.webp"
        , level = 55
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , integumentarySystem =
        { skill = Anatomy
        , title = "Integumentary System"
        , image = "/activities/anatomy/integumentarySystem.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , lymphaticAndImmuneSystem =
        { skill = Anatomy
        , title = "Lymphatic And Immune System"
        , image = "/activities/anatomy/lymphaticAndImmuneSystem.webp"
        , level = 75
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , metabolicPathways =
        { skill = Biochemistry
        , title = "Metabolic Pathways"
        , image = "/activities/biochemistry/metabolicPathways.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , enzymology =
        { skill = Biochemistry
        , title = "Enzymology"
        , image = "/activities/biochemistry/enzymology.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , molecularBiology =
        { skill = Biochemistry
        , title = "Molecular Biology"
        , image = "/activities/biochemistry/molecularBiology.webp"
        , level = 10
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , lipidMetabolism =
        { skill = Biochemistry
        , title = "Lipid Metabolism"
        , image = "/activities/biochemistry/lipidMetabolism.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , carbohydrateMetabolism =
        { skill = Biochemistry
        , title = "Carbohydrate Metabolism"
        , image = "/activities/biochemistry/carbohydrateMetabolism.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , proteinSynthesis =
        { skill = Biochemistry
        , title = "Protein Synthesis"
        , image = "/activities/biochemistry/proteinSynthesis.webp"
        , level = 45
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , nucleicAcidMetabolism =
        { skill = Biochemistry
        , title = "Nucleic Acid Metabolism"
        , image = "/activities/biochemistry/nucleicAcidMetabolism.webp"
        , level = 55
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , biochemicalSignaling =
        { skill = Biochemistry
        , title = "Biochemical Signaling"
        , image = "/activities/biochemistry/biochemicalSignaling.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , vitaminsAndCoenzymes =
        { skill = Biochemistry
        , title = "Vitamins and Coenzymes"
        , image = "/activities/biochemistry/vitaminsAndCoenzymes.webp"
        , level = 75
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , cellularFunction =
        { skill = Physiology
        , title = "Cellular Function"
        , image = "/activities/physiology/cellularFunction.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , cardiovascularSystem =
        { skill = Physiology
        , title = "Cardiovascular System"
        , image = "/activities/physiology/cardiovascularSystem.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , respiratorySystem =
        { skill = Physiology
        , title = "Respiratory System"
        , image = "/activities/physiology/respiratorySystem.webp"
        , level = 12
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , renalFunction =
        { skill = Physiology
        , title = "Renal Function"
        , image = "/activities/physiology/renalFunction.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , digestiveSystem =
        { skill = Physiology
        , title = "Digestive System"
        , image = "/activities/physiology/digestiveSystem.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , nervousSystem =
        { skill = Physiology
        , title = "Nervous System"
        , image = "/activities/physiology/nervousSystem.webp"
        , level = 40
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , endocrineSystem =
        { skill = Physiology
        , title = "Endocrine System"
        , image = "/activities/physiology/endocrineSystem.webp"
        , level = 50
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , reproductiveSystem =
        { skill = Physiology
        , title = "Reproductive System"
        , image = "/activities/physiology/reproductiveSystem.webp"
        , level = 60
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , immuneResponse =
        { skill = Physiology
        , title = "Immune Response"
        , image = "/activities/physiology/immuneResponse.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , pharmacokinetics =
        { skill = Pharmacology
        , title = "Pharmacokinetics"
        , image = "/activities/pharmacology/pharmacokinetics.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , pharmacodynamics =
        { skill = Pharmacology
        , title = "Pharmacodynamics"
        , image = "/activities/pharmacology/pharmacodynamics.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , toxicology =
        { skill = Pharmacology
        , title = "Toxicology"
        , image = "/activities/pharmacology/toxicology.webp"
        , level = 12
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , drugMetabolism =
        { skill = Pharmacology
        , title = "Drug Metabolism"
        , image = "/activities/pharmacology/drugMetabolism.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , pharmacologicalTherapeutics =
        { skill = Pharmacology
        , title = "Pharmacological Therapeutics"
        , image = "/activities/pharmacology/pharmacologicalTherapeutics.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , clinicalPharmacology =
        { skill = Pharmacology
        , title = "Clinical Pharmacology"
        , image = "/activities/pharmacology/clinicalPharmacology.webp"
        , level = 40
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , neuropharmacology =
        { skill = Pharmacology
        , title = "Neuropharmacology"
        , image = "/activities/pharmacology/neuropharmacology.webp"
        , level = 50
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , chemotherapy =
        { skill = Pharmacology
        , title = "Chemotherapy"
        , image = "/activities/pharmacology/chemotherapy.webp"
        , level = 60
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , cardiovascularPharmacology =
        { skill = Pharmacology
        , title = "Cariovascular Pharmacology"
        , image = "/activities/pharmacology/cardiovascularPharmacology.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , bacteriology =
        { skill = Microbiology
        , title = "Bacteriology"
        , image = "/activities/microbiology/bacteriology.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , virology =
        { skill = Microbiology
        , title = "Virology"
        , image = "/activities/microbiology/virology.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , mycology =
        { skill = Microbiology
        , title = "Mycology"
        , image = "/activities/microbiology/mycology.webp"
        , level = 12
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , parasitology =
        { skill = Microbiology
        , title = "Parasitology"
        , image = "/activities/microbiology/parasitology.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , immunology =
        { skill = Microbiology
        , title = "Immunology"
        , image = "/activities/microbiology/immunology.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , microbialGenetics =
        { skill = Microbiology
        , title = "Microbial Genetics"
        , image = "/activities/microbiology/microbialGenetics.webp"
        , level = 40
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , hostPathogenInteractions =
        { skill = Microbiology
        , title = "Host-Pathogen Interactions"
        , image = "/activities/microbiology/hostPathogenInteractions.webp"
        , level = 50
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , clinicalMicrobiology =
        { skill = Microbiology
        , title = "Clinical Microbiology"
        , image = "/activities/microbiology/clinicalMicrobiology.webp"
        , level = 60
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , antimicrobialResistance =
        { skill = Microbiology
        , title = "Antimicrobial Resistance"
        , image = "/activities/microbiology/antimicrobialResistance.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , cellInjury =
        { skill = Pathology
        , title = "Cell Injury and Adaptation"
        , image = "/activities/pathology/cellInjury.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , inflammation =
        { skill = Pathology
        , title = "Inflammation and Repair"
        , image = "/activities/pathology/inflammation.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , hemodynamicDisorders =
        { skill = Pathology
        , title = "Hemodynamic Disorders"
        , image = "/activities/pathology/hemodynamicDisorders.webp"
        , level = 10
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , immunopathology =
        { skill = Pathology
        , title = "Immunopathology"
        , image = "/activities/pathology/immunopathology.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , geneticDisorders =
        { skill = Pathology
        , title = "Genetic Disorders"
        , image = "/activities/pathology/geneticDisorders.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , neoplasia =
        { skill = Pathology
        , title = "Neoplasia"
        , image = "/activities/pathology/neoplasia.webp"
        , level = 45
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , infectiousDiseases =
        { skill = Pathology
        , title = "Infectious Diseases"
        , image = "/activities/pathology/infectiousDiseases.webp"
        , level = 55
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , environmentalPathology =
        { skill = Pathology
        , title = "Environmental Pathology"
        , image = "/activities/pathology/environmentalPathology.webp"
        , level = 70
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , nutritionalDisorders =
        { skill = Pathology
        , title = "Nutritional Disorders"
        , image = "/activities/pathology/nutritionalDisorders.webp"
        , level = 75
        , duration = Duration.seconds 6
        , knowledge = Just 3
        , type_ = "Study"
        , coin = Nothing
        , uniqueReward = Nothing
        }
    , principlesOfBioethics =
        { skill = MedicalEthics
        , title = "Principles of Bioethics"
        , image = "/activities/medicalEthics/principlesOfBioethics.webp"
        , level = 1
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Just 5
        , uniqueReward = Nothing
        }
    , informedConsent =
        { skill = MedicalEthics
        , title = "InformedConsent"
        , image = "/activities/medicalEthics/informedConsent.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Just 7
        , uniqueReward = Nothing
        }
    , confidentialityAndPrivacy =
        { skill = MedicalEthics
        , title = "Confidentiality and Privacy"
        , image = "/activities/medicalEthics/confidentialityAndPrivacy.webp"
        , level = 10
        , duration = Duration.seconds 6
        , knowledge = Just 1
        , type_ = "Study"
        , coin = Just 12
        , uniqueReward = Nothing
        }
    , endOfLifeDecisionMaking =
        { skill = MedicalEthics
        , title = "End-of-Life Decision Making"
        , image = "/activities/medicalEthics/endOfLifeDecisionMaking.webp"
        , level = 20
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Just 14
        , uniqueReward = Nothing
        }
    , medicalProfessionalism =
        { skill = MedicalEthics
        , title = "Medical Professionalism"
        , image = "/activities/medicalEthics/medicalProfessionalism.webp"
        , level = 30
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Just 16
        , uniqueReward = Nothing
        }
    , researchEthics =
        { skill = MedicalEthics
        , title = "Research Ethics"
        , image = "/activities/medicalEthics/researchEthics.webp"
        , level = 45
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        , coin = Just 30
        , uniqueReward = Nothing
        }
    , lab1 =
        { skill = Labs
        , title = "Anatomy Lab"
        , image = "/activities/labs/lab.webp"
        , level = 1
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just AnatomyPK
        }
    , lab2 =
        { skill = Labs
        , title = "Biochemistry Lab"
        , image = "/activities/labs/lab.webp"
        , level = 5
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just BiochemistryPK
        }
    , lab3 =
        { skill = Labs
        , title = "Physiology Lab"
        , image = "/activities/labs/lab.webp"
        , level = 10
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just PhysiologyPK
        }
    , lab4 =
        { skill = Labs
        , title = "Pharmacology Lab"
        , image = "/activities/labs/lab.webp"
        , level = 20
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just PharmacologyPK
        }
    , lab5 =
        { skill = Labs
        , title = "Microbiology Lab"
        , image = "/activities/labs/lab.webp"
        , level = 30
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just MicrobiologyPK
        }
    , lab6 =
        { skill = Labs
        , title = "Pathology Lab"
        , image = "/activities/labs/lab.webp"
        , level = 45
        , duration = Duration.seconds 12
        , knowledge = Nothing
        , type_ = "Lab"
        , coin = Just 10
        , uniqueReward = Just PathologyPK
        }
    }


getActivityStats : Activity -> ActivityStats
getActivityStats kind =
    getByActivity kind activityStats


{- Resources -}


type Resource
    = AnatomyK
    | AnatomyPK
    | AnatomyFlashcard
    | BiochemistryK
    | BiochemistryPK
    | BiochemistryFlashcard
    | PhysiologyK
    | PhysiologyPK
    | PhysiologyFlashcard
    | PharmacologyK
    | PharmacologyPK
    | PharmacologyFlashcard
    | MicrobiologyK
    | MicrobiologyPK
    | MicrobiologyFlashcard
    | PathologyK
    | PathologyPK
    | PathologyFlashcard
    | MedicalEthicsK
    | MedicalEthicsPK
    | MedicalEthicsFlashcard


allResources : List Resource
allResources =
    [ AnatomyK
    , AnatomyPK
    , AnatomyFlashcard
    , BiochemistryK
    , BiochemistryPK
    , BiochemistryFlashcard
    , PhysiologyK
    , PhysiologyPK
    , PhysiologyFlashcard
    , PharmacologyK
    , PharmacologyPK
    , PharmacologyFlashcard
    , MicrobiologyK
    , MicrobiologyPK
    , MicrobiologyFlashcard
    , PathologyK
    , PathologyPK
    , PathologyFlashcard
    , MedicalEthicsK
    , MedicalEthicsPK
    , MedicalEthicsFlashcard
    ]


type alias ResourceRecord a =
    { anatomyK : a
    , anatomyPK : a
    , anatomyFlashcard : a
    , biochemistryK : a
    , biochemistryPK : a
    , biochemistryFlashcard : a
    , physiologyK : a
    , physiologyPK : a
    , physiologyFlashcard : a
    , pharmacologyK : a
    , pharmacologyPK : a
    , pharmacologyFlashcard : a
    , microbiologyK : a
    , microbiologyPK : a
    , microbiologyFlashcard : a
    , pathologyK : a
    , pathologyPK : a
    , pathologyFlashcard : a
    , medicalEthicsK : a
    , medicalEthicsPK : a
    , medicalEthicsFlashcard : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { anatomyK = a
    , anatomyPK = a
    , anatomyFlashcard = a
    , biochemistryK = a
    , biochemistryPK = a
    , biochemistryFlashcard = a
    , physiologyK = a
    , physiologyPK = a
    , physiologyFlashcard = a
    , pharmacologyK = a
    , pharmacologyPK = a
    , pharmacologyFlashcard = a
    , microbiologyK = a
    , microbiologyPK = a
    , microbiologyFlashcard = a
    , pathologyK = a
    , pathologyPK = a
    , pathologyFlashcard = a
    , medicalEthicsK = a
    , medicalEthicsPK = a
    , medicalEthicsFlashcard = a
    }


getByResource :
    Resource -> ResourceRecord medicalEthicsFlashcard -> medicalEthicsFlashcard
getByResource kind data =
    case kind of
        AnatomyK ->
            data.anatomyK

        AnatomyPK ->
            data.anatomyPK

        AnatomyFlashcard ->
            data.anatomyFlashcard

        BiochemistryK ->
            data.biochemistryK

        BiochemistryPK ->
            data.biochemistryPK

        BiochemistryFlashcard ->
            data.biochemistryFlashcard

        PhysiologyK ->
            data.physiologyK

        PhysiologyPK ->
            data.physiologyPK

        PhysiologyFlashcard ->
            data.physiologyFlashcard

        PharmacologyK ->
            data.pharmacologyK

        PharmacologyPK ->
            data.pharmacologyPK

        PharmacologyFlashcard ->
            data.pharmacologyFlashcard

        MicrobiologyK ->
            data.microbiologyK

        MicrobiologyPK ->
            data.microbiologyPK

        MicrobiologyFlashcard ->
            data.microbiologyFlashcard

        PathologyK ->
            data.pathologyK

        PathologyPK ->
            data.pathologyPK

        PathologyFlashcard ->
            data.pathologyFlashcard

        MedicalEthicsK ->
            data.medicalEthicsK

        MedicalEthicsPK ->
            data.medicalEthicsPK

        MedicalEthicsFlashcard ->
            data.medicalEthicsFlashcard


setByResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByResource kind value data =
    case kind of
        AnatomyK ->
            { data | anatomyK = value }

        AnatomyPK ->
            { data | anatomyPK = value }

        AnatomyFlashcard ->
            { data | anatomyFlashcard = value }

        BiochemistryK ->
            { data | biochemistryK = value }

        BiochemistryPK ->
            { data | biochemistryPK = value }

        BiochemistryFlashcard ->
            { data | biochemistryFlashcard = value }

        PhysiologyK ->
            { data | physiologyK = value }

        PhysiologyPK ->
            { data | physiologyPK = value }

        PhysiologyFlashcard ->
            { data | physiologyFlashcard = value }

        PharmacologyK ->
            { data | pharmacologyK = value }

        PharmacologyPK ->
            { data | pharmacologyPK = value }

        PharmacologyFlashcard ->
            { data | pharmacologyFlashcard = value }

        MicrobiologyK ->
            { data | microbiologyK = value }

        MicrobiologyPK ->
            { data | microbiologyPK = value }

        MicrobiologyFlashcard ->
            { data | microbiologyFlashcard = value }

        PathologyK ->
            { data | pathologyK = value }

        PathologyPK ->
            { data | pathologyPK = value }

        PathologyFlashcard ->
            { data | pathologyFlashcard = value }

        MedicalEthicsK ->
            { data | medicalEthicsK = value }

        MedicalEthicsPK ->
            { data | medicalEthicsPK = value }

        MedicalEthicsFlashcard ->
            { data | medicalEthicsFlashcard = value }


mapResources :
    (getByResource -> getByResource)
    -> ResourceRecord getByResource
    -> ResourceRecord getByResource
mapResources fn record =
    let
        foldFn el accum =
            setByResource el (fn (getByResource el accum)) accum
    in
    List.foldl foldFn record allResources


type alias ResourceStats =
    { title : String
    , icon : IdleGame.Views.Icon.Icon
    , price : Maybe IdleGame.Coin.Coin
    , reducedBy : Maybe Resource
    }


resourceStats : ResourceRecord ResourceStats
resourceStats =
    { anatomyK =
        { title = "Knowledge (Anatomy)"
        , icon = IdleGame.Views.Icon.createIconPublic "/resources/anatomy_k.png"
        , price = Nothing
        , reducedBy = Just AnatomyPK
        }
    , anatomyPK =
        { title = "Practical Knowledge (Anatomy)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/anatomy_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , anatomyFlashcard =
        { title = "Flashcard (Anatomy)"
        , icon = IdleGame.Views.Icon.createIconPublic "/resources/anatomy_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , biochemistryK =
        { title = "Knowledge (Biochemistry)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/biochemistry_k.png"
        , price = Nothing
        , reducedBy = Just BiochemistryPK
        }
    , biochemistryPK =
        { title = "Practical Knowledge (Biochemistry)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/biochemistry_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , biochemistryFlashcard =
        { title = "Flashcard (Biochemistry)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/biochemistry_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , physiologyK =
        { title = "Knowledge (Physiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/physiology_k.png"
        , price = Nothing
        , reducedBy = Just PhysiologyPK
        }
    , physiologyPK =
        { title = "Practical Knowledge (Physiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/physiology_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , physiologyFlashcard =
        { title = "Flashcard (Physiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/physiology_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , pharmacologyK =
        { title = "Knowledge (Pharmacology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pharmacology_k.png"
        , price = Nothing
        , reducedBy = Just PharmacologyPK
        }
    , pharmacologyPK =
        { title = "Practical Knowledge (Pharmacology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/pharmacology_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , pharmacologyFlashcard =
        { title = "Flashcard (Pharmacology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pharmacology_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , microbiologyK =
        { title = "Knowledge (Microbiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/microbiology_k.png"
        , price = Nothing
        , reducedBy = Just MicrobiologyPK
        }
    , microbiologyPK =
        { title = "Practical Knowledge (Microbiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/microbiology_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , microbiologyFlashcard =
        { title = "Flashcard (Microbiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/microbiology_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , pathologyK =
        { title = "Knowledge (Pathology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pathology_k.png"
        , price = Nothing
        , reducedBy = Just PathologyPK
        }
    , pathologyPK =
        { title = "Practical Knowledge (Pathology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pathology_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , pathologyFlashcard =
        { title = "Flashcard (Pathology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pathology_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , medicalEthicsK =
        { title = "Knowledge (Medical Ethics)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/medical_ethics_k.png"
        , price = Nothing
        , reducedBy = Just MedicalEthicsPK
        }
    , medicalEthicsPK =
        { title = "Practical Knowledge (Medical Ethics)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/medical_ethics_pk.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    , medicalEthicsFlashcard =
        { title = "Flashcard (Medical Ethics)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/medical_ethics_k.png"
        , price = Nothing
        , reducedBy = Nothing
        }
    }


getResourceStats : Resource -> ResourceStats
getResourceStats kind =
    getByResource kind resourceStats


{- AcademicTests -}


type AcademicTestCategory
    = Quiz
    | ShelfExam
    | UsmleStep1


type AcademicTest
    = Anatomy1
    | Anatomy2
    | Anatomy3
    | Anatomy4
    | Anatomy5
    | Biochemistry1
    | Biochemistry2
    | Biochemistry3
    | Biochemistry4
    | Biochemistry5
    | Physiology1
    | Physiology2
    | Physiology3
    | Physiology4
    | Physiology5
    | Pharmacology1
    | Pharmacology2
    | Pharmacology3
    | Pharmacology4
    | Pharmacology5
    | Microbiology1
    | Microbiology2
    | Microbiology3
    | Microbiology4
    | Microbiology5
    | Pathology1
    | Pathology2
    | Pathology3
    | Pathology4
    | Pathology5
    | MedicalEthics1
    | MedicalEthics2
    | MedicalEthics3
    | ShelfExamAnatomy
    | ShelfExamBiochemistry
    | ShelfExamPhysiology
    | ShelfExamPharmacology
    | ShelfExamMicrobiology
    | ShelfExamPathology
    | UsmleStep1Test


allAcademicTests : List AcademicTest
allAcademicTests =
    [ Anatomy1
    , Anatomy2
    , Anatomy3
    , Anatomy4
    , Anatomy5
    , Biochemistry1
    , Biochemistry2
    , Biochemistry3
    , Biochemistry4
    , Biochemistry5
    , Physiology1
    , Physiology2
    , Physiology3
    , Physiology4
    , Physiology5
    , Pharmacology1
    , Pharmacology2
    , Pharmacology3
    , Pharmacology4
    , Pharmacology5
    , Microbiology1
    , Microbiology2
    , Microbiology3
    , Microbiology4
    , Microbiology5
    , Pathology1
    , Pathology2
    , Pathology3
    , Pathology4
    , Pathology5
    , MedicalEthics1
    , MedicalEthics2
    , MedicalEthics3
    , ShelfExamAnatomy
    , ShelfExamBiochemistry
    , ShelfExamPhysiology
    , ShelfExamPharmacology
    , ShelfExamMicrobiology
    , ShelfExamPathology
    , UsmleStep1Test
    ]


type alias AcademicTestRecord a =
    { anatomy1 : a
    , anatomy2 : a
    , anatomy3 : a
    , anatomy4 : a
    , anatomy5 : a
    , biochemistry1 : a
    , biochemistry2 : a
    , biochemistry3 : a
    , biochemistry4 : a
    , biochemistry5 : a
    , physiology1 : a
    , physiology2 : a
    , physiology3 : a
    , physiology4 : a
    , physiology5 : a
    , pharmacology1 : a
    , pharmacology2 : a
    , pharmacology3 : a
    , pharmacology4 : a
    , pharmacology5 : a
    , microbiology1 : a
    , microbiology2 : a
    , microbiology3 : a
    , microbiology4 : a
    , microbiology5 : a
    , pathology1 : a
    , pathology2 : a
    , pathology3 : a
    , pathology4 : a
    , pathology5 : a
    , medicalEthics1 : a
    , medicalEthics2 : a
    , medicalEthics3 : a
    , shelfExamAnatomy : a
    , shelfExamBiochemistry : a
    , shelfExamPhysiology : a
    , shelfExamPharmacology : a
    , shelfExamMicrobiology : a
    , shelfExamPathology : a
    , usmleStep1Test : a
    }


academicTestRecord : a -> AcademicTestRecord a
academicTestRecord a =
    { anatomy1 = a
    , anatomy2 = a
    , anatomy3 = a
    , anatomy4 = a
    , anatomy5 = a
    , biochemistry1 = a
    , biochemistry2 = a
    , biochemistry3 = a
    , biochemistry4 = a
    , biochemistry5 = a
    , physiology1 = a
    , physiology2 = a
    , physiology3 = a
    , physiology4 = a
    , physiology5 = a
    , pharmacology1 = a
    , pharmacology2 = a
    , pharmacology3 = a
    , pharmacology4 = a
    , pharmacology5 = a
    , microbiology1 = a
    , microbiology2 = a
    , microbiology3 = a
    , microbiology4 = a
    , microbiology5 = a
    , pathology1 = a
    , pathology2 = a
    , pathology3 = a
    , pathology4 = a
    , pathology5 = a
    , medicalEthics1 = a
    , medicalEthics2 = a
    , medicalEthics3 = a
    , shelfExamAnatomy = a
    , shelfExamBiochemistry = a
    , shelfExamPhysiology = a
    , shelfExamPharmacology = a
    , shelfExamMicrobiology = a
    , shelfExamPathology = a
    , usmleStep1Test = a
    }


getByAcademicTest :
    AcademicTest -> AcademicTestRecord usmleStep1Test -> usmleStep1Test
getByAcademicTest kind data =
    case kind of
        Anatomy1 ->
            data.anatomy1

        Anatomy2 ->
            data.anatomy2

        Anatomy3 ->
            data.anatomy3

        Anatomy4 ->
            data.anatomy4

        Anatomy5 ->
            data.anatomy5

        Biochemistry1 ->
            data.biochemistry1

        Biochemistry2 ->
            data.biochemistry2

        Biochemistry3 ->
            data.biochemistry3

        Biochemistry4 ->
            data.biochemistry4

        Biochemistry5 ->
            data.biochemistry5

        Physiology1 ->
            data.physiology1

        Physiology2 ->
            data.physiology2

        Physiology3 ->
            data.physiology3

        Physiology4 ->
            data.physiology4

        Physiology5 ->
            data.physiology5

        Pharmacology1 ->
            data.pharmacology1

        Pharmacology2 ->
            data.pharmacology2

        Pharmacology3 ->
            data.pharmacology3

        Pharmacology4 ->
            data.pharmacology4

        Pharmacology5 ->
            data.pharmacology5

        Microbiology1 ->
            data.microbiology1

        Microbiology2 ->
            data.microbiology2

        Microbiology3 ->
            data.microbiology3

        Microbiology4 ->
            data.microbiology4

        Microbiology5 ->
            data.microbiology5

        Pathology1 ->
            data.pathology1

        Pathology2 ->
            data.pathology2

        Pathology3 ->
            data.pathology3

        Pathology4 ->
            data.pathology4

        Pathology5 ->
            data.pathology5

        MedicalEthics1 ->
            data.medicalEthics1

        MedicalEthics2 ->
            data.medicalEthics2

        MedicalEthics3 ->
            data.medicalEthics3

        ShelfExamAnatomy ->
            data.shelfExamAnatomy

        ShelfExamBiochemistry ->
            data.shelfExamBiochemistry

        ShelfExamPhysiology ->
            data.shelfExamPhysiology

        ShelfExamPharmacology ->
            data.shelfExamPharmacology

        ShelfExamMicrobiology ->
            data.shelfExamMicrobiology

        ShelfExamPathology ->
            data.shelfExamPathology

        UsmleStep1Test ->
            data.usmleStep1Test


setByAcademicTest :
    AcademicTest
    -> value
    -> AcademicTestRecord value
    -> AcademicTestRecord value
setByAcademicTest kind value data =
    case kind of
        Anatomy1 ->
            { data | anatomy1 = value }

        Anatomy2 ->
            { data | anatomy2 = value }

        Anatomy3 ->
            { data | anatomy3 = value }

        Anatomy4 ->
            { data | anatomy4 = value }

        Anatomy5 ->
            { data | anatomy5 = value }

        Biochemistry1 ->
            { data | biochemistry1 = value }

        Biochemistry2 ->
            { data | biochemistry2 = value }

        Biochemistry3 ->
            { data | biochemistry3 = value }

        Biochemistry4 ->
            { data | biochemistry4 = value }

        Biochemistry5 ->
            { data | biochemistry5 = value }

        Physiology1 ->
            { data | physiology1 = value }

        Physiology2 ->
            { data | physiology2 = value }

        Physiology3 ->
            { data | physiology3 = value }

        Physiology4 ->
            { data | physiology4 = value }

        Physiology5 ->
            { data | physiology5 = value }

        Pharmacology1 ->
            { data | pharmacology1 = value }

        Pharmacology2 ->
            { data | pharmacology2 = value }

        Pharmacology3 ->
            { data | pharmacology3 = value }

        Pharmacology4 ->
            { data | pharmacology4 = value }

        Pharmacology5 ->
            { data | pharmacology5 = value }

        Microbiology1 ->
            { data | microbiology1 = value }

        Microbiology2 ->
            { data | microbiology2 = value }

        Microbiology3 ->
            { data | microbiology3 = value }

        Microbiology4 ->
            { data | microbiology4 = value }

        Microbiology5 ->
            { data | microbiology5 = value }

        Pathology1 ->
            { data | pathology1 = value }

        Pathology2 ->
            { data | pathology2 = value }

        Pathology3 ->
            { data | pathology3 = value }

        Pathology4 ->
            { data | pathology4 = value }

        Pathology5 ->
            { data | pathology5 = value }

        MedicalEthics1 ->
            { data | medicalEthics1 = value }

        MedicalEthics2 ->
            { data | medicalEthics2 = value }

        MedicalEthics3 ->
            { data | medicalEthics3 = value }

        ShelfExamAnatomy ->
            { data | shelfExamAnatomy = value }

        ShelfExamBiochemistry ->
            { data | shelfExamBiochemistry = value }

        ShelfExamPhysiology ->
            { data | shelfExamPhysiology = value }

        ShelfExamPharmacology ->
            { data | shelfExamPharmacology = value }

        ShelfExamMicrobiology ->
            { data | shelfExamMicrobiology = value }

        ShelfExamPathology ->
            { data | shelfExamPathology = value }

        UsmleStep1Test ->
            { data | usmleStep1Test = value }


mapAcademicTests :
    (getByAcademicTest -> getByAcademicTest)
    -> AcademicTestRecord getByAcademicTest
    -> AcademicTestRecord getByAcademicTest
mapAcademicTests fn record =
    let
        foldFn el accum =
            setByAcademicTest el (fn (getByAcademicTest el accum)) accum
    in
    List.foldl foldFn record allAcademicTests


type alias AcademicTestStats =
    { title : String
    , category : AcademicTestCategory
    , rewardCoin : Maybe IdleGame.Coin.Coin
    , rewardResource : Maybe { resource : Resource, amount : Int }
    , costs : List { resource : Resource, amount : Int }
    , lockedBy : Maybe AcademicTest
    }


academicTestStats : AcademicTestRecord AcademicTestStats
academicTestStats =
    { anatomy1 =
        { title = "Anatomy I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , anatomy2 =
        { title = "Anatomy II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 5000 } ]
        , lockedBy = Just Anatomy1
        }
    , anatomy3 =
        { title = "Anatomy III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 10000 } ]
        , lockedBy = Just Anatomy2
        }
    , anatomy4 =
        { title = "Anatomy IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 20000 } ]
        , lockedBy = Just Anatomy4
        }
    , anatomy5 =
        { title = "Anatomy V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 30000 } ]
        , lockedBy = Just Anatomy4
        }
    , biochemistry1 =
        { title = "Biochemistry I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , biochemistry2 =
        { title = "Biochemistry II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 5000 } ]
        , lockedBy = Just Biochemistry1
        }
    , biochemistry3 =
        { title = "Biochemistry III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 10000 } ]
        , lockedBy = Just Biochemistry2
        }
    , biochemistry4 =
        { title = "Biochemistry IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 20000 } ]
        , lockedBy = Just Biochemistry3
        }
    , biochemistry5 =
        { title = "Biochemistry V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 30000 } ]
        , lockedBy = Just Biochemistry4
        }
    , physiology1 =
        { title = "Physiology I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , physiology2 =
        { title = "Physiology II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 5000 } ]
        , lockedBy = Just Physiology1
        }
    , physiology3 =
        { title = "Physiology III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 10000 } ]
        , lockedBy = Just Physiology2
        }
    , physiology4 =
        { title = "Physiology IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 20000 } ]
        , lockedBy = Just Physiology3
        }
    , physiology5 =
        { title = "Physiology V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 30000 } ]
        , lockedBy = Just Physiology4
        }
    , pharmacology1 =
        { title = "Pharmacology I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , pharmacology2 =
        { title = "Pharmacology II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 5000 } ]
        , lockedBy = Just Pharmacology1
        }
    , pharmacology3 =
        { title = "Pharmacology III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 10000 } ]
        , lockedBy = Just Pharmacology2
        }
    , pharmacology4 =
        { title = "Pharmacology IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 20000 } ]
        , lockedBy = Just Pharmacology3
        }
    , pharmacology5 =
        { title = "Pharmacology V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 30000 } ]
        , lockedBy = Just Pharmacology4
        }
    , microbiology1 =
        { title = "Microbiology I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , microbiology2 =
        { title = "Microbiology II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 5000 } ]
        , lockedBy = Just Microbiology1
        }
    , microbiology3 =
        { title = "Microbiology III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 10000 } ]
        , lockedBy = Just Microbiology2
        }
    , microbiology4 =
        { title = "Microbiology IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 20000 } ]
        , lockedBy = Just Microbiology3
        }
    , microbiology5 =
        { title = "Microbiology V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 30000 } ]
        , lockedBy = Just Microbiology4
        }
    , pathology1 =
        { title = "Pathology I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , pathology2 =
        { title = "Pathology II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 5000 } ]
        , lockedBy = Just Pathology1
        }
    , pathology3 =
        { title = "Pathology III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 10000 } ]
        , lockedBy = Just Pathology2
        }
    , pathology4 =
        { title = "Pathology IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 20000 } ]
        , lockedBy = Just Pathology3
        }
    , pathology5 =
        { title = "Pathology V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 30000 } ]
        , lockedBy = Just Pathology4
        }
    , medicalEthics1 =
        { title = "MedicalEthics I"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 10)
        , rewardResource = Nothing
        , costs = [ { resource = MedicalEthicsK, amount = 1000 } ]
        , lockedBy = Nothing
        }
    , medicalEthics2 =
        { title = "MedicalEthics II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = MedicalEthicsK, amount = 5000 } ]
        , lockedBy = Just MedicalEthics1
        }
    , medicalEthics3 =
        { title = "MedicalEthics III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = MedicalEthicsK, amount = 10000 } ]
        , lockedBy = Just MedicalEthics2
        }
    , shelfExamAnatomy =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , shelfExamBiochemistry =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = BiochemistryK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , shelfExamPhysiology =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = PhysiologyK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , shelfExamPharmacology =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = PharmacologyK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , shelfExamMicrobiology =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = MicrobiologyK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , shelfExamPathology =
        { title = ""
        , category = ShelfExam
        , rewardCoin = Just (IdleGame.Coin.int 1000)
        , rewardResource = Nothing
        , costs = [ { resource = PathologyK, amount = 50000 } ]
        , lockedBy = Nothing
        }
    , usmleStep1Test =
        { title = "Step 1"
        , category = UsmleStep1
        , rewardCoin = Just (IdleGame.Coin.int 10000)
        , rewardResource = Nothing
        , costs =
            [ { resource = AnatomyK, amount = 100000 }
            , { resource = BiochemistryK, amount = 100000 }
            , { resource = AnatomyK, amount = 100000 }
            , { resource = PharmacologyK, amount = 100000 }
            , { resource = MicrobiologyK, amount = 100000 }
            , { resource = PathologyK, amount = 100000 }
            ]
        , lockedBy = Nothing
        }
    }


getAcademicTestStats : AcademicTest -> AcademicTestStats
getAcademicTestStats kind =
    getByAcademicTest kind academicTestStats


{- Shop Upgrades -}


type ShopUpgrade
    = Glasses


allShopUpgrades : List ShopUpgrade
allShopUpgrades =
    [ Glasses ]


type alias ShopUpgradeRecord a =
    { glasses : a }


shopUpgradeRecord : a -> ShopUpgradeRecord a
shopUpgradeRecord a =
    { glasses = a }


getByShopUpgrade : ShopUpgrade -> ShopUpgradeRecord glasses -> glasses
getByShopUpgrade kind data =
    case kind of
        Glasses ->
            data.glasses


setByShopUpgrade :
    ShopUpgrade -> value -> ShopUpgradeRecord value -> ShopUpgradeRecord value
setByShopUpgrade kind value data =
    case kind of
        Glasses ->
            { data | glasses = value }


mapShopUpgrades :
    (getByShopUpgrade -> getByShopUpgrade)
    -> ShopUpgradeRecord getByShopUpgrade
    -> ShopUpgradeRecord getByShopUpgrade
mapShopUpgrades fn record =
    let
        foldFn el accum =
            setByShopUpgrade el (fn (getByShopUpgrade el accum)) accum
    in
    List.foldl foldFn record allShopUpgrades