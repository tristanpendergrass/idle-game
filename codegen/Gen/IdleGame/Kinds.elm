module Gen.IdleGame.Kinds exposing (activityRecord, activityStats, allActivities, allResources, allShopUpgrades, allSkills, allTests, annotation_, call_, caseOf_, getActivityStats, getByActivity, getByResource, getByShopUpgrade, getBySkill, getByTest, getResourceStats, getSkillStats, getTestStats, make_, mapActivities, mapResources, mapShopUpgrades, mapSkills, mapTests, moduleName_, resourceRecord, resourceStats, setByActivity, setByResource, setByShopUpgrade, setBySkill, setByTest, shopUpgradeRecord, skillRecord, skillStats, testRecord, testStats, values_)

{-| 
@docs moduleName_, mapShopUpgrades, setByShopUpgrade, getByShopUpgrade, shopUpgradeRecord, allShopUpgrades, getTestStats, testStats, mapTests, setByTest, getByTest, testRecord, allTests, getResourceStats, resourceStats, mapResources, setByResource, getByResource, resourceRecord, allResources, getActivityStats, activityStats, mapActivities, setByActivity, getByActivity, activityRecord, allActivities, getSkillStats, skillStats, mapSkills, setBySkill, getBySkill, skillRecord, allSkills, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Kinds" ]


{-| mapShopUpgrades: 
    (getByShopUpgrade -> getByShopUpgrade)
    -> IdleGame.Kinds.ShopUpgradeRecord getByShopUpgrade
    -> IdleGame.Kinds.ShopUpgradeRecord getByShopUpgrade
-}
mapShopUpgrades :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapShopUpgrades mapShopUpgradesArg mapShopUpgradesArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "mapShopUpgrades"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "getByShopUpgrade" ]
                              (Type.var "getByShopUpgrade")
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "getByShopUpgrade" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ShopUpgradeRecord"
                               [ Type.var "getByShopUpgrade" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapShopUpgradesUnpack" mapShopUpgradesArg
        , mapShopUpgradesArg0
        ]


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


{-| getTestStats: IdleGame.Kinds.Test -> IdleGame.Kinds.TestStats -}
getTestStats : Elm.Expression -> Elm.Expression
getTestStats getTestStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getTestStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" [] ]
                          (Type.namedWith [ "IdleGame", "Kinds" ] "TestStats" []
                          )
                     )
             }
        )
        [ getTestStatsArg ]


{-| testStats: IdleGame.Kinds.TestRecord IdleGame.Kinds.TestStats -}
testStats : Elm.Expression
testStats =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "testStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Kinds" ]
                     "TestRecord"
                     [ Type.namedWith [ "IdleGame", "Kinds" ] "TestStats" [] ]
                )
        }


{-| mapTests: 
    (getByTest -> getByTest)
    -> IdleGame.Kinds.TestRecord getByTest
    -> IdleGame.Kinds.TestRecord getByTest
-}
mapTests :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapTests mapTestsArg mapTestsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "mapTests"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "getByTest" ]
                              (Type.var "getByTest")
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "getByTest" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "TestRecord"
                               [ Type.var "getByTest" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapTestsUnpack" mapTestsArg, mapTestsArg0 ]


{-| setByTest: 
    IdleGame.Kinds.Test
    -> value
    -> IdleGame.Kinds.TestRecord value
    -> IdleGame.Kinds.TestRecord value
-}
setByTest : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
setByTest setByTestArg setByTestArg0 setByTestArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "setByTest"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" []
                          , Type.var "value"
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "TestRecord"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ setByTestArg, setByTestArg0, setByTestArg1 ]


{-| getByTest: IdleGame.Kinds.Test -> IdleGame.Kinds.TestRecord quiz1 -> quiz1 -}
getByTest : Elm.Expression -> Elm.Expression -> Elm.Expression
getByTest getByTestArg getByTestArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getByTest"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" []
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "quiz1" ]
                          ]
                          (Type.var "quiz1")
                     )
             }
        )
        [ getByTestArg, getByTestArg0 ]


{-| testRecord: a -> IdleGame.Kinds.TestRecord a -}
testRecord : Elm.Expression -> Elm.Expression
testRecord testRecordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "testRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "TestRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ testRecordArg ]


{-| allTests: List IdleGame.Kinds.Test -}
allTests : Elm.Expression
allTests =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "allTests"
        , annotation =
            Just (Type.list (Type.namedWith [ "IdleGame", "Kinds" ] "Test" []))
        }


{-| getResourceStats: IdleGame.Kinds.Resource -> IdleGame.Kinds.ResourceStats -}
getResourceStats : Elm.Expression -> Elm.Expression
getResourceStats getResourceStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "getResourceStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ResourceStats"
                               []
                          )
                     )
             }
        )
        [ getResourceStatsArg ]


{-| resourceStats: IdleGame.Kinds.ResourceRecord IdleGame.Kinds.ResourceStats -}
resourceStats : Elm.Expression
resourceStats =
    Elm.value
        { importFrom = [ "IdleGame", "Kinds" ]
        , name = "resourceStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Kinds" ]
                     "ResourceRecord"
                     [ Type.namedWith [ "IdleGame", "Kinds" ] "ResourceStats" []
                     ]
                )
        }


{-| mapResources: 
    (getByResource -> getByResource)
    -> IdleGame.Kinds.ResourceRecord getByResource
    -> IdleGame.Kinds.ResourceRecord getByResource
-}
mapResources :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapResources mapResourcesArg mapResourcesArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "mapResources"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "getByResource" ]
                              (Type.var "getByResource")
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "getByResource" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ResourceRecord"
                               [ Type.var "getByResource" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapResourcesUnpack" mapResourcesArg
        , mapResourcesArg0
        ]


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
    -> IdleGame.Kinds.ResourceRecord medicalEthicsFlashcard
    -> medicalEthicsFlashcard
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
                              [ Type.var "medicalEthicsFlashcard" ]
                          ]
                          (Type.var "medicalEthicsFlashcard")
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


{-| mapActivities: 
    (getByActivity -> getByActivity)
    -> IdleGame.Kinds.ActivityRecord getByActivity
    -> IdleGame.Kinds.ActivityRecord getByActivity
-}
mapActivities :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapActivities mapActivitiesArg mapActivitiesArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "mapActivities"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "getByActivity" ]
                              (Type.var "getByActivity")
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "getByActivity" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "ActivityRecord"
                               [ Type.var "getByActivity" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapActivitiesUnpack" mapActivitiesArg
        , mapActivitiesArg0
        ]


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


