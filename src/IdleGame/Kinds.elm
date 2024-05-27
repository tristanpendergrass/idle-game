module IdleGame.Kinds exposing (..)


{- !! Generated code, do not edit by hand !! -}


{- Resources -}


type Resource
    = AnatomyK
    | AnatomyPk
    | BiochemistryK
    | BiochemistryPk
    | PhysiologyK
    | PhysiologyPk
    | PharmacologyK
    | PharmacologyPk
    | MicrobiologyK
    | MicrobiologyPk
    | PathologyK
    | PathologyPk
    | MedicalEthicsK
    | MedicalEthicsPk


allResources : List Resource
allResources =
    [ AnatomyK
    , AnatomyPk
    , BiochemistryK
    , BiochemistryPk
    , PhysiologyK
    , PhysiologyPk
    , PharmacologyK
    , PharmacologyPk
    , MicrobiologyK
    , MicrobiologyPk
    , PathologyK
    , PathologyPk
    , MedicalEthicsK
    , MedicalEthicsPk
    ]


type alias ResourceRecord a =
    { anatomyK : a
    , anatomyPk : a
    , biochemistryK : a
    , biochemistryPk : a
    , physiologyK : a
    , physiologyPk : a
    , pharmacologyK : a
    , pharmacologyPk : a
    , microbiologyK : a
    , microbiologyPk : a
    , pathologyK : a
    , pathologyPk : a
    , medicalEthicsK : a
    , medicalEthicsPk : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { anatomyK = a
    , anatomyPk = a
    , biochemistryK = a
    , biochemistryPk = a
    , physiologyK = a
    , physiologyPk = a
    , pharmacologyK = a
    , pharmacologyPk = a
    , microbiologyK = a
    , microbiologyPk = a
    , pathologyK = a
    , pathologyPk = a
    , medicalEthicsK = a
    , medicalEthicsPk = a
    }


getByResource : Resource -> ResourceRecord medicalEthicsPk -> medicalEthicsPk
getByResource kind data =
    case kind of
        AnatomyK ->
            data.anatomyK

        AnatomyPk ->
            data.anatomyPk

        BiochemistryK ->
            data.biochemistryK

        BiochemistryPk ->
            data.biochemistryPk

        PhysiologyK ->
            data.physiologyK

        PhysiologyPk ->
            data.physiologyPk

        PharmacologyK ->
            data.pharmacologyK

        PharmacologyPk ->
            data.pharmacologyPk

        MicrobiologyK ->
            data.microbiologyK

        MicrobiologyPk ->
            data.microbiologyPk

        PathologyK ->
            data.pathologyK

        PathologyPk ->
            data.pathologyPk

        MedicalEthicsK ->
            data.medicalEthicsK

        MedicalEthicsPk ->
            data.medicalEthicsPk


setByResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByResource kind value data =
    case kind of
        AnatomyK ->
            { data | anatomyK = value }

        AnatomyPk ->
            { data | anatomyPk = value }

        BiochemistryK ->
            { data | biochemistryK = value }

        BiochemistryPk ->
            { data | biochemistryPk = value }

        PhysiologyK ->
            { data | physiologyK = value }

        PhysiologyPk ->
            { data | physiologyPk = value }

        PharmacologyK ->
            { data | pharmacologyK = value }

        PharmacologyPk ->
            { data | pharmacologyPk = value }

        MicrobiologyK ->
            { data | microbiologyK = value }

        MicrobiologyPk ->
            { data | microbiologyPk = value }

        PathologyK ->
            { data | pathologyK = value }

        PathologyPk ->
            { data | pathologyPk = value }

        MedicalEthicsK ->
            { data | medicalEthicsK = value }

        MedicalEthicsPk ->
            { data | medicalEthicsPk = value }


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


{- Activities -}


type Activity
    = BackAndSpine
    | UpperLimb
    | LowerLimb
    | MetabolicPathways
    | Enzymology
    | MolecularBiology
    | CellularPhysiology
    | CardiovascularPhysiology
    | RespiratoryPhysiology
    | Pharmacokinetics
    | Pharmacodynamics
    | Toxicology
    | Bacteriology
    | Virology
    | Mycology
    | CellInjury
    | Inflammation
    | HemodynamicDisorders
    | PrinciplesOfMedicalEthics
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
    , CellularPhysiology
    , CardiovascularPhysiology
    , RespiratoryPhysiology
    , Pharmacokinetics
    , Pharmacodynamics
    , Toxicology
    , Bacteriology
    , Virology
    , Mycology
    , CellInjury
    , Inflammation
    , HemodynamicDisorders
    , PrinciplesOfMedicalEthics
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
    , cellularPhysiology : a
    , cardiovascularPhysiology : a
    , respiratoryPhysiology : a
    , pharmacokinetics : a
    , pharmacodynamics : a
    , toxicology : a
    , bacteriology : a
    , virology : a
    , mycology : a
    , cellInjury : a
    , inflammation : a
    , hemodynamicDisorders : a
    , principlesOfMedicalEthics : a
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
    , cellularPhysiology = a
    , cardiovascularPhysiology = a
    , respiratoryPhysiology = a
    , pharmacokinetics = a
    , pharmacodynamics = a
    , toxicology = a
    , bacteriology = a
    , virology = a
    , mycology = a
    , cellInjury = a
    , inflammation = a
    , hemodynamicDisorders = a
    , principlesOfMedicalEthics = a
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

        CellularPhysiology ->
            data.cellularPhysiology

        CardiovascularPhysiology ->
            data.cardiovascularPhysiology

        RespiratoryPhysiology ->
            data.respiratoryPhysiology

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

        PrinciplesOfMedicalEthics ->
            data.principlesOfMedicalEthics

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

        CellularPhysiology ->
            { data | cellularPhysiology = value }

        CardiovascularPhysiology ->
            { data | cardiovascularPhysiology = value }

        RespiratoryPhysiology ->
            { data | respiratoryPhysiology = value }

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

        PrinciplesOfMedicalEthics ->
            { data | principlesOfMedicalEthics = value }

        InformedConsent ->
            { data | informedConsent = value }

        ConfidentialityAndPrivacy ->
            { data | confidentialityAndPrivacy = value }


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