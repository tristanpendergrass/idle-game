module Gen.IdleGame.Kinds exposing (activityRecord, activityStats, allActivities, allResources, allShopUpgrades, allSkills, annotation_, call_, caseOf_, getActivityStats, getByActivity, getByResource, getByShopUpgrade, getBySkill, getSkillStats, make_, moduleName_, resourceRecord, setByActivity, setByResource, setByShopUpgrade, setBySkill, shopUpgradeRecord, skillRecord, skillStats, values_)

{-| 
@docs moduleName_, setByShopUpgrade, getByShopUpgrade, shopUpgradeRecord, allShopUpgrades, getActivityStats, activityStats, setByActivity, getByActivity, activityRecord, allActivities, getSkillStats, skillStats, setBySkill, getBySkill, skillRecord, allSkills, setByResource, getByResource, resourceRecord, allResources, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Kinds" ]


{-| setByShopUpgrade: 
    IdleGame.Kinds.ShopUpgrade
    -> value
    -> IdleGame.Kinds.ShopUpgradeRecord value
    -> IdleGame.Kinds.ShopUpgradeRecord value
-}
setByShopUpgrade :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
setByShopUpgrade setByShopUpgradeArg setByShopUpgradeArg0 setByShopUpgradeArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "setByShopUpgrade"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgrade"
                              []
                          , Type.var "value"
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ShopUpgradeRecord"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ setByShopUpgradeArg, setByShopUpgradeArg0, setByShopUpgradeArg1 ]


{-| getByShopUpgrade: 
    IdleGame.Kinds.ShopUpgrade
    -> IdleGame.Kinds.ShopUpgradeRecord glasses
    -> glasses
-}
getByShopUpgrade : Elm.Expression -> Elm.Expression -> Elm.Expression
getByShopUpgrade getByShopUpgradeArg getByShopUpgradeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getByShopUpgrade"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgrade"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "glasses" ]
                          ]
                          (Type.var "glasses")
                     )
             }
        )
        [ getByShopUpgradeArg, getByShopUpgradeArg0 ]


{-| shopUpgradeRecord: a -> IdleGame.Kinds.ShopUpgradeRecord a -}
shopUpgradeRecord : Elm.Expression -> Elm.Expression
shopUpgradeRecord shopUpgradeRecordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "shopUpgradeRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ShopUpgradeRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ shopUpgradeRecordArg ]


{-| allShopUpgrades: List IdleGame.Kinds.ShopUpgrade -}
allShopUpgrades : Elm.Expression
allShopUpgrades =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "allShopUpgrades"
        , annotation =
            Just
                (Type.list
                     (Type.namedWith [ "IdleGame", "Kinds" ] "ShopUpgrade" [])
                )
        }


{-| getActivityStats: IdleGame.Kinds.Activity -> IdleGame.Kinds.ActivityStats -}
getActivityStats : Elm.Expression -> Elm.Expression
getActivityStats getActivityStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getActivityStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ActivityStats"
                               []
                          )
                     )
             }
        )
        [ getActivityStatsArg ]


{-| activityStats: IdleGame.Kinds.ActivityRecord IdleGame.Kinds.ActivityStats -}
activityStats : Elm.Expression
activityStats =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "activityStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Kinds" ]
                     "ActivityRecord"
                     [ Type.namedWith [ "IdleGame", "Kinds" ] "ActivityStats" []
                     ]
                )
        }


{-| setByActivity: 
    IdleGame.Kinds.Activity
    -> value
    -> IdleGame.Kinds.ActivityRecord value
    -> IdleGame.Kinds.ActivityRecord value
-}
setByActivity :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
setByActivity setByActivityArg setByActivityArg0 setByActivityArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "setByActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                          , Type.var "value"
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ActivityRecord"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ setByActivityArg, setByActivityArg0, setByActivityArg1 ]


{-| getByActivity: 
    IdleGame.Kinds.Activity
    -> IdleGame.Kinds.ActivityRecord respiratorySystem
    -> respiratorySystem
-}
getByActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
getByActivity getByActivityArg getByActivityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getByActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "respiratorySystem" ]
                          ]
                          (Type.var "respiratorySystem")
                     )
             }
        )
        [ getByActivityArg, getByActivityArg0 ]


{-| activityRecord: a -> IdleGame.Kinds.ActivityRecord a -}
activityRecord : Elm.Expression -> Elm.Expression
activityRecord activityRecordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "activityRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ActivityRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ activityRecordArg ]