{-| getByActivity: IdleGame.Kinds.Activity -> IdleGame.Kinds.ActivityRecord lab3 -> lab3 -}
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
                              [ Type.var "lab3" ]
                          ]
                          (Type.var "lab3")
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


{-| mapSkills: 
    (getBySkill -> getBySkill)
    -> IdleGame.Kinds.SkillRecord getBySkill
    -> IdleGame.Kinds.SkillRecord getBySkill
-}
mapSkills :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapSkills mapSkillsArg mapSkillsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Kinds" ]
             , name = "mapSkills"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "getBySkill" ]
                              (Type.var "getBySkill")
                          , Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "getBySkill" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Kinds" ]
                               "SkillRecord"
                               [ Type.var "getBySkill" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapSkillsUnpack" mapSkillsArg, mapSkillsArg0 ]


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


{-| getBySkill: IdleGame.Kinds.Skill -> IdleGame.Kinds.SkillRecord labs -> labs -}
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
                              [ Type.var "labs" ]
                          ]
                          (Type.var "labs")
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


annotation_ :
    { shopUpgradeRecord : Type.Annotation -> Type.Annotation
    , testStats : Type.Annotation
    , testRecord : Type.Annotation -> Type.Annotation
    , resourceStats : Type.Annotation
    , resourceRecord : Type.Annotation -> Type.Annotation
    , activityStats : Type.Annotation
    , activityRecord : Type.Annotation -> Type.Annotation
    , skillStats : Type.Annotation
    , skillRecord : Type.Annotation -> Type.Annotation
    , shopUpgrade : Type.Annotation
    , test : Type.Annotation
    , resource : Type.Annotation
    , activity : Type.Annotation
    , skill : Type.Annotation
    }
annotation_ =
    { shopUpgradeRecord =
        \shopUpgradeRecordArg0 ->
            Type.alias
                moduleName_
                "ShopUpgradeRecord"
                [ shopUpgradeRecordArg0 ]
                (Type.record [ ( "glasses", Type.var "a" ) ])
    , testStats =
        Type.alias
            moduleName_
            "TestStats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "category", Type.string )
                 , ( "rewardCoin"
                   , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                   )
                 , ( "rewardResource"
                   , Type.record
                         [ ( "resource"
                           , Type.namedWith
                                 [ "IdleGame", "Kinds" ]
                                 "Resource"
                                 []
                           )
                         , ( "amount", Type.int )
                         ]
                   )
                 , ( "costs"
                   , Type.list
                         (Type.record
                              [ ( "resource"
                                , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Resource"
                                      []
                                )
                              , ( "amount", Type.int )
                              ]
                         )
                   )
                 ]
            )
    , testRecord =
        \testRecordArg0 ->
            Type.alias
                moduleName_
                "TestRecord"
                [ testRecordArg0 ]
                (Type.record [ ( "quiz1", Type.var "a" ) ])
    , resourceStats =
        Type.alias
            moduleName_
            "ResourceStats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 , ( "price"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                   )
                 , ( "reducedBy"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Kinds" ] "Resource" [])
                   )
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
                     , ( "anatomyPK", Type.var "a" )
                     , ( "anatomyFlashcard", Type.var "a" )
                     , ( "biochemistryK", Type.var "a" )
                     , ( "biochemistryPK", Type.var "a" )
                     , ( "biochemistryFlashcard", Type.var "a" )
                     , ( "physiologyK", Type.var "a" )
                     , ( "physiologyPK", Type.var "a" )
                     , ( "physiologyFlashcard", Type.var "a" )
                     , ( "pharmacologyK", Type.var "a" )
                     , ( "pharmacologyPK", Type.var "a" )
                     , ( "pharmacologyFlashcard", Type.var "a" )
                     , ( "microbiologyK", Type.var "a" )
                     , ( "microbiologyPK", Type.var "a" )
                     , ( "microbiologyFlashcard", Type.var "a" )
                     , ( "pathologyK", Type.var "a" )
                     , ( "pathologyPK", Type.var "a" )
                     , ( "pathologyFlashcard", Type.var "a" )
                     , ( "medicalEthicsK", Type.var "a" )
                     , ( "medicalEthicsPK", Type.var "a" )
                     , ( "medicalEthicsFlashcard", Type.var "a" )
                     ]
                )
    , activityStats =
        Type.alias
            moduleName_
            "ActivityStats"
            []
            (Type.record
                 [ ( "skill"
                   , Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                   )
                 , ( "title", Type.string )
                 , ( "image", Type.string )
                 , ( "level", Type.int )
                 , ( "duration", Type.namedWith [ "Duration" ] "Duration" [] )
                 , ( "knowledge", Type.maybe Type.int )
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
                     , ( "thorax", Type.var "a" )
                     , ( "abdomen", Type.var "a" )
                     , ( "pelvisAndPerineum", Type.var "a" )
                     , ( "headAndNeck", Type.var "a" )
                     , ( "integumentarySystem", Type.var "a" )
                     , ( "lymphaticAndImmuneSystem", Type.var "a" )
                     , ( "metabolicPathways", Type.var "a" )
                     , ( "enzymology", Type.var "a" )
                     , ( "molecularBiology", Type.var "a" )
                     , ( "lipidMetabolism", Type.var "a" )
                     , ( "carbohydrateMetabolism", Type.var "a" )
                     , ( "proteinSynthesis", Type.var "a" )
                     , ( "nucleicAcidMetabolism", Type.var "a" )
                     , ( "biochemicalSignaling", Type.var "a" )
                     , ( "vitaminsAndCoenzymes", Type.var "a" )
                     , ( "cellularFunction", Type.var "a" )
                     , ( "cardiovascularSystem", Type.var "a" )
                     , ( "respiratorySystem", Type.var "a" )
                     , ( "renalFunction", Type.var "a" )
                     , ( "digestiveSystem", Type.var "a" )
                     , ( "nervousSystem", Type.var "a" )
                     , ( "endocrineSystem", Type.var "a" )
                     , ( "reproductiveSystem", Type.var "a" )
                     , ( "immuneResponse", Type.var "a" )
                     , ( "mycology", Type.var "a" )
                     , ( "cellInjury", Type.var "a" )
                     , ( "inflammation", Type.var "a" )
                     , ( "hemodynamicDisorders", Type.var "a" )
                     , ( "principlesOfBiomedicalEthics", Type.var "a" )
                     , ( "informedConsent", Type.var "a" )
                     , ( "confidentialityAndPrivacy", Type.var "a" )
                     , ( "lab1", Type.var "a" )
                     , ( "lab2", Type.var "a" )
                     , ( "lab3", Type.var "a" )
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
                     , ( "labs", Type.var "a" )
                     ]
                )
    , shopUpgrade = Type.namedWith [ "IdleGame", "Kinds" ] "ShopUpgrade" []
    , test = Type.namedWith [ "IdleGame", "Kinds" ] "Test" []
    , resource = Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
    , activity = Type.namedWith [ "IdleGame", "Kinds" ] "Activity" []
    , skill = Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
    }


