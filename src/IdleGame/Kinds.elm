module IdleGame.Kinds exposing (..)

import Duration
import IdleGame.Views.Icon


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


type alias SkillStats =
    { title : String, icon : IdleGame.Views.Icon.Icon }


skillStats : SkillRecord SkillStats
skillStats =
    { anatomy =
        { title = "Anatomy"
        , icon = IdleGame.Views.Icon.createIconPublic "/subjects/anatomy.webp"
        }
    , biochemistry =
        { title = "Biochemistry"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/subjects/biochemistry.webp"
        }
    , physiology =
        { title = "Physiology"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/subjects/physiology.webp"
        }
    , pharmacology =
        { title = "Pharmacology"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/subjects/pharmacology.webp"
        }
    , microbiology =
        { title = "Microbiology"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/subjects/microbiology.webp"
        }
    , pathology =
        { title = "Pathology"
        , icon = IdleGame.Views.Icon.createIconPublic "/subjects/pathology.webp"
        }
    , medicalEthics =
        { title = "Medical Ethics"
        , icon =
            IdleGame.Views.Icon.createIconPublic "/subjects/medicalEthics.webp"
        }
    }


getSkillStats : Skill -> SkillStats
getSkillStats kind =
    case kind of
        Anatomy ->
            { title = "Anatomy"
            , icon =
                IdleGame.Views.Icon.createIconPublic "/subjects/anatomy.webp"
            }

        Biochemistry ->
            { title = "Biochemistry"
            , icon =
                IdleGame.Views.Icon.createIconPublic
                    "/subjects/biochemistry.webp"
            }

        Physiology ->
            { title = "Physiology"
            , icon =
                IdleGame.Views.Icon.createIconPublic "/subjects/physiology.webp"
            }

        Pharmacology ->
            { title = "Pharmacology"
            , icon =
                IdleGame.Views.Icon.createIconPublic
                    "/subjects/pharmacology.webp"
            }

        Microbiology ->
            { title = "Microbiology"
            , icon =
                IdleGame.Views.Icon.createIconPublic
                    "/subjects/microbiology.webp"
            }

        Pathology ->
            { title = "Pathology"
            , icon =
                IdleGame.Views.Icon.createIconPublic "/subjects/pathology.webp"
            }

        MedicalEthics ->
            { title = "Medical Ethics"
            , icon =
                IdleGame.Views.Icon.createIconPublic
                    "/subjects/medicalEthics.webp"
            }


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
    }


getByActivity :
    Activity -> ActivityRecord respiratorySystem -> respiratorySystem
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
        , image = "backAndSpine.png"
        , level = 1
        , duration = Duration.seconds 5
        , knowledge = 1
        , type_ = "Study"
        }
    , upperLimb =
        { subject = Anatomy
        , title = "Upper Limb"
        , image = "backAndSpine.png"
        , level = 5
        , duration = Duration.seconds 6
        , knowledge = 3
        , type_ = "Study"
        }
    , lowerLimb =
        { subject = Anatomy
        , title = "Lower Limb"
        , image = "backAndSpine.png"
        , level = 10
        , duration = Duration.seconds 7
        , knowledge = 4
        , type_ = "Study"
        }
    , metabolicPathways =
        { subject = Biochemistry
        , title = "Metabolic Pathways"
        , image = "backAndSpine.png"
        , level = 1
        , duration = Duration.seconds 7
        , knowledge = 1
        , type_ = "Study"
        }
    , enzymology =
        { subject = Biochemistry
        , title = "Enzymology"
        , image = "backAndSpine.png"
        , level = 8
        , duration = Duration.seconds 10
        , knowledge = 2
        , type_ = "Study"
        }
    , molecularBiology =
        { subject = Biochemistry
        , title = "Molecular Biology"
        , image = "backAndSpine.png"
        , level = 13
        , duration = Duration.seconds 11
        , knowledge = 3
        , type_ = "Study"
        }
    , cellularFunction =
        { subject = Physiology
        , title = "Cellular Function"
        , image = "backAndSpine.png"
        , level = 1
        , duration = Duration.seconds 4
        , knowledge = 4
        , type_ = "Study"
        }
    , cardiovascularSystem =
        { subject = Physiology
        , title = "Cardiovascular System"
        , image = "backAndSpine.png"
        , level = 5
        , duration = Duration.seconds 8
        , knowledge = 5
        , type_ = "Study"
        }
    , respiratorySystem =
        { subject = Physiology
        , title = "Respiratory System"
        , image = "backAndSpine.png"
        , level = 12
        , duration = Duration.seconds 6
        , knowledge = 6
        , type_ = "Study"
        }
    }


getActivityStats : Activity -> ActivityStats
getActivityStats kind =
    getByActivity kind activityStats


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