{-| allActivities: List IdleGame.Kinds.Activity -}
allActivities : Elm.Expression
allActivities =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "allActivities"
        , annotation =
            Just
                (Type.list
                     (Type.namedWith [ "IdleGame", "Kinds" ] "Activity" [])
                )
        }


{-| getSkillStats: IdleGame.Kinds.Skill -> IdleGame.Kinds.SkillStats -}
getSkillStats : Elm.Expression -> Elm.Expression
getSkillStats getSkillStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getSkillStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" [] ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "SkillStats"
                               []
                          )
                     )
             }
        )
        [ getSkillStatsArg ]


{-| skillStats: IdleGame.Kinds.SkillRecord IdleGame.Kinds.SkillStats -}
skillStats : Elm.Expression
skillStats =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "skillStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Kinds" ]
                     "SkillRecord"
                     [ Type.namedWith [ "IdleGame", "Kinds" ] "SkillStats" [] ]
                )
        }


{-| setBySkill: 
    IdleGame.Kinds.Skill
    -> value
    -> IdleGame.Kinds.SkillRecord value
    -> IdleGame.Kinds.SkillRecord value
-}
setBySkill :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
setBySkill setBySkillArg setBySkillArg0 setBySkillArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "setBySkill"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                          , Type.var "value"
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "SkillRecord"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ setBySkillArg, setBySkillArg0, setBySkillArg1 ]


{-| getBySkill: 
    IdleGame.Kinds.Skill
    -> IdleGame.Kinds.SkillRecord medicalEthics
    -> medicalEthics
-}
getBySkill : Elm.Expression -> Elm.Expression -> Elm.Expression
getBySkill getBySkillArg getBySkillArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getBySkill"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "medicalEthics" ]
                          ]
                          (Type.var "medicalEthics")
                     )
             }
        )
        [ getBySkillArg, getBySkillArg0 ]


{-| skillRecord: a -> IdleGame.Kinds.SkillRecord a -}
skillRecord : Elm.Expression -> Elm.Expression
skillRecord skillRecordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "skillRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "SkillRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ skillRecordArg ]


{-| allSkills: List IdleGame.Kinds.Skill -}
allSkills : Elm.Expression
allSkills =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "allSkills"
        , annotation =
            Just (Type.list (Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []))
        }


{-| setByResource: 
    IdleGame.Kinds.Resource
    -> value
    -> IdleGame.Kinds.ResourceRecord value
    -> IdleGame.Kinds.ResourceRecord value
-}
setByResource :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
setByResource setByResourceArg setByResourceArg0 setByResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "setByResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                          , Type.var "value"
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ResourceRecord"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ setByResourceArg, setByResourceArg0, setByResourceArg1 ]


{-| getByResource: 
    IdleGame.Kinds.Resource
    -> IdleGame.Kinds.ResourceRecord medicalEthicsPk
    -> medicalEthicsPk
-}
getByResource : Elm.Expression -> Elm.Expression -> Elm.Expression
getByResource getByResourceArg getByResourceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getByResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "medicalEthicsPk" ]
                          ]
                          (Type.var "medicalEthicsPk")
                     )
             }
        )
        [ getByResourceArg, getByResourceArg0 ]


{-| resourceRecord: a -> IdleGame.Kinds.ResourceRecord a -}
resourceRecord : Elm.Expression -> Elm.Expression
resourceRecord resourceRecordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "resourceRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ResourceRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ resourceRecordArg ]


{-| allResources: List IdleGame.Kinds.Resource -}
allResources : Elm.Expression
allResources =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "allResources"
        , annotation =
            Just
                (Type.list
                     (Type.namedWith [ "IdleGame", "Kinds" ] "Resource" [])
                )
        }


annotation_ :
    { shopUpgradeRecord : Type.Annotation -> Type.Annotation
    , activityStats : Type.Annotation
    , activityRecord : Type.Annotation -> Type.Annotation
    , skillStats : Type.Annotation
    , skillRecord : Type.Annotation -> Type.Annotation
    , resourceRecord : Type.Annotation -> Type.Annotation
    , shopUpgrade : Type.Annotation
    , activity : Type.Annotation
    , skill : Type.Annotation
    , resource : Type.Annotation
    }