make_ :
    { shopUpgradeRecord : { glasses : Elm.Expression } -> Elm.Expression
    , testStats :
        { title : Elm.Expression
        , category : Elm.Expression
        , rewardCoin : Elm.Expression
        , rewardResource : Elm.Expression
        , costs : Elm.Expression
        }
        -> Elm.Expression
    , testRecord : { quiz1 : Elm.Expression } -> Elm.Expression
    , resourceStats :
        { title : Elm.Expression
        , icon : Elm.Expression
        , price : Elm.Expression
        , reducedBy : Elm.Expression
        }
        -> Elm.Expression
    , resourceRecord :
        { anatomyK : Elm.Expression
        , anatomyPK : Elm.Expression
        , anatomyFlashcard : Elm.Expression
        , biochemistryK : Elm.Expression
        , biochemistryPK : Elm.Expression
        , biochemistryFlashcard : Elm.Expression
        , physiologyK : Elm.Expression
        , physiologyPK : Elm.Expression
        , physiologyFlashcard : Elm.Expression
        , pharmacologyK : Elm.Expression
        , pharmacologyPK : Elm.Expression
        , pharmacologyFlashcard : Elm.Expression
        , microbiologyK : Elm.Expression
        , microbiologyPK : Elm.Expression
        , microbiologyFlashcard : Elm.Expression
        , pathologyK : Elm.Expression
        , pathologyPK : Elm.Expression
        , pathologyFlashcard : Elm.Expression
        , medicalEthicsK : Elm.Expression
        , medicalEthicsPK : Elm.Expression
        , medicalEthicsFlashcard : Elm.Expression
        }
        -> Elm.Expression
    , activityStats :
        { skill : Elm.Expression
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
        , thorax : Elm.Expression
        , abdomen : Elm.Expression
        , pelvisAndPerineum : Elm.Expression
        , headAndNeck : Elm.Expression
        , integumentarySystem : Elm.Expression
        , lymphaticAndImmuneSystem : Elm.Expression
        , metabolicPathways : Elm.Expression
        , enzymology : Elm.Expression
        , molecularBiology : Elm.Expression
        , lipidMetabolism : Elm.Expression
        , carbohydrateMetabolism : Elm.Expression
        , proteinSynthesis : Elm.Expression
        , nucleicAcidMetabolism : Elm.Expression
        , biochemicalSignaling : Elm.Expression
        , vitaminsAndCoenzymes : Elm.Expression
        , cellularFunction : Elm.Expression
        , cardiovascularSystem : Elm.Expression
        , respiratorySystem : Elm.Expression
        , renalFunction : Elm.Expression
        , digestiveSystem : Elm.Expression
        , nervousSystem : Elm.Expression
        , endocrineSystem : Elm.Expression
        , reproductiveSystem : Elm.Expression
        , immuneResponse : Elm.Expression
        , mycology : Elm.Expression
        , cellInjury : Elm.Expression
        , inflammation : Elm.Expression
        , hemodynamicDisorders : Elm.Expression
        , principlesOfBiomedicalEthics : Elm.Expression
        , informedConsent : Elm.Expression
        , confidentialityAndPrivacy : Elm.Expression
        , lab1 : Elm.Expression
        , lab2 : Elm.Expression
        , lab3 : Elm.Expression
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
        , labs : Elm.Expression
        }
        -> Elm.Expression
    , glasses : Elm.Expression
    , quiz1 : Elm.Expression
    , anatomyK : Elm.Expression
    , anatomyPK : Elm.Expression
    , anatomyFlashcard : Elm.Expression
    , biochemistryK : Elm.Expression
    , biochemistryPK : Elm.Expression
    , biochemistryFlashcard : Elm.Expression
    , physiologyK : Elm.Expression
    , physiologyPK : Elm.Expression
    , physiologyFlashcard : Elm.Expression
    , pharmacologyK : Elm.Expression
    , pharmacologyPK : Elm.Expression
    , pharmacologyFlashcard : Elm.Expression
    , microbiologyK : Elm.Expression
    , microbiologyPK : Elm.Expression
    , microbiologyFlashcard : Elm.Expression
    , pathologyK : Elm.Expression
    , pathologyPK : Elm.Expression
    , pathologyFlashcard : Elm.Expression
    , medicalEthicsK : Elm.Expression
    , medicalEthicsPK : Elm.Expression
    , medicalEthicsFlashcard : Elm.Expression
    , backAndSpine : Elm.Expression
    , upperLimb : Elm.Expression
    , lowerLimb : Elm.Expression
    , thorax : Elm.Expression
    , abdomen : Elm.Expression
    , pelvisAndPerineum : Elm.Expression
    , headAndNeck : Elm.Expression
    , integumentarySystem : Elm.Expression
    , lymphaticAndImmuneSystem : Elm.Expression
    , metabolicPathways : Elm.Expression
    , enzymology : Elm.Expression
    , molecularBiology : Elm.Expression
    , lipidMetabolism : Elm.Expression
    , carbohydrateMetabolism : Elm.Expression
    , proteinSynthesis : Elm.Expression
    , nucleicAcidMetabolism : Elm.Expression
    , biochemicalSignaling : Elm.Expression
    , vitaminsAndCoenzymes : Elm.Expression
    , cellularFunction : Elm.Expression
    , cardiovascularSystem : Elm.Expression
    , respiratorySystem : Elm.Expression
    , renalFunction : Elm.Expression
    , digestiveSystem : Elm.Expression
    , nervousSystem : Elm.Expression
    , endocrineSystem : Elm.Expression
    , reproductiveSystem : Elm.Expression
    , immuneResponse : Elm.Expression
    , mycology : Elm.Expression
    , cellInjury : Elm.Expression
    , inflammation : Elm.Expression
    , hemodynamicDisorders : Elm.Expression
    , principlesOfBiomedicalEthics : Elm.Expression
    , informedConsent : Elm.Expression
    , confidentialityAndPrivacy : Elm.Expression
    , lab1 : Elm.Expression
    , lab2 : Elm.Expression
    , lab3 : Elm.Expression
    , anatomy : Elm.Expression
    , biochemistry : Elm.Expression
    , physiology : Elm.Expression
    , pharmacology : Elm.Expression
    , microbiology : Elm.Expression
    , pathology : Elm.Expression
    , medicalEthics : Elm.Expression
    , labs : Elm.Expression
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
    , testStats =
        \testStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "TestStats"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "category", Type.string )
                          , ( "rewardCoin"
                            , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                            )
                          , ( "rewardResource"
                            , Type.record
                                  [ ( "resource"
                                    , Type.namedWith
                                          [ "IdleGame", "Kinds" ]
                                          "Resource"
                                          []
                                    )
                                  , ( "amount", Type.int )
                                  ]
                            )
                          , ( "costs"
                            , Type.list
                                  (Type.record
                                       [ ( "resource"
                                         , Type.namedWith
                                               [ "IdleGame", "Kinds" ]
                                               "Resource"
                                               []
                                         )
                                       , ( "amount", Type.int )
                                       ]
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" testStats_args.title
                     , Tuple.pair "category" testStats_args.category
                     , Tuple.pair "rewardCoin" testStats_args.rewardCoin
                     , Tuple.pair "rewardResource" testStats_args.rewardResource
                     , Tuple.pair "costs" testStats_args.costs
                     ]
                )
    , testRecord =
        \testRecord_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "TestRecord"
                     [ Type.var "a" ]
                     (Type.record [ ( "quiz1", Type.var "a" ) ])
                )
                (Elm.record [ Tuple.pair "quiz1" testRecord_args.quiz1 ])
    , resourceStats =
        \resourceStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ResourceStats"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "icon"
                            , Type.namedWith
                                  [ "IdleGame", "Views", "Icon" ]
                                  "Icon"
                                  []
                            )
                          , ( "price"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "IdleGame", "Coin" ]
                                       "Coin"
                                       []
                                  )
                            )
                          , ( "reducedBy"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "Resource"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" resourceStats_args.title
                     , Tuple.pair "icon" resourceStats_args.icon
                     , Tuple.pair "price" resourceStats_args.price
                     , Tuple.pair "reducedBy" resourceStats_args.reducedBy
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
                          , ( "anatomyPK", Type.var "a" )
                          , ( "anatomyFlashcard", Type.var "a" )
                          , ( "biochemistryK", Type.var "a" )
                          , ( "biochemistryPK", Type.var "a" )
                          , ( "biochemistryFlashcard", Type.var "a" )
                          , ( "physiologyK", Type.var "a" )
                          , ( "physiologyPK", Type.var "a" )
                          , ( "physiologyFlashcard", Type.var "a" )
                          , ( "pharmacologyK", Type.var "a" )
                          , ( "pharmacologyPK", Type.var "a" )
                          , ( "pharmacologyFlashcard", Type.var "a" )
                          , ( "microbiologyK", Type.var "a" )
                          , ( "microbiologyPK", Type.var "a" )
                          , ( "microbiologyFlashcard", Type.var "a" )
                          , ( "pathologyK", Type.var "a" )
                          , ( "pathologyPK", Type.var "a" )
                          , ( "pathologyFlashcard", Type.var "a" )
                          , ( "medicalEthicsK", Type.var "a" )
                          , ( "medicalEthicsPK", Type.var "a" )
                          , ( "medicalEthicsFlashcard", Type.var "a" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "anatomyK" resourceRecord_args.anatomyK
                     , Tuple.pair "anatomyPK" resourceRecord_args.anatomyPK
                     , Tuple.pair
                         "anatomyFlashcard"
                         resourceRecord_args.anatomyFlashcard
                     , Tuple.pair
                         "biochemistryK"
                         resourceRecord_args.biochemistryK
                     , Tuple.pair
                         "biochemistryPK"
                         resourceRecord_args.biochemistryPK
                     , Tuple.pair
                         "biochemistryFlashcard"
                         resourceRecord_args.biochemistryFlashcard
                     , Tuple.pair "physiologyK" resourceRecord_args.physiologyK
                     , Tuple.pair
                         "physiologyPK"
                         resourceRecord_args.physiologyPK
                     , Tuple.pair
                         "physiologyFlashcard"
                         resourceRecord_args.physiologyFlashcard
                     , Tuple.pair
                         "pharmacologyK"
                         resourceRecord_args.pharmacologyK
                     , Tuple.pair
                         "pharmacologyPK"
                         resourceRecord_args.pharmacologyPK
                     , Tuple.pair
                         "pharmacologyFlashcard"
                         resourceRecord_args.pharmacologyFlashcard
                     , Tuple.pair
                         "microbiologyK"
                         resourceRecord_args.microbiologyK
                     , Tuple.pair
                         "microbiologyPK"
                         resourceRecord_args.microbiologyPK
                     , Tuple.pair
                         "microbiologyFlashcard"
                         resourceRecord_args.microbiologyFlashcard
                     , Tuple.pair "pathologyK" resourceRecord_args.pathologyK
                     , Tuple.pair "pathologyPK" resourceRecord_args.pathologyPK
                     , Tuple.pair
                         "pathologyFlashcard"
                         resourceRecord_args.pathologyFlashcard
                     , Tuple.pair
                         "medicalEthicsK"
                         resourceRecord_args.medicalEthicsK
                     , Tuple.pair
                         "medicalEthicsPK"
                         resourceRecord_args.medicalEthicsPK
                     , Tuple.pair
                         "medicalEthicsFlashcard"
                         resourceRecord_args.medicalEthicsFlashcard
                     ]
                )
    , activityStats =
        \activityStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Kinds" ]
                     "ActivityStats"
                     []
                     (Type.record
                          [ ( "skill"
                            , Type.namedWith [ "IdleGame", "Kinds" ] "Skill" []
                            )
                          , ( "title", Type.string )
                          , ( "image", Type.string )
                          , ( "level", Type.int )
                          , ( "duration"
                            , Type.namedWith [ "Duration" ] "Duration" []
                            )
                          , ( "knowledge", Type.maybe Type.int )
                          , ( "type_", Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "skill" activityStats_args.skill
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
                          , ( "thorax", Type.var "a" )
                          , ( "abdomen", Type.var "a" )
                          , ( "pelvisAndPerineum", Type.var "a" )
                          , ( "headAndNeck", Type.var "a" )
                          , ( "integumentarySystem", Type.var "a" )
                          , ( "lymphaticAndImmuneSystem", Type.var "a" )
                          , ( "metabolicPathways", Type.var "a" )
                          , ( "enzymology", Type.var "a" )
                          , ( "molecularBiology", Type.var "a" )
                          , ( "lipidMetabolism", Type.var "a" )
                          , ( "carbohydrateMetabolism", Type.var "a" )
                          , ( "proteinSynthesis", Type.var "a" )
                          , ( "nucleicAcidMetabolism", Type.var "a" )
                          , ( "biochemicalSignaling", Type.var "a" )
                          , ( "vitaminsAndCoenzymes", Type.var "a" )
                          , ( "cellularFunction", Type.var "a" )
                          , ( "cardiovascularSystem", Type.var "a" )
                          , ( "respiratorySystem", Type.var "a" )
                          , ( "renalFunction", Type.var "a" )
                          , ( "digestiveSystem", Type.var "a" )
                          , ( "nervousSystem", Type.var "a" )
                          , ( "endocrineSystem", Type.var "a" )
                          , ( "reproductiveSystem", Type.var "a" )
                          , ( "immuneResponse", Type.var "a" )
                          , ( "mycology", Type.var "a" )
                          , ( "cellInjury", Type.var "a" )
                          , ( "inflammation", Type.var "a" )
                          , ( "hemodynamicDisorders", Type.var "a" )
                          , ( "principlesOfBiomedicalEthics", Type.var "a" )
                          , ( "informedConsent", Type.var "a" )
                          , ( "confidentialityAndPrivacy", Type.var "a" )
                          , ( "lab1", Type.var "a" )
                          , ( "lab2", Type.var "a" )
                          , ( "lab3", Type.var "a" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "backAndSpine"
                         activityRecord_args.backAndSpine
                     , Tuple.pair "upperLimb" activityRecord_args.upperLimb
                     , Tuple.pair "lowerLimb" activityRecord_args.lowerLimb
                     , Tuple.pair "thorax" activityRecord_args.thorax
                     , Tuple.pair "abdomen" activityRecord_args.abdomen
                     , Tuple.pair
                         "pelvisAndPerineum"
                         activityRecord_args.pelvisAndPerineum
                     , Tuple.pair "headAndNeck" activityRecord_args.headAndNeck
                     , Tuple.pair
                         "integumentarySystem"
                         activityRecord_args.integumentarySystem
                     , Tuple.pair
                         "lymphaticAndImmuneSystem"
                         activityRecord_args.lymphaticAndImmuneSystem
                     , Tuple.pair
                         "metabolicPathways"
                         activityRecord_args.metabolicPathways
                     , Tuple.pair "enzymology" activityRecord_args.enzymology
                     , Tuple.pair
                         "molecularBiology"
                         activityRecord_args.molecularBiology
                     , Tuple.pair
                         "lipidMetabolism"
                         activityRecord_args.lipidMetabolism
                     , Tuple.pair
                         "carbohydrateMetabolism"
                         activityRecord_args.carbohydrateMetabolism
                     , Tuple.pair
                         "proteinSynthesis"
                         activityRecord_args.proteinSynthesis
                     , Tuple.pair
                         "nucleicAcidMetabolism"
                         activityRecord_args.nucleicAcidMetabolism
                     , Tuple.pair
                         "biochemicalSignaling"
                         activityRecord_args.biochemicalSignaling
                     , Tuple.pair
                         "vitaminsAndCoenzymes"
                         activityRecord_args.vitaminsAndCoenzymes
                     , Tuple.pair
                         "cellularFunction"
                         activityRecord_args.cellularFunction
                     , Tuple.pair
                         "cardiovascularSystem"
                         activityRecord_args.cardiovascularSystem
                     , Tuple.pair
                         "respiratorySystem"
                         activityRecord_args.respiratorySystem
                     , Tuple.pair
                         "renalFunction"
                         activityRecord_args.renalFunction
                     , Tuple.pair
                         "digestiveSystem"
                         activityRecord_args.digestiveSystem
                     , Tuple.pair
                         "nervousSystem"
                         activityRecord_args.nervousSystem
                     , Tuple.pair
                         "endocrineSystem"
                         activityRecord_args.endocrineSystem
                     , Tuple.pair
                         "reproductiveSystem"
                         activityRecord_args.reproductiveSystem
                     , Tuple.pair
                         "immuneResponse"
                         activityRecord_args.immuneResponse
                     , Tuple.pair "mycology" activityRecord_args.mycology
                     , Tuple.pair "cellInjury" activityRecord_args.cellInjury
                     , Tuple.pair
                         "inflammation"
                         activityRecord_args.inflammation
                     , Tuple.pair
                         "hemodynamicDisorders"
                         activityRecord_args.hemodynamicDisorders
                     , Tuple.pair
                         "principlesOfBiomedicalEthics"
                         activityRecord_args.principlesOfBiomedicalEthics
                     , Tuple.pair
                         "informedConsent"
                         activityRecord_args.informedConsent
                     , Tuple.pair
                         "confidentialityAndPrivacy"
                         activityRecord_args.confidentialityAndPrivacy
                     , Tuple.pair "lab1" activityRecord_args.lab1
                     , Tuple.pair "lab2" activityRecord_args.lab2
                     , Tuple.pair "lab3" activityRecord_args.lab3
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
                          , ( "labs", Type.var "a" )
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
                     , Tuple.pair "labs" skillRecord_args.labs
                     ]
                )
    , glasses =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Glasses"
            , annotation = Just (Type.namedWith [] "ShopUpgrade" [])
            }
    , quiz1 =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Quiz1"
            , annotation = Just (Type.namedWith [] "Test" [])
            }
    , anatomyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "AnatomyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , anatomyPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "AnatomyPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , anatomyFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "AnatomyFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , biochemistryK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemistryK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , biochemistryPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemistryPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , biochemistryFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemistryFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , physiologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PhysiologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , physiologyPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PhysiologyPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , physiologyFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PhysiologyFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pharmacologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PharmacologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pharmacologyPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PharmacologyPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pharmacologyFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PharmacologyFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , microbiologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MicrobiologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , microbiologyPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MicrobiologyPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , microbiologyFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MicrobiologyFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pathologyK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PathologyK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pathologyPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PathologyPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , pathologyFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PathologyFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , medicalEthicsK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthicsK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , medicalEthicsPK =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthicsPK"
            , annotation = Just (Type.namedWith [] "Resource" [])
            }
    , medicalEthicsFlashcard =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "MedicalEthicsFlashcard"
            , annotation = Just (Type.namedWith [] "Resource" [])
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
    , thorax =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Thorax"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , abdomen =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Abdomen"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , pelvisAndPerineum =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PelvisAndPerineum"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , headAndNeck =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "HeadAndNeck"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , integumentarySystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "IntegumentarySystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , lymphaticAndImmuneSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "LymphaticAndImmuneSystem"
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
    , lipidMetabolism =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "LipidMetabolism"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , carbohydrateMetabolism =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "CarbohydrateMetabolism"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , proteinSynthesis =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "ProteinSynthesis"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , nucleicAcidMetabolism =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "NucleicAcidMetabolism"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , biochemicalSignaling =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "BiochemicalSignaling"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , vitaminsAndCoenzymes =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "VitaminsAndCoenzymes"
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
    , renalFunction =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "RenalFunction"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , digestiveSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "DigestiveSystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , nervousSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "NervousSystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , endocrineSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "EndocrineSystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , reproductiveSystem =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "ReproductiveSystem"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , immuneResponse =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "ImmuneResponse"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , mycology =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Mycology"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , cellInjury =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "CellInjury"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , inflammation =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Inflammation"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , hemodynamicDisorders =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "HemodynamicDisorders"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , principlesOfBiomedicalEthics =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "PrinciplesOfBiomedicalEthics"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , informedConsent =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "InformedConsent"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , confidentialityAndPrivacy =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "ConfidentialityAndPrivacy"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , lab1 =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Lab1"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , lab2 =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Lab2"
            , annotation = Just (Type.namedWith [] "Activity" [])
            }
    , lab3 =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Lab3"
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
    , labs =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "Labs"
            , annotation = Just (Type.namedWith [] "Skill" [])
            }
    }


