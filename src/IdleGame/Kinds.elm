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
    }


getByActivity : Activity -> ActivityRecord lab3 -> lab3
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
    }


activityStats : ActivityRecord ActivityStats
activityStats =
    { backAndSpine =
        { skill = Anatomy
        , title = "Back and Spine"
        , image = "/activities/anatomy/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , upperLimb =
        { skill = Anatomy
        , title = "Upper Limb"
        , image = "/activities/anatomy/upperLimb.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = Just 2
        , type_ = "Study"
        }
    , lowerLimb =
        { skill = Anatomy
        , title = "Lower Limb"
        , image = "/activities/anatomy/lowerLimb.webp"
        , level = 10
        , duration = Duration.seconds 7
        , knowledge = Just 3
        , type_ = "Study"
        }
    , thorax =
        { skill = Anatomy
        , title = "Thorax"
        , image = "/activities/anatomy/thorax.webp"
        , level = 20
        , duration = Duration.seconds 8
        , knowledge = Just 3
        , type_ = "Study"
        }
    , abdomen =
        { skill = Anatomy
        , title = "Abdomen"
        , image = "/activities/anatomy/abdomen.webp"
        , level = 30
        , duration = Duration.seconds 9
        , knowledge = Just 3
        , type_ = "Study"
        }
    , pelvisAndPerineum =
        { skill = Anatomy
        , title = "Pelvis and Perineum"
        , image = "/activities/anatomy/pelvisAndPerineum.webp"
        , level = 45
        , duration = Duration.seconds 10
        , knowledge = Just 3
        , type_ = "Study"
        }
    , headAndNeck =
        { skill = Anatomy
        , title = "Head and Neck"
        , image = "/activities/anatomy/headAndNeck.webp"
        , level = 55
        , duration = Duration.seconds 11
        , knowledge = Just 3
        , type_ = "Study"
        }
    , integumentarySystem =
        { skill = Anatomy
        , title = "Integumentary System"
        , image = "/activities/anatomy/integumentarySystem.webp"
        , level = 70
        , duration = Duration.seconds 12
        , knowledge = Just 3
        , type_ = "Study"
        }
    , lymphaticAndImmuneSystem =
        { skill = Anatomy
        , title = "Lymphatic And Immune System"
        , image = "/activities/anatomy/lymphaticAndImmuneSystem.webp"
        , level = 75
        , duration = Duration.seconds 13
        , knowledge = Just 3
        , type_ = "Study"
        }
    , metabolicPathways =
        { skill = Biochemistry
        , title = "Metabolic Pathways"
        , image = "/activities/biochemistry/metabolicPathways.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , enzymology =
        { skill = Biochemistry
        , title = "Enzymology"
        , image = "/activities/biochemistry/enzymology.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , molecularBiology =
        { skill = Biochemistry
        , title = "Molecular Biology"
        , image = "/activities/biochemistry/molecularBiology.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , lipidMetabolism =
        { skill = Biochemistry
        , title = "Lipid Metabolism"
        , image = "/activities/biochemistry/lipidMetabolism.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , carbohydrateMetabolism =
        { skill = Biochemistry
        , title = "Carbohydrate Metabolism"
        , image = "/activities/biochemistry/carbohydrateMetabolism.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , proteinSynthesis =
        { skill = Biochemistry
        , title = "Protein Synthesis"
        , image = "/activities/biochemistry/proteinSynthesis.webp"
        , level = 45
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , nucleicAcidMetabolism =
        { skill = Biochemistry
        , title = "Nucleic Acid Metabolism"
        , image = "/activities/biochemistry/nucleicAcidMetabolism.webp"
        , level = 55
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , biochemicalSignaling =
        { skill = Biochemistry
        , title = "Biochemical Signaling"
        , image = "/activities/biochemistry/biochemicalSignaling.webp"
        , level = 70
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , vitaminsAndCoenzymes =
        { skill = Biochemistry
        , title = "Vitamins and Coenzymes"
        , image = "/activities/biochemistry/vitaminsAndCoenzymes.webp"
        , level = 75
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , cellularFunction =
        { skill = Physiology
        , title = "Cellular Function"
        , image = "/activities/physiology/cellularFunction.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , cardiovascularSystem =
        { skill = Physiology
        , title = "Cardiovascular System"
        , image = "/activities/physiology/cardiovascularSystem.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , respiratorySystem =
        { skill = Physiology
        , title = "Respiratory System"
        , image = "/activities/physiology/respiratorySystem.webp"
        , level = 12
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , renalFunction =
        { skill = Physiology
        , title = "Renal Function"
        , image = "/activities/physiology/renalFunction.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 4
        , type_ = "Study"
        }
    , digestiveSystem =
        { skill = Physiology
        , title = "Digestive System"
        , image = "/activities/physiology/digestiveSystem.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 5
        , type_ = "Study"
        }
    , nervousSystem =
        { skill = Physiology
        , title = "Nervous System"
        , image = "/activities/physiology/nervousSystem.webp"
        , level = 40
        , duration = Duration.seconds 5
        , knowledge = Just 6
        , type_ = "Study"
        }
    , endocrineSystem =
        { skill = Physiology
        , title = "Endocrine System"
        , image = "/activities/physiology/endocrineSystem.webp"
        , level = 50
        , duration = Duration.seconds 5
        , knowledge = Just 7
        , type_ = "Study"
        }
    , reproductiveSystem =
        { skill = Physiology
        , title = "Reproductive System"
        , image = "/activities/physiology/reproductiveSystem.webp"
        , level = 60
        , duration = Duration.seconds 5
        , knowledge = Just 8
        , type_ = "Study"
        }
    , immuneResponse =
        { skill = Physiology
        , title = "Immune Response"
        , image = "/activities/physiology/immuneResponse.webp"
        , level = 70
        , duration = Duration.seconds 5
        , knowledge = Just 9
        , type_ = "Study"
        }
    , pharmacokinetics =
        { skill = Pharmacology
        , title = "Pharmacokinetics"
        , image = "/activities/pharmacology/pharmacokinetics.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , pharmacodynamics =
        { skill = Pharmacology
        , title = "Pharmacodynamics"
        , image = "/activities/pharmacology/pharmacodynamics.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , toxicology =
        { skill = Pharmacology
        , title = "Toxicology"
        , image = "/activities/pharmacology/toxicology.webp"
        , level = 12
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , drugMetabolism =
        { skill = Pharmacology
        , title = "Drug Metabolism"
        , image = "/activities/pharmacology/drugMetabolism.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 4
        , type_ = "Study"
        }
    , pharmacologicalTherapeutics =
        { skill = Pharmacology
        , title = "Pharmacological Therapeutics"
        , image = "/activities/pharmacology/pharmacologicalTherapeutics.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 5
        , type_ = "Study"
        }
    , clinicalPharmacology =
        { skill = Pharmacology
        , title = "Clinical Pharmacology"
        , image = "/activities/pharmacology/clinicalPharmacology.webp"
        , level = 40
        , duration = Duration.seconds 5
        , knowledge = Just 6
        , type_ = "Study"
        }
    , neuropharmacology =
        { skill = Pharmacology
        , title = "Neuropharmacology"
        , image = "/activities/pharmacology/neuropharmacology.webp"
        , level = 50
        , duration = Duration.seconds 5
        , knowledge = Just 7
        , type_ = "Study"
        }
    , chemotherapy =
        { skill = Pharmacology
        , title = "Chemotherapy"
        , image = "/activities/pharmacology/chemotherapy.webp"
        , level = 60
        , duration = Duration.seconds 5
        , knowledge = Just 8
        , type_ = "Study"
        }
    , cardiovascularPharmacology =
        { skill = Pharmacology
        , title = "Cariovascular Pharmacology"
        , image = "/activities/pharmacology/cardiovascularPharmacology.webp"
        , level = 70
        , duration = Duration.seconds 5
        , knowledge = Just 9
        , type_ = "Study"
        }
    , bacteriology =
        { skill = Microbiology
        , title = "Bacteriology"
        , image = "/activities/microbiology/bacteriology.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , virology =
        { skill = Microbiology
        , title = "Virology"
        , image = "/activities/microbiology/virology.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , mycology =
        { skill = Microbiology
        , title = "Mycology"
        , image = "/activities/microbiology/mycology.webp"
        , level = 12
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , parasitology =
        { skill = Microbiology
        , title = "Parasitology"
        , image = "/activities/microbiology/parasitology.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 4
        , type_ = "Study"
        }
    , immunology =
        { skill = Microbiology
        , title = "Immunology"
        , image = "/activities/microbiology/immunology.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 5
        , type_ = "Study"
        }
    , microbialGenetics =
        { skill = Microbiology
        , title = "Microbial Genetics"
        , image = "/activities/microbiology/microbialGenetics.webp"
        , level = 40
        , duration = Duration.seconds 5
        , knowledge = Just 6
        , type_ = "Study"
        }
    , hostPathogenInteractions =
        { skill = Microbiology
        , title = "Host-Pathogen Interactions"
        , image = "/activities/microbiology/hostPathogenInteractions.webp"
        , level = 50
        , duration = Duration.seconds 5
        , knowledge = Just 7
        , type_ = "Study"
        }
    , clinicalMicrobiology =
        { skill = Microbiology
        , title = "Clinical Microbiology"
        , image = "/activities/microbiology/clinicalMicrobiology.webp"
        , level = 60
        , duration = Duration.seconds 5
        , knowledge = Just 8
        , type_ = "Study"
        }
    , antimicrobialResistance =
        { skill = Microbiology
        , title = "Antimicrobial Resistance"
        , image = "/activities/microbiology/antimicrobialResistance.webp"
        , level = 70
        , duration = Duration.seconds 5
        , knowledge = Just 9
        , type_ = "Study"
        }
    , cellInjury =
        { skill = Pathology
        , title = "Cell Injury and Adaptation"
        , image = "/activities/pathology/cellInjury.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , inflammation =
        { skill = Pathology
        , title = "Inflammation and Repair"
        , image = "/activities/pathology/inflammation.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , hemodynamicDisorders =
        { skill = Pathology
        , title = "Hemodynamic Disorders"
        , image = "/activities/pathology/hemodynamicDisorders.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , immunopathology =
        { skill = Pathology
        , title = "Immunopathology"
        , image = "/activities/pathology/immunopathology.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 4
        , type_ = "Study"
        }
    , geneticDisorders =
        { skill = Pathology
        , title = "Genetic Disorders"
        , image = "/activities/pathology/geneticDisorders.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 5
        , type_ = "Study"
        }
    , neoplasia =
        { skill = Pathology
        , title = "Neoplasia"
        , image = "/activities/pathology/neoplasia.webp"
        , level = 45
        , duration = Duration.seconds 5
        , knowledge = Just 6
        , type_ = "Study"
        }
    , infectiousDiseases =
        { skill = Pathology
        , title = "Infectious Diseases"
        , image = "/activities/pathology/infectiousDiseases.webp"
        , level = 55
        , duration = Duration.seconds 5
        , knowledge = Just 7
        , type_ = "Study"
        }
    , environmentalPathology =
        { skill = Pathology
        , title = "Environmental Pathology"
        , image = "/activities/pathology/environmentalPathology.webp"
        , level = 70
        , duration = Duration.seconds 5
        , knowledge = Just 8
        , type_ = "Study"
        }
    , nutritionalDisorders =
        { skill = Pathology
        , title = "Nutritional Disorders"
        , image = "/activities/pathology/nutritionalDisorders.webp"
        , level = 75
        , duration = Duration.seconds 5
        , knowledge = Just 9
        , type_ = "Study"
        }
    , principlesOfBioethics =
        { skill = MedicalEthics
        , title = "Principles of Bioethics"
        , image = "/activities/medicalEthics/principlesOfBioethics.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , informedConsent =
        { skill = MedicalEthics
        , title = "InformedConsent"
        , image = "/activities/medicalEthics/informedConsent.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , confidentialityAndPrivacy =
        { skill = MedicalEthics
        , title = "Confidentiality and Privacy"
        , image = "/activities/medicalEthics/confidentialityAndPrivacy.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , endOfLifeDecisionMaking =
        { skill = MedicalEthics
        , title = "End-of-Life Decision Making"
        , image = "/activities/medicalEthics/endOfLifeDecisionMaking.webp"
        , level = 20
        , duration = Duration.seconds 5
        , knowledge = Just 4
        , type_ = "Study"
        }
    , medicalProfessionalism =
        { skill = MedicalEthics
        , title = "Medical Professionalism"
        , image = "/activities/medicalEthics/medicalProfessionalism.webp"
        , level = 30
        , duration = Duration.seconds 5
        , knowledge = Just 5
        , type_ = "Study"
        }
    , researchEthics =
        { skill = MedicalEthics
        , title = "Research Ethics"
        , image = "/activities/medicalEthics/researchEthics.webp"
        , level = 45
        , duration = Duration.seconds 5
        , knowledge = Just 6
        , type_ = "Study"
        }
    , lab1 =
        { skill = Labs
        , title = "Lab 1"
        , image = "/activities/anatomy/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Nothing
        , type_ = "Lab"
        }
    , lab2 =
        { skill = Labs
        , title = "Lab 2"
        , image = "/activities/anatomy/backAndSpine.webp"
        , level = 2
        , duration = Duration.seconds 5
        , knowledge = Nothing
        , type_ = "Lab"
        }
    , lab3 =
        { skill = Labs
        , title = "Lab 3"
        , image = "/activities/anatomy/backAndSpine.webp"
        , level = 3
        , duration = Duration.seconds 5
        , knowledge = Nothing
        , type_ = "Lab"
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


allAcademicTests : List AcademicTest
allAcademicTests =
    [ Anatomy1, Anatomy2, Anatomy3, Anatomy4, Anatomy5 ]


type alias AcademicTestRecord a =
    { anatomy1 : a, anatomy2 : a, anatomy3 : a, anatomy4 : a, anatomy5 : a }


academicTestRecord : a -> AcademicTestRecord a
academicTestRecord a =
    { anatomy1 = a, anatomy2 = a, anatomy3 = a, anatomy4 = a, anatomy5 = a }


getByAcademicTest : AcademicTest -> AcademicTestRecord anatomy5 -> anatomy5
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
        , costs = [ { resource = AnatomyK, amount = 100 } ]
        , lockedBy = Nothing
        }
    , anatomy2 =
        { title = "Anatomy II"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 50)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 500 } ]
        , lockedBy = Just Anatomy1
        }
    , anatomy3 =
        { title = "Anatomy III"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 100)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 1000 } ]
        , lockedBy = Just Anatomy2
        }
    , anatomy4 =
        { title = "Anatomy IV"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 250)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 2000 } ]
        , lockedBy = Just Anatomy4
        }
    , anatomy5 =
        { title = "Anatomy V"
        , category = Quiz
        , rewardCoin = Just (IdleGame.Coin.int 500)
        , rewardResource = Nothing
        , costs = [ { resource = AnatomyK, amount = 3000 } ]
        , lockedBy = Just Anatomy4
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