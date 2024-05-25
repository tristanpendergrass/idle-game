module IdleGame.Kinds exposing (..)


{- !! Generated code, do not edit by hand !! -}


{- Resources -}


type Resource
    = Knowledge


allResources : List Resource
allResources =
    [ Knowledge ]


type alias ResourceRecord a =
    { knowledge : a }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { knowledge = a }


getByResource : Resource -> ResourceRecord knowledge -> knowledge
getByResource kind data =
    case kind of
        Knowledge ->
            data.knowledge


setByResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByResource kind value data =
    case kind of
        Knowledge ->
            { data | knowledge = value }


{- Skills -}


type Skill
    = Anatomy
    | MedicalEthics


allSkills : List Skill
allSkills =
    [ Anatomy, MedicalEthics ]


type alias SkillRecord a =
    { anatomy : a, medicalEthics : a }


skillRecord : a -> SkillRecord a
skillRecord a =
    { anatomy = a, medicalEthics = a }


getBySkill : Skill -> SkillRecord medicalEthics -> medicalEthics
getBySkill kind data =
    case kind of
        Anatomy ->
            data.anatomy

        MedicalEthics ->
            data.medicalEthics


setBySkill : Skill -> value -> SkillRecord value -> SkillRecord value
setBySkill kind value data =
    case kind of
        Anatomy ->
            { data | anatomy = value }

        MedicalEthics ->
            { data | medicalEthics = value }


{- Activities -}


type Activity
    = GrossAnatomy
    | Neuroanatomy


allActivities : List Activity
allActivities =
    [ GrossAnatomy, Neuroanatomy ]


type alias ActivityRecord a =
    { grossAnatomy : a, neuroanatomy : a }


activityRecord : a -> ActivityRecord a
activityRecord a =
    { grossAnatomy = a, neuroanatomy = a }


getByActivity : Activity -> ActivityRecord neuroanatomy -> neuroanatomy
getByActivity kind data =
    case kind of
        GrossAnatomy ->
            data.grossAnatomy

        Neuroanatomy ->
            data.neuroanatomy


setByActivity :
    Activity -> value -> ActivityRecord value -> ActivityRecord value
setByActivity kind value data =
    case kind of
        GrossAnatomy ->
            { data | grossAnatomy = value }

        Neuroanatomy ->
            { data | neuroanatomy = value }


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