annotation_ =
    { shopUpgradeRecord =
        \shopUpgradeRecordArg0 ->
            Type.alias
                moduleName_
                "ShopUpgradeRecord"
                [ shopUpgradeRecordArg0 ]
                (Type.record [ ( "glasses", Type.var "a" ) ])
    , activityStats =
        Type.alias
            moduleName_
            "ActivityStats"
            []
            (Type.record
                 [ ( "subject"
                   , Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                   )
                 , ( "title", Type.string )
                 , ( "image", Type.string )
                 , ( "level", Type.int )
                 , ( "duration", Type.namedWith [ "Duration" ] "Duration" [] )
                 , ( "knowledge", Type.int )
                 , ( "type_", Type.string )
                 ]
            )
    , activityRecord =
        \activityRecordArg0 ->
            Type.alias
                moduleName_
                "ActivityRecord"
                [ activityRecordArg0 ]
                (Type.record
                     [ ( "backAndSpine", Type.var "a" )
                     , ( "upperLimb", Type.var "a" )
                     , ( "lowerLimb", Type.var "a" )
                     , ( "metabolicPathways", Type.var "a" )
                     , ( "enzymology", Type.var "a" )
                     , ( "molecularBiology", Type.var "a" )
                     , ( "cellularFunction", Type.var "a" )
                     , ( "cardiovascularSystem", Type.var "a" )
                     , ( "respiratorySystem", Type.var "a" )
                     ]
                )
    , skillStats =
        Type.alias
            moduleName_
            "SkillStats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 ]
            )
    , skillRecord =
        \skillRecordArg0 ->
            Type.alias
                moduleName_
                "SkillRecord"
                [ skillRecordArg0 ]
                (Type.record
                     [ ( "anatomy", Type.var "a" )
                     , ( "biochemistry", Type.var "a" )
                     , ( "physiology", Type.var "a" )
                     , ( "pharmacology", Type.var "a" )
                     , ( "microbiology", Type.var "a" )
                     , ( "pathology", Type.var "a" )
                     , ( "medicalEthics", Type.var "a" )
                     ]
                )
    , resourceRecord =
        \resourceRecordArg0 ->
            Type.alias
                moduleName_
                "ResourceRecord"
                [ resourceRecordArg0 ]
                (Type.record
                     [ ( "anatomyK", Type.var "a" )
                     , ( "anatomyPk", Type.var "a" )
                     , ( "biochemistryK", Type.var "a" )
                     , ( "biochemistryPk", Type.var "a" )
                     , ( "physiologyK", Type.var "a" )
                     , ( "physiologyPk", Type.var "a" )
                     , ( "pharmacologyK", Type.var "a" )
                     , ( "pharmacologyPk", Type.var "a" )
                     , ( "microbiologyK", Type.var "a" )
                     , ( "microbiologyPk", Type.var "a" )
                     , ( "pathologyK", Type.var "a" )
                     , ( "pathologyPk", Type.var "a" )
                     , ( "medicalEthicsK", Type.var "a" )
                     , ( "medicalEthicsPk", Type.var "a" )
                     ]
                )
    , shopUpgrade = Type.namedWith [ "IdleGame", "Kinds" ] "ShopUpgrade" []
    , activity = Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
    , skill = Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
    , resource = Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
    }