caseOf_ :
    { shopUpgrade :
        Elm.Expression
        -> { shopUpgradeTags_0_0 | glasses : Elm.Expression }
        -> Elm.Expression
    , test :
        Elm.Expression
        -> { testTags_1_0 | quiz1 : Elm.Expression }
        -> Elm.Expression
    , resource :
        Elm.Expression
        -> { resourceTags_2_0
            | anatomyK : Elm.Expression
            , anatomyPK : Elm.Expression
            , anatomyFlashcard : Elm.Expression
            , biochemistryK : Elm.Expression
            , biochemistryPK : Elm.Expression
            , biochemistryFlashcard : Elm.Expression
            , physiologyK : Elm.Expression
            , physiologyPK : Elm.Expression
            , physiologyFlashcard : Elm.Expression
            , pharmacologyK : Elm.Expression
            , pharmacologyPK : Elm.Expression
            , pharmacologyFlashcard : Elm.Expression
            , microbiologyK : Elm.Expression
            , microbiologyPK : Elm.Expression
            , microbiologyFlashcard : Elm.Expression
            , pathologyK : Elm.Expression
            , pathologyPK : Elm.Expression
            , pathologyFlashcard : Elm.Expression
            , medicalEthicsK : Elm.Expression
            , medicalEthicsPK : Elm.Expression
            , medicalEthicsFlashcard : Elm.Expression
        }
        -> Elm.Expression
    , activity :
        Elm.Expression
        -> { activityTags_3_0
            | backAndSpine : Elm.Expression
            , upperLimb : Elm.Expression
            , lowerLimb : Elm.Expression
            , thorax : Elm.Expression
            , abdomen : Elm.Expression
            , pelvisAndPerineum : Elm.Expression
            , headAndNeck : Elm.Expression
            , integumentarySystem : Elm.Expression
            , lymphaticAndImmuneSystem : Elm.Expression
            , metabolicPathways : Elm.Expression
            , enzymology : Elm.Expression
            , molecularBiology : Elm.Expression
            , lipidMetabolism : Elm.Expression
            , carbohydrateMetabolism : Elm.Expression
            , proteinSynthesis : Elm.Expression
            , nucleicAcidMetabolism : Elm.Expression
            , biochemicalSignaling : Elm.Expression
            , vitaminsAndCoenzymes : Elm.Expression
            , cellularFunction : Elm.Expression
            , cardiovascularSystem : Elm.Expression
            , respiratorySystem : Elm.Expression
            , renalFunction : Elm.Expression
            , digestiveSystem : Elm.Expression
            , nervousSystem : Elm.Expression
            , endocrineSystem : Elm.Expression
            , reproductiveSystem : Elm.Expression
            , immuneResponse : Elm.Expression
            , mycology : Elm.Expression
            , cellInjury : Elm.Expression
            , inflammation : Elm.Expression
            , hemodynamicDisorders : Elm.Expression
            , principlesOfBiomedicalEthics : Elm.Expression
            , informedConsent : Elm.Expression
            , confidentialityAndPrivacy : Elm.Expression
            , lab1 : Elm.Expression
            , lab2 : Elm.Expression
            , lab3 : Elm.Expression
        }
        -> Elm.Expression
    , skill :
        Elm.Expression
        -> { skillTags_4_0
            | anatomy : Elm.Expression
            , biochemistry : Elm.Expression
            , physiology : Elm.Expression
            , pharmacology : Elm.Expression
            , microbiology : Elm.Expression
            , pathology : Elm.Expression
            , medicalEthics : Elm.Expression
            , labs : Elm.Expression
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
    , test =
        \testExpression testTags ->
            Elm.Case.custom
                testExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Test" [])
                [ Elm.Case.branch0 "Quiz1" testTags.quiz1 ]
    , resource =
        \resourceExpression resourceTags ->
            Elm.Case.custom
                resourceExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Resource" [])
                [ Elm.Case.branch0 "AnatomyK" resourceTags.anatomyK
                , Elm.Case.branch0 "AnatomyPK" resourceTags.anatomyPK
                , Elm.Case.branch0
                    "AnatomyFlashcard"
                    resourceTags.anatomyFlashcard
                , Elm.Case.branch0 "BiochemistryK" resourceTags.biochemistryK
                , Elm.Case.branch0 "BiochemistryPK" resourceTags.biochemistryPK
                , Elm.Case.branch0
                    "BiochemistryFlashcard"
                    resourceTags.biochemistryFlashcard
                , Elm.Case.branch0 "PhysiologyK" resourceTags.physiologyK
                , Elm.Case.branch0 "PhysiologyPK" resourceTags.physiologyPK
                , Elm.Case.branch0
                    "PhysiologyFlashcard"
                    resourceTags.physiologyFlashcard
                , Elm.Case.branch0 "PharmacologyK" resourceTags.pharmacologyK
                , Elm.Case.branch0 "PharmacologyPK" resourceTags.pharmacologyPK
                , Elm.Case.branch0
                    "PharmacologyFlashcard"
                    resourceTags.pharmacologyFlashcard
                , Elm.Case.branch0 "MicrobiologyK" resourceTags.microbiologyK
                , Elm.Case.branch0 "MicrobiologyPK" resourceTags.microbiologyPK
                , Elm.Case.branch0
                    "MicrobiologyFlashcard"
                    resourceTags.microbiologyFlashcard
                , Elm.Case.branch0 "PathologyK" resourceTags.pathologyK
                , Elm.Case.branch0 "PathologyPK" resourceTags.pathologyPK
                , Elm.Case.branch0
                    "PathologyFlashcard"
                    resourceTags.pathologyFlashcard
                , Elm.Case.branch0 "MedicalEthicsK" resourceTags.medicalEthicsK
                , Elm.Case.branch0
                    "MedicalEthicsPK"
                    resourceTags.medicalEthicsPK
                , Elm.Case.branch0
                    "MedicalEthicsFlashcard"
                    resourceTags.medicalEthicsFlashcard
                ]
    , activity =
        \activityExpression activityTags ->
            Elm.Case.custom
                activityExpression
                (Type.namedWith [ "IdleGame", "Kinds" ] "Activity" [])
                [ Elm.Case.branch0 "BackAndSpine" activityTags.backAndSpine
                , Elm.Case.branch0 "UpperLimb" activityTags.upperLimb
                , Elm.Case.branch0 "LowerLimb" activityTags.lowerLimb
                , Elm.Case.branch0 "Thorax" activityTags.thorax
                , Elm.Case.branch0 "Abdomen" activityTags.abdomen
                , Elm.Case.branch0
                    "PelvisAndPerineum"
                    activityTags.pelvisAndPerineum
                , Elm.Case.branch0 "HeadAndNeck" activityTags.headAndNeck
                , Elm.Case.branch0
                    "IntegumentarySystem"
                    activityTags.integumentarySystem
                , Elm.Case.branch0
                    "LymphaticAndImmuneSystem"
                    activityTags.lymphaticAndImmuneSystem
                , Elm.Case.branch0
                    "MetabolicPathways"
                    activityTags.metabolicPathways
                , Elm.Case.branch0 "Enzymology" activityTags.enzymology
                , Elm.Case.branch0
                    "MolecularBiology"
                    activityTags.molecularBiology
                , Elm.Case.branch0
                    "LipidMetabolism"
                    activityTags.lipidMetabolism
                , Elm.Case.branch0
                    "CarbohydrateMetabolism"
                    activityTags.carbohydrateMetabolism
                , Elm.Case.branch0
                    "ProteinSynthesis"
                    activityTags.proteinSynthesis
                , Elm.Case.branch0
                    "NucleicAcidMetabolism"
                    activityTags.nucleicAcidMetabolism
                , Elm.Case.branch0
                    "BiochemicalSignaling"
                    activityTags.biochemicalSignaling
                , Elm.Case.branch0
                    "VitaminsAndCoenzymes"
                    activityTags.vitaminsAndCoenzymes
                , Elm.Case.branch0
                    "CellularFunction"
                    activityTags.cellularFunction
                , Elm.Case.branch0
                    "CardiovascularSystem"
                    activityTags.cardiovascularSystem
                , Elm.Case.branch0
                    "RespiratorySystem"
                    activityTags.respiratorySystem
                , Elm.Case.branch0 "RenalFunction" activityTags.renalFunction
                , Elm.Case.branch0
                    "DigestiveSystem"
                    activityTags.digestiveSystem
                , Elm.Case.branch0 "NervousSystem" activityTags.nervousSystem
                , Elm.Case.branch0
                    "EndocrineSystem"
                    activityTags.endocrineSystem
                , Elm.Case.branch0
                    "ReproductiveSystem"
                    activityTags.reproductiveSystem
                , Elm.Case.branch0 "ImmuneResponse" activityTags.immuneResponse
                , Elm.Case.branch0 "Mycology" activityTags.mycology
                , Elm.Case.branch0 "CellInjury" activityTags.cellInjury
                , Elm.Case.branch0 "Inflammation" activityTags.inflammation
                , Elm.Case.branch0
                    "HemodynamicDisorders"
                    activityTags.hemodynamicDisorders
                , Elm.Case.branch0
                    "PrinciplesOfBiomedicalEthics"
                    activityTags.principlesOfBiomedicalEthics
                , Elm.Case.branch0
                    "InformedConsent"
                    activityTags.informedConsent
                , Elm.Case.branch0
                    "ConfidentialityAndPrivacy"
                    activityTags.confidentialityAndPrivacy
                , Elm.Case.branch0 "Lab1" activityTags.lab1
                , Elm.Case.branch0 "Lab2" activityTags.lab2
                , Elm.Case.branch0 "Lab3" activityTags.lab3
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
                , Elm.Case.branch0 "Labs" skillTags.labs
                ]
    }


call_ :
    { mapShopUpgrades : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setByShopUpgrade :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByShopUpgrade : Elm.Expression -> Elm.Expression -> Elm.Expression
    , shopUpgradeRecord : Elm.Expression -> Elm.Expression
    , getTestStats : Elm.Expression -> Elm.Expression
    , mapTests : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setByTest :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByTest : Elm.Expression -> Elm.Expression -> Elm.Expression
    , testRecord : Elm.Expression -> Elm.Expression
    , getResourceStats : Elm.Expression -> Elm.Expression
    , mapResources : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setByResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByResource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , resourceRecord : Elm.Expression -> Elm.Expression
    , getActivityStats : Elm.Expression -> Elm.Expression
    , mapActivities : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setByActivity :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getByActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activityRecord : Elm.Expression -> Elm.Expression
    , getSkillStats : Elm.Expression -> Elm.Expression
    , mapSkills : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setBySkill :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getBySkill : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skillRecord : Elm.Expression -> Elm.Expression
    }
call_ =
    { mapShopUpgrades =
        \mapShopUpgradesArg mapShopUpgradesArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "mapShopUpgrades"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "getByShopUpgrade" ]
                                      (Type.var "getByShopUpgrade")
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ShopUpgradeRecord"
                                      [ Type.var "getByShopUpgrade" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ShopUpgradeRecord"
                                       [ Type.var "getByShopUpgrade" ]
                                  )
                             )
                     }
                )
                [ mapShopUpgradesArg, mapShopUpgradesArg0 ]
    , setByShopUpgrade =
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
    , getTestStats =
        \getTestStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getTestStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Test"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "TestStats"
                                       []
                                  )
                             )
                     }
                )
                [ getTestStatsArg ]
    , mapTests =
        \mapTestsArg mapTestsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "mapTests"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "getByTest" ]
                                      (Type.var "getByTest")
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "TestRecord"
                                      [ Type.var "getByTest" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "TestRecord"
                                       [ Type.var "getByTest" ]
                                  )
                             )
                     }
                )
                [ mapTestsArg, mapTestsArg0 ]
    , setByTest =
        \setByTestArg setByTestArg0 setByTestArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "setByTest"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Test"
                                      []
                                  , Type.var "value"
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "TestRecord"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "TestRecord"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ setByTestArg, setByTestArg0, setByTestArg1 ]
    , getByTest =
        \getByTestArg getByTestArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getByTest"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Test"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "TestRecord"
                                      [ Type.var "quiz1" ]
                                  ]
                                  (Type.var "quiz1")
                             )
                     }
                )
                [ getByTestArg, getByTestArg0 ]
    , testRecord =
        \testRecordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "testRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "TestRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ testRecordArg ]
    , getResourceStats =
        \getResourceStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "getResourceStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ResourceStats"
                                       []
                                  )
                             )
                     }
                )
                [ getResourceStatsArg ]
    , mapResources =
        \mapResourcesArg mapResourcesArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "mapResources"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "getByResource" ]
                                      (Type.var "getByResource")
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ResourceRecord"
                                      [ Type.var "getByResource" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ResourceRecord"
                                       [ Type.var "getByResource" ]
                                  )
                             )
                     }
                )
                [ mapResourcesArg, mapResourcesArg0 ]
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
                                      [ Type.var "medicalEthicsFlashcard" ]
                                  ]
                                  (Type.var "medicalEthicsFlashcard")
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
    , mapActivities =
        \mapActivitiesArg mapActivitiesArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "mapActivities"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "getByActivity" ]
                                      (Type.var "getByActivity")
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "ActivityRecord"
                                      [ Type.var "getByActivity" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "ActivityRecord"
                                       [ Type.var "getByActivity" ]
                                  )
                             )
                     }
                )
                [ mapActivitiesArg, mapActivitiesArg0 ]
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
                                      [ Type.var "lab3" ]
                                  ]
                                  (Type.var "lab3")
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
    , mapSkills =
        \mapSkillsArg mapSkillsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Kinds" ]
                     , name = "mapSkills"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "getBySkill" ]
                                      (Type.var "getBySkill")
                                  , Type.namedWith
                                      [ "IdleGame", "Kinds" ]
                                      "SkillRecord"
                                      [ Type.var "getBySkill" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Kinds" ]
                                       "SkillRecord"
                                       [ Type.var "getBySkill" ]
                                  )
                             )
                     }
                )
                [ mapSkillsArg, mapSkillsArg0 ]
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
                                      [ Type.var "labs" ]
                                  ]
                                  (Type.var "labs")
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
    }


