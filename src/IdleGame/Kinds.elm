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
    , pathology = { title = "Pathology", icon = IdleGame.Views.Icon.summarize }
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
    | Mycology
    | CellInjury
    | Inflammation
    | HemodynamicDisorders
    | PrinciplesOfBiomedicalEthics
    | InformedConsent
    | ConfidentialityAndPrivacy
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
    , Mycology
    , CellInjury
    , Inflammation
    , HemodynamicDisorders
    , PrinciplesOfBiomedicalEthics
    , InformedConsent
    , ConfidentialityAndPrivacy
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
    , mycology : a
    , cellInjury : a
    , inflammation : a
    , hemodynamicDisorders : a
    , principlesOfBiomedicalEthics : a
    , informedConsent : a
    , confidentialityAndPrivacy : a
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
    , mycology = a
    , cellInjury = a
    , inflammation = a
    , hemodynamicDisorders = a
    , principlesOfBiomedicalEthics = a
    , informedConsent = a
    , confidentialityAndPrivacy = a
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

        Mycology ->
            data.mycology

        CellInjury ->
            data.cellInjury

        Inflammation ->
            data.inflammation

        HemodynamicDisorders ->
            data.hemodynamicDisorders

        PrinciplesOfBiomedicalEthics ->
            data.principlesOfBiomedicalEthics

        InformedConsent ->
            data.informedConsent

        ConfidentialityAndPrivacy ->
            data.confidentialityAndPrivacy

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

        Mycology ->
            { data | mycology = value }

        CellInjury ->
            { data | cellInjury = value }

        Inflammation ->
            { data | inflammation = value }

        HemodynamicDisorders ->
            { data | hemodynamicDisorders = value }

        PrinciplesOfBiomedicalEthics ->
            { data | principlesOfBiomedicalEthics = value }

        InformedConsent ->
            { data | informedConsent = value }

        ConfidentialityAndPrivacy ->
            { data | confidentialityAndPrivacy = value }

        Lab1 ->
            { data | lab1 = value }

        Lab2 ->
            { data | lab2 = value }

        Lab3 ->
            { data | lab3 = value }


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
    , mycology =
        { skill = Microbiology
        , title = "Mycology"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , cellInjury =
        { skill = Pathology
        , title = "Cell Injury and Adaptation"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , inflammation =
        { skill = Pathology
        , title = "Inflammation and Repair"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , hemodynamicDisorders =
        { skill = Pathology
        , title = "Hemodynamic Disorders"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , principlesOfBiomedicalEthics =
        { skill = MedicalEthics
        , title = "Principles of Biomedical Ethics"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Just 1
        , type_ = "Study"
        }
    , informedConsent =
        { skill = MedicalEthics
        , title = "InformedConsent"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = Just 2
        , type_ = "Study"
        }
    , confidentialityAndPrivacy =
        { skill = MedicalEthics
        , title = "Confidentiality and Privacy"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = Just 3
        , type_ = "Study"
        }
    , lab1 =
        { skill = Labs
        , title = "Lab 1"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = Nothing
        , type_ = "Lab"
        }
    , lab2 =
        { skill = Labs
        , title = "Lab 2"
        , image = "/activities/backAndSpine.webp"
        , level = 2
        , duration = Duration.seconds 5
        , knowledge = Nothing
        , type_ = "Lab"
        }
    , lab3 =
        { skill = Labs
        , title = "Lab 3"
        , image = "/activities/backAndSpine.webp"
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
    | BiochemistryK
    | PhysiologyK
    | PharmacologyK
    | MicrobiologyK
    | PathologyK
    | MedicalEthicsK


allResources : List Resource
allResources =
    [ AnatomyK
    , BiochemistryK
    , PhysiologyK
    , PharmacologyK
    , MicrobiologyK
    , PathologyK
    , MedicalEthicsK
    ]


type alias ResourceRecord a =
    { anatomyK : a
    , biochemistryK : a
    , physiologyK : a
    , pharmacologyK : a
    , microbiologyK : a
    , pathologyK : a
    , medicalEthicsK : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { anatomyK = a
    , biochemistryK = a
    , physiologyK = a
    , pharmacologyK = a
    , microbiologyK = a
    , pathologyK = a
    , medicalEthicsK = a
    }


getByResource : Resource -> ResourceRecord medicalEthicsK -> medicalEthicsK
getByResource kind data =
    case kind of
        AnatomyK ->
            data.anatomyK

        BiochemistryK ->
            data.biochemistryK

        PhysiologyK ->
            data.physiologyK

        PharmacologyK ->
            data.pharmacologyK

        MicrobiologyK ->
            data.microbiologyK

        PathologyK ->
            data.pathologyK

        MedicalEthicsK ->
            data.medicalEthicsK


setByResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByResource kind value data =
    case kind of
        AnatomyK ->
            { data | anatomyK = value }

        BiochemistryK ->
            { data | biochemistryK = value }

        PhysiologyK ->
            { data | physiologyK = value }

        PharmacologyK ->
            { data | pharmacologyK = value }

        MicrobiologyK ->
            { data | microbiologyK = value }

        PathologyK ->
            { data | pathologyK = value }

        MedicalEthicsK ->
            { data | medicalEthicsK = value }


type alias ResourceStats =
    { title : String
    , icon : IdleGame.Views.Icon.Icon
    , price : Maybe IdleGame.Coin.Coin
    }


resourceStats : ResourceRecord ResourceStats
resourceStats =
    { anatomyK =
        { title = "Knowledge (Anatomy)"
        , icon = IdleGame.Views.Icon.createIconPublic "/resources/anatomy_k.png"
        , price = Just (IdleGame.Coin.int 10)
        }
    , biochemistryK =
        { title = "Knowledge (Biochemistry)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/biochemistry_k.png"
        , price = Nothing
        }
    , physiologyK =
        { title = "Knowledge (Physiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/physiology_k.png"
        , price = Nothing
        }
    , pharmacologyK =
        { title = "Knowledge (Pharmacology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pharmacology_k.png"
        , price = Nothing
        }
    , microbiologyK =
        { title = "Knowledge (Microbiology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/microbiology_k.png"
        , price = Nothing
        }
    , pathologyK =
        { title = "Knowledge (Pathology)"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/resources/pathology_k.png"
        , price = Nothing
        }
    , medicalEthicsK =
        { title = "Knowledge (Medical Ethics)"
        , icon =
            IdleGame.Views.Icon.createIconPublic
                "/resources/medical_ethics_k.png"
        , price = Nothing
        }
    }


getResourceStats : Resource -> ResourceStats
getResourceStats kind =
    getByResource kind resourceStats


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