make_ :
    { shopUpgradeRecord : { glasses : Elm.Expression } -> Elm.Expression
    , activityStats :
        { subject : Elm.Expression
        , title : Elm.Expression
        , image : Elm.Expression
        , level : Elm.Expression
        , duration : Elm.Expression
        , knowledge : Elm.Expression
        , type_ : Elm.Expression
        }
        -> Elm.Expression
    , activityRecord :
        { backAndSpine : Elm.Expression
        , upperLimb : Elm.Expression
        , lowerLimb : Elm.Expression
        , metabolicPathways : Elm.Expression
        , enzymology : Elm.Expression
        , molecularBiology : Elm.Expression
        , cellularFunction : Elm.Expression
        , cardiovascularSystem : Elm.Expression
        , respiratorySystem : Elm.Expression
        }
        -> Elm.Expression
    , skillStats :
        { title : Elm.Expression, icon : Elm.Expression } -> Elm.Expression
    , skillRecord :
        { anatomy : Elm.Expression
        , biochemistry : Elm.Expression
        , physiology : Elm.Expression
        , pharmacology : Elm.Expression
        , microbiology : Elm.Expression
        , pathology : Elm.Expression
        , medicalEthics : Elm.Expression
        }
        -> Elm.Expression
    , resourceRecord :
        { anatomyK : Elm.Expression
        , anatomyPk : Elm.Expression
        , biochemistryK : Elm.Expression
        , biochemistryPk : Elm.Expression
        , physiologyK : Elm.Expression
        , physiologyPk : Elm.Expression
        , pharmacologyK : Elm.Expression
        , pharmacologyPk : Elm.Expression
        , microbiologyK : Elm.Expression
        , microbiologyPk : Elm.Expression
        , pathologyK : Elm.Expression
        , pathologyPk : Elm.Expression
        , medicalEthicsK : Elm.Expression
        , medicalEthicsPk : Elm.Expression
        }
        -> Elm.Expression
    , glasses : Elm.Expression
    , backAndSpine : Elm.Expression
    , upperLimb : Elm.Expression
    , lowerLimb : Elm.Expression
    , metabolicPathways : Elm.Expression
    , enzymology : Elm.Expression
    , molecularBiology : Elm.Expression
    , cellularFunction : Elm.Expression
    , cardiovascularSystem : Elm.Expression
    , respiratorySystem : Elm.Expression
    , anatomy : Elm.Expression
    , biochemistry : Elm.Expression
    , physiology : Elm.Expression
    , pharmacology : Elm.Expression
    , microbiology : Elm.Expression
    , pathology : Elm.Expression
    , medicalEthics : Elm.Expression
    , anatomyK : Elm.Expression
    , anatomyPk : Elm.Expression
    , biochemistryK : Elm.Expression
    , biochemistryPk : Elm.Expression
    , physiologyK : Elm.Expression
    , physiologyPk : Elm.Expression
    , pharmacologyK : Elm.Expression
    , pharmacologyPk : Elm.Expression
    , microbiologyK : Elm.Expression
    , microbiologyPk : Elm.Expression
    , pathologyK : Elm.Expression
    , pathologyPk : Elm.Expression
    , medicalEthicsK : Elm.Expression
    , medicalEthicsPk : Elm.Expression
    }