values_ :
    { mapShopUpgrades : Elm.Expression
    , setByShopUpgrade : Elm.Expression
    , getByShopUpgrade : Elm.Expression
    , shopUpgradeRecord : Elm.Expression
    , allShopUpgrades : Elm.Expression
    , getTestStats : Elm.Expression
    , testStats : Elm.Expression
    , mapTests : Elm.Expression
    , setByTest : Elm.Expression
    , getByTest : Elm.Expression
    , testRecord : Elm.Expression
    , allTests : Elm.Expression
    , getResourceStats : Elm.Expression
    , resourceStats : Elm.Expression
    , mapResources : Elm.Expression
    , setByResource : Elm.Expression
    , getByResource : Elm.Expression
    , resourceRecord : Elm.Expression
    , allResources : Elm.Expression
    , getActivityStats : Elm.Expression
    , activityStats : Elm.Expression
    , mapActivities : Elm.Expression
    , setByActivity : Elm.Expression
    , getByActivity : Elm.Expression
    , activityRecord : Elm.Expression
    , allActivities : Elm.Expression
    , getSkillStats : Elm.Expression
    , skillStats : Elm.Expression
    , mapSkills : Elm.Expression
    , setBySkill : Elm.Expression
    , getBySkill : Elm.Expression
    , skillRecord : Elm.Expression
    , allSkills : Elm.Expression
    }
