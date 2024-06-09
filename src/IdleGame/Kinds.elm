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


allSkills : List Skill
allSkills =
    [ Anatomy
    , Biochemistry
    , Physiology
    , Pharmacology
    , Microbiology
    , Pathology
    , MedicalEthics
    ]


type alias SkillRecord a =
    { anatomy : a
    , biochemistry : a
    , physiology : a
    , pharmacology : a
    , microbiology : a
    , pathology : a
    , medicalEthics : a
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
    }


getBySkill : Skill -> SkillRecord medicalEthics -> medicalEthics
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
    }


getSkillStats : Skill -> SkillStats
getSkillStats kind =
    getBySkill kind skillStats


{- Activities -}


type Activity
    = BackAndSpine
    | UpperLimb
    | LowerLimb
    | MetabolicPathways
    | Enzymology
    | MolecularBiology
    | CellularFunction
    | CardiovascularSystem
    | RespiratorySystem
    | Pharmacokinetics
    | Pharmacodynamics
    | Toxicology
    | Bacteriology
    | Virology
    | Mycology
    | CellInjury
    | Inflammation
    | HemodynamicDisorders
    | PrinciplesOfBiomedicalEthics
    | InformedConsent
    | ConfidentialityAndPrivacy


allActivities : List Activity
allActivities =
    [ BackAndSpine
    , UpperLimb
    , LowerLimb
    , MetabolicPathways
    , Enzymology
    , MolecularBiology
    , CellularFunction
    , CardiovascularSystem
    , RespiratorySystem
    , Pharmacokinetics
    , Pharmacodynamics
    , Toxicology
    , Bacteriology
    , Virology
    , Mycology
    , CellInjury
    , Inflammation
    , HemodynamicDisorders
    , PrinciplesOfBiomedicalEthics
    , InformedConsent
    , ConfidentialityAndPrivacy
    ]


type alias ActivityRecord a =
    { backAndSpine : a
    , upperLimb : a
    , lowerLimb : a
    , metabolicPathways : a
    , enzymology : a
    , molecularBiology : a
    , cellularFunction : a
    , cardiovascularSystem : a
    , respiratorySystem : a
    , pharmacokinetics : a
    , pharmacodynamics : a
    , toxicology : a
    , bacteriology : a
    , virology : a
    , mycology : a
    , cellInjury : a
    , inflammation : a
    , hemodynamicDisorders : a
    , principlesOfBiomedicalEthics : a
    , informedConsent : a
    , confidentialityAndPrivacy : a
    }


activityRecord : a -> ActivityRecord a
activityRecord a =
    { backAndSpine = a
    , upperLimb = a
    , lowerLimb = a
    , metabolicPathways = a
    , enzymology = a
    , molecularBiology = a
    , cellularFunction = a
    , cardiovascularSystem = a
    , respiratorySystem = a
    , pharmacokinetics = a
    , pharmacodynamics = a
    , toxicology = a
    , bacteriology = a
    , virology = a
    , mycology = a
    , cellInjury = a
    , inflammation = a
    , hemodynamicDisorders = a
    , principlesOfBiomedicalEthics = a
    , informedConsent = a
    , confidentialityAndPrivacy = a
    }


getByActivity :
    Activity
    -> ActivityRecord confidentialityAndPrivacy
    -> confidentialityAndPrivacy
getByActivity kind data =
    case kind of
        BackAndSpine ->
            data.backAndSpine

        UpperLimb ->
            data.upperLimb

        LowerLimb ->
            data.lowerLimb

        MetabolicPathways ->
            data.metabolicPathways

        Enzymology ->
            data.enzymology

        MolecularBiology ->
            data.molecularBiology

        CellularFunction ->
            data.cellularFunction

        CardiovascularSystem ->
            data.cardiovascularSystem

        RespiratorySystem ->
            data.respiratorySystem

        Pharmacokinetics ->
            data.pharmacokinetics

        Pharmacodynamics ->
            data.pharmacodynamics

        Toxicology ->
            data.toxicology

        Bacteriology ->
            data.bacteriology

        Virology ->
            data.virology

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

        MetabolicPathways ->
            { data | metabolicPathways = value }

        Enzymology ->
            { data | enzymology = value }

        MolecularBiology ->
            { data | molecularBiology = value }

        CellularFunction ->
            { data | cellularFunction = value }

        CardiovascularSystem ->
            { data | cardiovascularSystem = value }

        RespiratorySystem ->
            { data | respiratorySystem = value }

        Pharmacokinetics ->
            { data | pharmacokinetics = value }

        Pharmacodynamics ->
            { data | pharmacodynamics = value }

        Toxicology ->
            { data | toxicology = value }

        Bacteriology ->
            { data | bacteriology = value }

        Virology ->
            { data | virology = value }

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