make_ =
    { shopUpgradeRecord =
        \shopUpgradeRecord_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ShopUpgradeRecord"
                     [ Type.var "a" ]
                     (Type.record [ ( "glasses", Type.var "a" ) ])
                )
                (Elm.record
                     [ Tuple.pair "glasses" shopUpgradeRecord_args.glasses ]
                )
    , activityStats =
        \activityStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ActivityStats"
                     []
                     (Type.record
                          [ ( "subject"
                            , Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                            )
                          , ( "title", Type.string )
                          , ( "image", Type.string )
                          , ( "level", Type.int )
                          , ( "duration"
                            , Type.namedWith [ "Duration" ] "Duration" []
                            )
                          , ( "knowledge", Type.int )
                          , ( "type_", Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "subject" activityStats_args.subject
                     , Tuple.pair "title" activityStats_args.title
                     , Tuple.pair "image" activityStats_args.image
                     , Tuple.pair "level" activityStats_args.level
                     , Tuple.pair "duration" activityStats_args.duration
                     , Tuple.pair "knowledge" activityStats_args.knowledge
                     , Tuple.pair "type_" activityStats_args.type_
                     ]
                )
    , activityRecord =
        \activityRecord_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ActivityRecord"
                     [ Type.var "a" ]
                     (Type.record
                          [ ( "backAndSpine", Type.var "a" )
                          , ( "upperLimb", Type.var "a" )
                          , ( "lowerLimb", Type.var "a" )
                          , ( "metabolicPathways", Type.var "a" )
                          , ( "enzymology", Type.var "a" )
                          , ( "molecularBiology", Type.var "a" )
                          , ( "cellularFunction", Type.var "a" )
                          , ( "cardiovascularSystem", Type.var "a" )
                          , ( "respiratorySystem", Type.var "a" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "backAndSpine"
                         activityRecord_args.backAndSpine
                     , Tuple.pair "upperLimb" activityRecord_args.upperLimb
                     , Tuple.pair "lowerLimb" activityRecord_args.lowerLimb
                     , Tuple.pair
                         "metabolicPathways"
                         activityRecord_args.metabolicPathways
                     , Tuple.pair "enzymology" activityRecord_args.enzymology
                     , Tuple.pair
                         "molecularBiology"
                         activityRecord_args.molecularBiology
                     , Tuple.pair
                         "cellularFunction"
                         activityRecord_args.cellularFunction
                     , Tuple.pair
                         "cardiovascularSystem"
                         activityRecord_args.cardiovascularSystem
                     , Tuple.pair
                         "respiratorySystem"
                         activityRecord_args.respiratorySystem
                     ]
                )
    , skillStats =
        \skillStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "SkillStats"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "icon"
                            , Type.namedWith
                                  [ "IdleGame", "Views", "Icon" ]
                                  "Icon"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" skillStats_args.title
                     , Tuple.pair "icon" skillStats_args.icon
                     ]
                )
    , skillRecord =
        \skillRecord_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "SkillRecord"
                     [ Type.var "a" ]
                     (Type.record
                          [ ( "anatomy", Type.var "a" )
                          , ( "biochemistry", Type.var "a" )
                          , ( "physiology", Type.var "a" )
                          , ( "pharmacology", Type.var "a" )
                          , ( "microbiology", Type.var "a" )
                          , ( "pathology", Type.var "a" )
                          , ( "medicalEthics", Type.var "a" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "anatomy" skillRecord_args.anatomy
                     , Tuple.pair "biochemistry" skillRecord_args.biochemistry
                     , Tuple.pair "physiology" skillRecord_args.physiology
                     , Tuple.pair "pharmacology" skillRecord_args.pharmacology
                     , Tuple.pair "microbiology" skillRecord_args.microbiology
                     , Tuple.pair "pathology" skillRecord_args.pathology
                     , Tuple.pair "medicalEthics" skillRecord_args.medicalEthics
                     ]
                )
    , resourceRecord =
        \resourceRecord_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ResourceRecord"
                     [ Type.var "a" ]
                     (Type.record
                          [ ( "anatomyK", Type.var "a" )
                          , ( "anatomyPk", Type.var "a" )
                          , ( "biochemistryK", Type.var "a" )
                          , ( "biochemistryPk", Type.var "a" )
                          , ( "physiologyK", Type.var "a" )
                          , ( "physiologyPk", Type.var "a" )
                          , ( "pharmacologyK", Type.var "a" )
                          , ( "pharmacologyPk", Type.var "a" )
                          , ( "microbiologyK", Type.var "a" )
                          , ( "microbiologyPk", Type.var "a" )
                          , ( "pathologyK", Type.var "a" )
                          , ( "pathologyPk", Type.var "a" )
                          , ( "medicalEthicsK", Type.var "a" )
                          , ( "medicalEthicsPk", Type.var "a" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "anatomyK" resourceRecord_args.anatomyK
                     , Tuple.pair "anatomyPk" resourceRecord_args.anatomyPk
                     , Tuple.pair
                         "biochemistryK"
                         resourceRecord_args.biochemistryK
                     , Tuple.pair
                         "biochemistryPk"
                         resourceRecord_args.biochemistryPk
                     , Tuple.pair "physiologyK" resourceRecord_args.physiologyK
                     , Tuple.pair
                         "physiologyPk"
                         resourceRecord_args.physiologyPk
                     , Tuple.pair
                         "pharmacologyK"
                         resourceRecord_args.pharmacologyK
                     , Tuple.pair
                         "pharmacologyPk"
                         resourceRecord_args.pharmacologyPk
                     , Tuple.pair
                         "microbiologyK"
                         resourceRecord_args.microbiologyK
                     , Tuple.pair
                         "microbiologyPk"
                         resourceRecord_args.microbiologyPk
                     , Tuple.pair "pathologyK" resourceRecord_args.pathologyK
                     , Tuple.pair "pathologyPk" resourceRecord_args.pathologyPk
                     , Tuple.pair
                         "medicalEthicsK"
                         resourceRecord_args.medicalEthicsK
                     , Tuple.pair
                         "medicalEthicsPk"
                         resourceRecord_args.medicalEthicsPk
                     ]
                )
    , glasses =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Glasses"
            , annotation = Just (Type.namedWith [] "ShopUpgrade" [])
            }
    , backAndSpine =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BackAndSpine"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , upperLimb =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "UpperLimb"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , lowerLimb =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "LowerLimb"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , metabolicPathways =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MetabolicPathways"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , enzymology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Enzymology"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , molecularBiology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MolecularBiology"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , cellularFunction =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "CellularFunction"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , cardiovascularSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "CardiovascularSystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , respiratorySystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "RespiratorySystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , anatomy =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Anatomy"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , biochemistry =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Biochemistry"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , physiology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Physiology"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , pharmacology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Pharmacology"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , microbiology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Microbiology"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , pathology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Pathology"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , medicalEthics =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthics"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    , anatomyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "AnatomyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , anatomyPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "AnatomyPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , biochemistryK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemistryK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , biochemistryPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemistryPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , physiologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PhysiologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , physiologyPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PhysiologyPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pharmacologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PharmacologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pharmacologyPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PharmacologyPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , microbiologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MicrobiologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , microbiologyPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MicrobiologyPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pathologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PathologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pathologyPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PathologyPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , medicalEthicsK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthicsK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , medicalEthicsPk =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthicsPk"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    }