values_ =
    { mapShopUpgrades =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "mapShopUpgrades"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "getByShopUpgrade" ]
                             (Type.var "getByShopUpgrade")
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ShopUpgradeRecord"
                             [ Type.var "getByShopUpgrade" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ShopUpgradeRecord"
                              [ Type.var "getByShopUpgrade" ]
                         )
                    )
            }
    , setByShopUpgrade =
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
    , getTestStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getTestStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" [] ]
                         (Type.namedWith [ "IdleGame", "Kinds" ] "TestStats" [])
                    )
            }
    , testStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "testStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Kinds" ]
                         "TestRecord"
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "TestStats" []
                         ]
                    )
            }
    , mapTests =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "mapTests"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "getByTest" ]
                             (Type.var "getByTest")
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "TestRecord"
                             [ Type.var "getByTest" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "getByTest" ]
                         )
                    )
            }
    , setByTest =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "setByTest"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" []
                         , Type.var "value"
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "TestRecord"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "value" ]
                         )
                    )
            }
    , getByTest =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getByTest"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Test" []
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "TestRecord"
                             [ Type.var "quiz1" ]
                         ]
                         (Type.var "quiz1")
                    )
            }
    , testRecord =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "testRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "TestRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allTests =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "allTests"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith [ "IdleGame", "Kinds" ] "Test" [])
                    )
            }
    , getResourceStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "getResourceStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Kinds" ] "Resource" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceStats"
                              []
                         )
                    )
            }
    , resourceStats =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "resourceStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Kinds" ]
                         "ResourceRecord"
                         [ Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ResourceStats"
                             []
                         ]
                    )
            }
    , mapResources =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "mapResources"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "getByResource" ]
                             (Type.var "getByResource")
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ResourceRecord"
                             [ Type.var "getByResource" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ResourceRecord"
                              [ Type.var "getByResource" ]
                         )
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
                             [ Type.var "medicalEthicsFlashcard" ]
                         ]
                         (Type.var "medicalEthicsFlashcard")
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
    , mapActivities =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "mapActivities"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "getByActivity" ]
                             (Type.var "getByActivity")
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "ActivityRecord"
                             [ Type.var "getByActivity" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "ActivityRecord"
                              [ Type.var "getByActivity" ]
                         )
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
                             [ Type.var "lab3" ]
                         ]
                         (Type.var "lab3")
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
    , mapSkills =
        Elm.value
            { importFrom = [ "IdleGame", "Kinds" ]
            , name = "mapSkills"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "getBySkill" ]
                             (Type.var "getBySkill")
                         , Type.namedWith
                             [ "IdleGame", "Kinds" ]
                             "SkillRecord"
                             [ Type.var "getBySkill" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Kinds" ]
                              "SkillRecord"
                              [ Type.var "getBySkill" ]
                         )
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
                             [ Type.var "labs" ]
                         ]
                         (Type.var "labs")
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
    }