type alias ActivityStats =
    { subject : Skill
    , title : String
    , image : String
    , level : Int
    , duration : Duration.Duration
    , knowledge : Int
    , type_ : String
    }


activityStats : ActivityRecord ActivityStats
activityStats =
    { backAndSpine =
        { subject = Anatomy
        , title = "Back and Spine"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , upperLimb =
        { subject = Anatomy
        , title = "Upper Limb"
        , image = "/activities/upperLimb.webp"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = 2
        , type_ = "Study"
        }
    , lowerLimb =
        { subject = Anatomy
        , title = "Lower Limb"
        , image = "/activities/lowerLimb.webp"
        , level = 10
        , duration = Duration.seconds 7
        , knowledge = 3
        , type_ = "Study"
        }
    , metabolicPathways =
        { subject = Biochemistry
        , title = "Metabolic Pathways"
        , image = "/activities/metabolicPathways.webp"
        , level = 1
        , duration = Duration.seconds 7
        , knowledge = 1
        , type_ = "Study"
        }
    , enzymology =
        { subject = Biochemistry
        , title = "Enzymology"
        , image = "/activities/enzymology.webp"
        , level = 8
        , duration = Duration.seconds 10
        , knowledge = 2
        , type_ = "Study"
        }
    , molecularBiology =
        { subject = Biochemistry
        , title = "Molecular Biology"
        , image = "/activities/molecularBiology.webp"
        , level = 13
        , duration = Duration.seconds 11
        , knowledge = 3
        , type_ = "Study"
        }
    , cellularFunction =
        { subject = Physiology
        , title = "Cellular Function"
        , image = "/activities/cellularFunction.webp"
        , level = 1
        , duration = Duration.seconds 4
        , knowledge = 1
        , type_ = "Study"
        }
    , cardiovascularSystem =
        { subject = Physiology
        , title = "Cardiovascular System"
        , image = "/activities/cardiovascularSystem.webp"
        , level = 5
        , duration = Duration.seconds 8
        , knowledge = 2
        , type_ = "Study"
        }
    , respiratorySystem =
        { subject = Physiology
        , title = "Respiratory System"
        , image = "/activities/respiratorySystem.webp"
        , level = 12
        , duration = Duration.seconds 6
        , knowledge = 3
        , type_ = "Study"
        }
    , pharmacokinetics =
        { subject = Pharmacology
        , title = "Pharmacokinetics"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , pharmacodynamics =
        { subject = Pharmacology
        , title = "Pharmacodynamics"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = 2
        , type_ = "Study"
        }
    , toxicology =
        { subject = Pharmacology
        , title = "Toxicology"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = 3
        , type_ = "Study"
        }
    , bacteriology =
        { subject = Microbiology
        , title = "Bacteriology"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , virology =
        { subject = Microbiology
        , title = "Virology"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = 2
        , type_ = "Study"
        }
    , mycology =
        { subject = Microbiology
        , title = "Mycology"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = 3
        , type_ = "Study"
        }
    , cellInjury =
        { subject = Pathology
        , title = "Cell Injury and Adaptation"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , inflammation =
        { subject = Pathology
        , title = "Inflammation and Repair"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = 2
        , type_ = "Study"
        }
    , hemodynamicDisorders =
        { subject = Pathology
        , title = "Hemodynamic Disorders"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = 3
        , type_ = "Study"
        }
    , principlesOfBiomedicalEthics =
        { subject = MedicalEthics
        , title = "Principles of Biomedical Ethics"
        , image = "/activities/backAndSpine.webp"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , informedConsent =
        { subject = MedicalEthics
        , title = "InformedConsent"
        , image = "/activities/backAndSpine.webp"
        , level = 5
        , duration = Duration.seconds 5
        , knowledge = 2
        , type_ = "Study"
        }
    , confidentialityAndPrivacy =
        { subject = MedicalEthics
        , title = "Confidentiality and Privacy"
        , image = "/activities/backAndSpine.webp"
        , level = 10
        , duration = Duration.seconds 5
        , knowledge = 3
        , type_ = "Study"
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