caseOf_ :
    { shopUpgrade :
        Elm.Expression
        -> { shopUpgradeTags_0_0 | glasses : Elm.Expression }
        -> Elm.Expression
    , activity :
        Elm.Expression
        -> { activityTags_1_0
            | backAndSpine : Elm.Expression
            , upperLimb : Elm.Expression
            , lowerLimb : Elm.Expression
            , metabolicPathways : Elm.Expression
            , enzymology : Elm.Expression
            , molecularBiology : Elm.Expression
            , cellularFunction : Elm.Expression
            , cardiovascularSystem : Elm.Expression
            , respiratorySystem : Elm.Expression
        }
        -> Elm.Expression
    , skill :
        Elm.Expression
        -> { skillTags_2_0
            | anatomy : Elm.Expression
            , biochemistry : Elm.Expression
            , physiology : Elm.Expression
            , pharmacology : Elm.Expression
            , microbiology : Elm.Expression
            , pathology : Elm.Expression
            , medicalEthics : Elm.Expression
        }
        -> Elm.Expression
    , resource :
        Elm.Expression
        -> { resourceTags_3_0
            | anatomyK : Elm.Expression
            , anatomyPk : Elm.Expression
            , biochemistryK : Elm.Expression
            , biochemistryPk : Elm.Expression
            , physiologyK : Elm.Expression
            , physiologyPk : Elm.Expression
            , pharmacologyK : Elm.Expression
            , pharmacologyPk : Elm.Expression
            , microbiologyK : Elm.Expression
            , microbiologyPk : Elm.Expression
            , pathologyK : Elm.Expression
            , pathologyPk : Elm.Expression
            , medicalEthicsK : Elm.Expression
            , medicalEthicsPk : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { shopUpgrade =
        \shopUpgradeExpression shopUpgradeTags ->
            Elm.Case.custom
                shopUpgradeExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "ShopUpgrade" [])
                [ Elm.Case.branch0 "Glasses" shopUpgradeTags.glasses ]
    , activity =
        \activityExpression activityTags ->
            Elm.Case.custom
                activityExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Activity" [])
                [ Elm.Case.branch0 "BackAndSpine" activityTags.backAndSpine
                , Elm.Case.branch0 "UpperLimb" activityTags.upperLimb
                , Elm.Case.branch0 "LowerLimb" activityTags.lowerLimb
                , Elm.Case.branch0
                    "MetabolicPathways"
                    activityTags.metabolicPathways
                , Elm.Case.branch0 "Enzymology" activityTags.enzymology
                , Elm.Case.branch0
                    "MolecularBiology"
                    activityTags.molecularBiology
                , Elm.Case.branch0
                    "CellularFunction"
                    activityTags.cellularFunction
                , Elm.Case.branch0
                    "CardiovascularSystem"
                    activityTags.cardiovascularSystem
                , Elm.Case.branch0
                    "RespiratorySystem"
                    activityTags.respiratorySystem
                ]
    , skill =
        \skillExpression skillTags ->
            Elm.Case.custom
                skillExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Skill" [])
                [ Elm.Case.branch0 "Anatomy" skillTags.anatomy
                , Elm.Case.branch0 "Biochemistry" skillTags.biochemistry
                , Elm.Case.branch0 "Physiology" skillTags.physiology
                , Elm.Case.branch0 "Pharmacology" skillTags.pharmacology
                , Elm.Case.branch0 "Microbiology" skillTags.microbiology
                , Elm.Case.branch0 "Pathology" skillTags.pathology
                , Elm.Case.branch0 "MedicalEthics" skillTags.medicalEthics
                ]
    , resource =
        \resourceExpression resourceTags ->
            Elm.Case.custom
                resourceExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Resource" [])
                [ Elm.Case.branch0 "AnatomyK" resourceTags.anatomyK
                , Elm.Case.branch0 "AnatomyPk" resourceTags.anatomyPk
                , Elm.Case.branch0 "BiochemistryK" resourceTags.biochemistryK
                , Elm.Case.branch0 "BiochemistryPk" resourceTags.biochemistryPk
                , Elm.Case.branch0 "PhysiologyK" resourceTags.physiologyK
                , Elm.Case.branch0 "PhysiologyPk" resourceTags.physiologyPk
                , Elm.Case.branch0 "PharmacologyK" resourceTags.pharmacologyK
                , Elm.Case.branch0 "PharmacologyPk" resourceTags.pharmacologyPk
                , Elm.Case.branch0 "MicrobiologyK" resourceTags.microbiologyK
                , Elm.Case.branch0 "MicrobiologyPk" resourceTags.microbiologyPk
                , Elm.Case.branch0 "PathologyK" resourceTags.pathologyK
                , Elm.Case.branch0 "PathologyPk" resourceTags.pathologyPk
                , Elm.Case.branch0 "MedicalEthicsK" resourceTags.medicalEthicsK
                , Elm.Case.branch0
                    "MedicalEthicsPk"
                    resourceTags.medicalEthicsPk
                ]
    }


call_ :
    { setByShopUpgrade :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByShopUpgrade : Elm.Expression -> Elm.Expression -> Elm.Expression
    , shopUpgradeRecord : Elm.Expression -> Elm.Expression
    , getActivityStats : Elm.Expression -> Elm.Expression
    , setByActivity :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activityRecord : Elm.Expression -> Elm.Expression
    , getSkillStats : Elm.Expression -> Elm.Expression
    , setBySkill :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getBySkill : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skillRecord : Elm.Expression -> Elm.Expression
    , setByResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByResource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , resourceRecord : Elm.Expression -> Elm.Expression
    }
call_ =
    { setByShopUpgrade =
        \setByShopUpgradeArg setByShopUpgradeArg0 setByShopUpgradeArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "setByShopUpgrade"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ShopUpgrade"
                                      []
                                  , Type.var "value"
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ShopUpgradeRecord"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ShopUpgradeRecord"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ setByShopUpgradeArg
                , setByShopUpgradeArg0
                , setByShopUpgradeArg1
                ]
    , getByShopUpgrade =
        \getByShopUpgradeArg getByShopUpgradeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getByShopUpgrade"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ShopUpgrade"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ShopUpgradeRecord"
                                      [ Type.var "glasses" ]
                                  ]
                                  (Type.var "glasses")
                             )
                     }
                )
                [ getByShopUpgradeArg, getByShopUpgradeArg0 ]
    , shopUpgradeRecord =
        \shopUpgradeRecordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "shopUpgradeRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ShopUpgradeRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ shopUpgradeRecordArg ]
    , getActivityStats =
        \getActivityStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getActivityStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ActivityStats"
                                       []
                                  )
                             )
                     }
                )
                [ getActivityStatsArg ]
    , setByActivity =
        \setByActivityArg setByActivityArg0 setByActivityArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "setByActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Activity"
                                      []
                                  , Type.var "value"
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ActivityRecord"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ActivityRecord"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ setByActivityArg, setByActivityArg0, setByActivityArg1 ]
    , getByActivity =
        \getByActivityArg getByActivityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getByActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ActivityRecord"
                                      [ Type.var "respiratorySystem" ]
                                  ]
                                  (Type.var "respiratorySystem")
                             )
                     }
                )
                [ getByActivityArg, getByActivityArg0 ]
    , activityRecord =
        \activityRecordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "activityRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ActivityRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ activityRecordArg ]
    , getSkillStats =
        \getSkillStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getSkillStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "SkillStats"
                                       []
                                  )
                             )
                     }
                )
                [ getSkillStatsArg ]
    , setBySkill =
        \setBySkillArg setBySkillArg0 setBySkillArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "setBySkill"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Skill"
                                      []
                                  , Type.var "value"
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "SkillRecord"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "SkillRecord"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ setBySkillArg, setBySkillArg0, setBySkillArg1 ]
    , getBySkill =
        \getBySkillArg getBySkillArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getBySkill"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Skill"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "SkillRecord"
                                      [ Type.var "medicalEthics" ]
                                  ]
                                  (Type.var "medicalEthics")
                             )
                     }
                )
                [ getBySkillArg, getBySkillArg0 ]
    , skillRecord =
        \skillRecordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "skillRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "SkillRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ skillRecordArg ]
    , setByResource =
        \setByResourceArg setByResourceArg0 setByResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "setByResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Resource"
                                      []
                                  , Type.var "value"
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ResourceRecord"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ResourceRecord"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ setByResourceArg, setByResourceArg0, setByResourceArg1 ]
    , getByResource =
        \getByResourceArg getByResourceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getByResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Resource"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ResourceRecord"
                                      [ Type.var "medicalEthicsPk" ]
                                  ]
                                  (Type.var "medicalEthicsPk")
                             )
                     }
                )
                [ getByResourceArg, getByResourceArg0 ]
    , resourceRecord =
        \resourceRecordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "resourceRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ResourceRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ resourceRecordArg ]
    }


values_ :
    { setByShopUpgrade : Elm.Expression
    , getByShopUpgrade : Elm.Expression
    , shopUpgradeRecord : Elm.Expression
    , allShopUpgrades : Elm.Expression
    , getActivityStats : Elm.Expression
    , activityStats : Elm.Expression
    , setByActivity : Elm.Expression
    , getByActivity : Elm.Expression
    , activityRecord : Elm.Expression
    , allActivities : Elm.Expression
    , getSkillStats : Elm.Expression
    , skillStats : Elm.Expression
    , setBySkill : Elm.Expression
    , getBySkill : Elm.Expression
    , skillRecord : Elm.Expression
    , allSkills : Elm.Expression
    , setByResource : Elm.Expression
    , getByResource : Elm.Expression
    , resourceRecord : Elm.Expression
    , allResources : Elm.Expression
    }
values_ =
    { setByShopUpgrade =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "setByShopUpgrade"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ShopUpgrade"
                             []
                         , Type.var "value"
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ShopUpgradeRecord"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "value" ]
                         )
                    )
            }
    , getByShopUpgrade =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getByShopUpgrade"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ShopUpgrade"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ShopUpgradeRecord"
                             [ Type.var "glasses" ]
                         ]
                         (Type.var "glasses")
                    )
            }
    , shopUpgradeRecord =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "shopUpgradeRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allShopUpgrades =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "allShopUpgrades"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgrade"
                              []
                         )
                    )
            }
    , getActivityStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getActivityStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityStats"
                              []
                         )
                    )
            }
    , activityStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "activityStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Kinds" ]
                         "ActivityRecord"
                         [ Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ActivityStats"
                             []
                         ]
                    )
            }
    , setByActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "setByActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                         , Type.var "value"
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ActivityRecord"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "value" ]
                         )
                    )
            }
    , getByActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getByActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ActivityRecord"
                             [ Type.var "respiratorySystem" ]
                         ]
                         (Type.var "respiratorySystem")
                    )
            }
    , activityRecord =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "activityRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allActivities =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "allActivities"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith [ "IdleGame", "Kinds" ] "Activity" [])
                    )
            }
    , getSkillStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getSkillStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" [] ]
                         (Type.namedWith [ "IdleGame", "Kinds" ] "SkillStats" []
                         )
                    )
            }
    , skillStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "skillStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Kinds" ]
                         "SkillRecord"
                         [ Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "SkillStats"
                             []
                         ]
                    )
            }
    , setBySkill =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "setBySkill"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                         , Type.var "value"
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "SkillRecord"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "value" ]
                         )
                    )
            }
    , getBySkill =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getBySkill"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "SkillRecord"
                             [ Type.var "medicalEthics" ]
                         ]
                         (Type.var "medicalEthics")
                    )
            }
    , skillRecord =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "skillRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allSkills =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "allSkills"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith [ "IdleGame", "Kinds" ] "Skill" [])
                    )
            }
    , setByResource =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "setByResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                         , Type.var "value"
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ResourceRecord"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "value" ]
                         )
                    )
            }
    , getByResource =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getByResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ResourceRecord"
                             [ Type.var "medicalEthicsPk" ]
                         ]
                         (Type.var "medicalEthicsPk")
                    )
            }
    , resourceRecord =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "resourceRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allResources =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "allResources"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith [ "IdleGame", "Kinds" ] "Resource" [])
                    )
            }
    }