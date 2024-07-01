module Gen.Types exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Types" ]


annotation_ :
    { backendModel : Type.Annotation
    , sessionGameMap : Type.Annotation
    , frontendModel : Type.Annotation
    , pointerState : Type.Annotation
    , fastForwardState : Type.Annotation
    , game : Type.Annotation
    , timePassesData : Type.Annotation
    , timePassesXpGain : Type.Annotation
    , timePassesResourceLoss : Type.Annotation
    , timePassesResourceGain : Type.Annotation
    , toFrontend : Type.Annotation
    , backendMsg : Type.Annotation
    , toBackend : Type.Annotation
    , frontendMsg : Type.Annotation
    , screenWidth : Type.Annotation
    , testingCenterTab : Type.Annotation
    , locationFilter : Type.Annotation
    , preview : Type.Annotation
    , frontendGameState : Type.Annotation
    , modal : Type.Annotation
    }
annotation_ =
    { backendModel =
        Type.alias
            moduleName_
            "BackendModel"
            []
            (Type.record
                 [ ( "sessionGameMap"
                   , Type.namedWith [ "Types" ] "SessionGameMap" []
                   )
                 , ( "seed", Type.namedWith [ "Random" ] "Seed" [] )
                 ]
            )
    , sessionGameMap =
        Type.alias
            moduleName_
            "SessionGameMap"
            []
            (Type.namedWith
                 [ "Dict" ]
                 "Dict"
                 [ Type.namedWith [ "Lamdera" ] "SessionId" []
                 , Type.namedWith
                     [ "IdleGame", "Snapshot" ]
                     "Snapshot"
                     [ Type.namedWith [ "Types" ] "Game" [] ]
                 ]
            )
    , frontendModel =
        Type.alias
            moduleName_
            "FrontendModel"
            []
            (Type.record
                 [ ( "key"
                   , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                   )
                 , ( "lastFastForwardDuration"
                   , Type.maybe (Type.namedWith [ "Duration" ] "Duration" [])
                   )
                 , ( "showDebugPanel", Type.bool )
                 , ( "tray"
                   , Type.namedWith
                         [ "Toast" ]
                         "Tray"
                         [ Type.namedWith [ "Types" ] "Toast" [] ]
                   )
                 , ( "isDrawerOpen", Type.bool )
                 , ( "activeTab"
                   , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                   )
                 , ( "preview"
                   , Type.maybe (Type.namedWith [ "Types" ] "Preview" [])
                   )
                 , ( "activityExpanded", Type.bool )
                 , ( "isVisible", Type.bool )
                 , ( "activeModal"
                   , Type.maybe (Type.namedWith [ "Types" ] "Modal" [])
                   )
                 , ( "saveGameTimer"
                   , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                   )
                 , ( "gameState"
                   , Type.namedWith [ "Types" ] "FrontendGameState" []
                   )
                 , ( "pointerState"
                   , Type.maybe (Type.namedWith [ "Types" ] "PointerState" [])
                   )
                 , ( "testingCenterActiveTab"
                   , Type.namedWith [ "Types" ] "TestingCenterTab" []
                   )
                 ]
            )
    , pointerState =
        Type.alias
            moduleName_
            "PointerState"
            []
            (Type.record
                 [ ( "longPress"
                   , Type.maybe
                         (Type.triple
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                              Type.float
                              (Type.namedWith [ "Types" ] "FrontendMsg" [])
                         )
                   )
                 , ( "click", Type.namedWith [ "Types" ] "FrontendMsg" [] )
                 ]
            )
    , fastForwardState =
        Type.alias
            moduleName_
            "FastForwardState"
            []
            (Type.record
                 [ ( "original"
                   , Type.namedWith
                         [ "IdleGame", "Snapshot" ]
                         "Snapshot"
                         [ Type.namedWith [ "Types" ] "Game" [] ]
                   )
                 , ( "current"
                   , Type.namedWith
                         [ "IdleGame", "Snapshot" ]
                         "Snapshot"
                         [ Type.namedWith [ "Types" ] "Game" [] ]
                   )
                 , ( "whenItStarted", Type.namedWith [ "Time" ] "Posix" [] )
                 ]
            )
    , game =
        Type.alias
            moduleName_
            "Game"
            []
            (Type.record
                 [ ( "seed", Type.namedWith [ "Random" ] "Seed" [] )
                 , ( "xp"
                   , Type.namedWith
                         [ "Types" ]
                         "SkillRecord"
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                   )
                 , ( "mxp"
                   , Type.namedWith
                         [ "Types" ]
                         "ActivityRecord"
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                   )
                 , ( "activity"
                   , Type.maybe
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "Activity" [])
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                         )
                   )
                 , ( "coin", Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] )
                 , ( "resources"
                   , Type.namedWith [ "Types" ] "ResourceRecord" [ Type.int ]
                   )
                 , ( "ownedShopUpgrades"
                   , Type.namedWith
                         [ "Types" ]
                         "ShopUpgradeRecord"
                         [ Type.bool ]
                   )
                 ]
            )
    , timePassesData =
        Type.alias
            moduleName_
            "TimePassesData"
            []
            (Type.record
                 [ ( "xpGains"
                   , Type.list
                         (Type.namedWith [ "Types" ] "TimePassesXpGain" [])
                   )
                 , ( "coinGains"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                   )
                 , ( "resourcesDiff"
                   , Type.namedWith [ "IdleGame", "Resource" ] "Diff" []
                   )
                 ]
            )
    , timePassesXpGain =
        Type.alias
            moduleName_
            "TimePassesXpGain"
            []
            (Type.record
                 [ ( "originalXp", Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] )
                 , ( "currentXp", Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] )
                 , ( "skill", Type.namedWith [ "Types" ] "Skill" [] )
                 ]
            )
    , timePassesResourceLoss =
        Type.alias
            moduleName_
            "TimePassesResourceLoss"
            []
            (Type.record [ ( "amount", Type.int ), ( "title", Type.string ) ])
    , timePassesResourceGain =
        Type.alias
            moduleName_
            "TimePassesResourceGain"
            []
            (Type.record [ ( "amount", Type.int ), ( "title", Type.string ) ])
    , toFrontend = Type.namedWith [ "Types" ] "ToFrontend" []
    , backendMsg = Type.namedWith [ "Types" ] "BackendMsg" []
    , toBackend = Type.namedWith [ "Types" ] "ToBackend" []
    , frontendMsg = Type.namedWith [ "Types" ] "FrontendMsg" []
    , screenWidth = Type.namedWith [ "Types" ] "ScreenWidth" []
    , testingCenterTab = Type.namedWith [ "Types" ] "TestingCenterTab" []
    , locationFilter = Type.namedWith [ "Types" ] "LocationFilter" []
    , preview = Type.namedWith [ "Types" ] "Preview" []
    , frontendGameState = Type.namedWith [ "Types" ] "FrontendGameState" []
    , modal = Type.namedWith [ "Types" ] "Modal" []
    }


make_ :
    { backendModel :
        { sessionGameMap : Elm.Expression, seed : Elm.Expression }
        -> Elm.Expression
    , frontendModel :
        { key : Elm.Expression
        , lastFastForwardDuration : Elm.Expression
        , showDebugPanel : Elm.Expression
        , tray : Elm.Expression
        , isDrawerOpen : Elm.Expression
        , activeTab : Elm.Expression
        , preview : Elm.Expression
        , activityExpanded : Elm.Expression
        , isVisible : Elm.Expression
        , activeModal : Elm.Expression
        , saveGameTimer : Elm.Expression
        , gameState : Elm.Expression
        , pointerState : Elm.Expression
        , testingCenterActiveTab : Elm.Expression
        }
        -> Elm.Expression
    , pointerState :
        { longPress : Elm.Expression, click : Elm.Expression } -> Elm.Expression
    , fastForwardState :
        { original : Elm.Expression
        , current : Elm.Expression
        , whenItStarted : Elm.Expression
        }
        -> Elm.Expression
    , game :
        { seed : Elm.Expression
        , xp : Elm.Expression
        , mxp : Elm.Expression
        , activity : Elm.Expression
        , coin : Elm.Expression
        , resources : Elm.Expression
        , ownedShopUpgrades : Elm.Expression
        }
        -> Elm.Expression
    , timePassesData :
        { xpGains : Elm.Expression
        , coinGains : Elm.Expression
        , resourcesDiff : Elm.Expression
        }
        -> Elm.Expression
    , timePassesXpGain :
        { originalXp : Elm.Expression
        , currentXp : Elm.Expression
        , skill : Elm.Expression
        }
        -> Elm.Expression
    , timePassesResourceLoss :
        { amount : Elm.Expression, title : Elm.Expression } -> Elm.Expression
    , timePassesResourceGain :
        { amount : Elm.Expression, title : Elm.Expression } -> Elm.Expression
    , noOpToFrontend : Elm.Expression
    , initializeGame : Elm.Expression -> Elm.Expression
    , noOpBackend : Elm.Expression
    , handleConnect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleConnectWithTime :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , noOpToBackend : Elm.Expression
    , save : Elm.Expression -> Elm.Expression
    , noOp : Elm.Expression
    , urlClicked : Elm.Expression -> Elm.Expression
    , urlChanged : Elm.Expression -> Elm.Expression
    , initializeGameHelp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , closePreview : Elm.Expression
    , expandActivity : Elm.Expression
    , collapseActivity : Elm.Expression
    , collapseDetailView : Elm.Expression
    , expandDetailView : Elm.Expression
    , handleSyllabusClick : Elm.Expression -> Elm.Expression
    , handleActivityClick : Elm.Expression -> Elm.Expression -> Elm.Expression
    , handlePreviewClick : Elm.Expression -> Elm.Expression
    , handlePlayClick : Elm.Expression -> Elm.Expression
    , handleStopClick : Elm.Expression -> Elm.Expression
    , openDebugPanel : Elm.Expression
    , closeDebugPanel : Elm.Expression
    , addTime : Elm.Expression -> Elm.Expression
    , addTimeHelp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleShopResourceClick : Elm.Expression -> Elm.Expression
    , handleOneLessButtonClick : Elm.Expression
    , handleOneMoreButtonClick : Elm.Expression
    , handleMinButtonClick : Elm.Expression
    , handleMaxButtonClick : Elm.Expression
    , handleShopResourceQuantityChange : Elm.Expression -> Elm.Expression
    , handleShopResourceBuyClick : Elm.Expression
    , handleTestingCenterTabClick : Elm.Expression -> Elm.Expression
    , toastMsg : Elm.Expression -> Elm.Expression
    , addToast : Elm.Expression -> Elm.Expression
    , handleFastForward : Elm.Expression -> Elm.Expression
    , handleAnimationFrame : Elm.Expression -> Elm.Expression
    , handleAnimationFrameDelta : Elm.Expression -> Elm.Expression
    , setDrawerOpen : Elm.Expression -> Elm.Expression
    , handleVisibilityChangeHelp :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleVisibilityChange : Elm.Expression -> Elm.Expression
    , closeModal : Elm.Expression
    , openMasteryUnlocksModal : Elm.Expression
    , handleTabClick : Elm.Expression -> Elm.Expression
    , handleShopUpgradeClick : Elm.Expression -> Elm.Expression
    , handlePointerDown : Elm.Expression -> Elm.Expression
    , handlePointerUp : Elm.Expression
    , handlePointerCancel : Elm.Expression
    , handleGetViewportResult : Elm.Expression -> Elm.Expression
    , screenXs : Elm.Expression
    , screenSm : Elm.Expression
    , screenMd : Elm.Expression
    , screenLg : Elm.Expression
    , screenXl : Elm.Expression
    , screen2xl : Elm.Expression
    , quizzes : Elm.Expression
    , shelfExams : Elm.Expression
    , usmleStep1 : Elm.Expression
    , locationAll : Elm.Expression
    , locationMonsters : Elm.Expression
    , locationQuests : Elm.Expression
    , preview : Elm.Expression -> Elm.Expression
    , initializing : Elm.Expression
    , playing : Elm.Expression -> Elm.Expression
    , fastForward : Elm.Expression -> Elm.Expression
    , timePassesModal :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , choreItemUnlocksModal : Elm.Expression
    , shopResourceModal :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , syllabusModal : Elm.Expression -> Elm.Expression
    }
make_ =
    { backendModel =
        \backendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "BackendModel"
                     []
                     (Type.record
                          [ ( "sessionGameMap"
                            , Type.namedWith [ "Types" ] "SessionGameMap" []
                            )
                          , ( "seed", Type.namedWith [ "Random" ] "Seed" [] )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "sessionGameMap"
                         backendModel_args.sessionGameMap
                     , Tuple.pair "seed" backendModel_args.seed
                     ]
                )
    , frontendModel =
        \frontendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "FrontendModel"
                     []
                     (Type.record
                          [ ( "key"
                            , Type.namedWith
                                  [ "Browser", "Navigation" ]
                                  "Key"
                                  []
                            )
                          , ( "lastFastForwardDuration"
                            , Type.maybe
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                            )
                          , ( "showDebugPanel", Type.bool )
                          , ( "tray"
                            , Type.namedWith
                                  [ "Toast" ]
                                  "Tray"
                                  [ Type.namedWith [ "Types" ] "Toast" [] ]
                            )
                          , ( "isDrawerOpen", Type.bool )
                          , ( "activeTab"
                            , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                            )
                          , ( "preview"
                            , Type.maybe
                                  (Type.namedWith [ "Types" ] "Preview" [])
                            )
                          , ( "activityExpanded", Type.bool )
                          , ( "isVisible", Type.bool )
                          , ( "activeModal"
                            , Type.maybe (Type.namedWith [ "Types" ] "Modal" [])
                            )
                          , ( "saveGameTimer"
                            , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                            )
                          , ( "gameState"
                            , Type.namedWith [ "Types" ] "FrontendGameState" []
                            )
                          , ( "pointerState"
                            , Type.maybe
                                  (Type.namedWith [ "Types" ] "PointerState" [])
                            )
                          , ( "testingCenterActiveTab"
                            , Type.namedWith [ "Types" ] "TestingCenterTab" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "key" frontendModel_args.key
                     , Tuple.pair
                         "lastFastForwardDuration"
                         frontendModel_args.lastFastForwardDuration
                     , Tuple.pair
                         "showDebugPanel"
                         frontendModel_args.showDebugPanel
                     , Tuple.pair "tray" frontendModel_args.tray
                     , Tuple.pair "isDrawerOpen" frontendModel_args.isDrawerOpen
                     , Tuple.pair "activeTab" frontendModel_args.activeTab
                     , Tuple.pair "preview" frontendModel_args.preview
                     , Tuple.pair
                         "activityExpanded"
                         frontendModel_args.activityExpanded
                     , Tuple.pair "isVisible" frontendModel_args.isVisible
                     , Tuple.pair "activeModal" frontendModel_args.activeModal
                     , Tuple.pair
                         "saveGameTimer"
                         frontendModel_args.saveGameTimer
                     , Tuple.pair "gameState" frontendModel_args.gameState
                     , Tuple.pair "pointerState" frontendModel_args.pointerState
                     , Tuple.pair
                         "testingCenterActiveTab"
                         frontendModel_args.testingCenterActiveTab
                     ]
                )
    , pointerState =
        \pointerState_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "PointerState"
                     []
                     (Type.record
                          [ ( "longPress"
                            , Type.maybe
                                  (Type.triple
                                       (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                       )
                                       Type.float
                                       (Type.namedWith
                                            [ "Types" ]
                                            "FrontendMsg"
                                            []
                                       )
                                  )
                            )
                          , ( "click"
                            , Type.namedWith [ "Types" ] "FrontendMsg" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "longPress" pointerState_args.longPress
                     , Tuple.pair "click" pointerState_args.click
                     ]
                )
    , fastForwardState =
        \fastForwardState_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "FastForwardState"
                     []
                     (Type.record
                          [ ( "original"
                            , Type.namedWith
                                  [ "IdleGame", "Snapshot" ]
                                  "Snapshot"
                                  [ Type.namedWith [ "Types" ] "Game" [] ]
                            )
                          , ( "current"
                            , Type.namedWith
                                  [ "IdleGame", "Snapshot" ]
                                  "Snapshot"
                                  [ Type.namedWith [ "Types" ] "Game" [] ]
                            )
                          , ( "whenItStarted"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "original" fastForwardState_args.original
                     , Tuple.pair "current" fastForwardState_args.current
                     , Tuple.pair
                         "whenItStarted"
                         fastForwardState_args.whenItStarted
                     ]
                )
    , game =
        \game_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "Game"
                     []
                     (Type.record
                          [ ( "seed", Type.namedWith [ "Random" ] "Seed" [] )
                          , ( "xp"
                            , Type.namedWith
                                  [ "Types" ]
                                  "SkillRecord"
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                            )
                          , ( "mxp"
                            , Type.namedWith
                                  [ "Types" ]
                                  "ActivityRecord"
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                            )
                          , ( "activity"
                            , Type.maybe
                                  (Type.tuple
                                       (Type.namedWith [ "Types" ] "Activity" []
                                       )
                                       (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                       )
                                  )
                            )
                          , ( "coin"
                            , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                            )
                          , ( "resources"
                            , Type.namedWith
                                  [ "Types" ]
                                  "ResourceRecord"
                                  [ Type.int ]
                            )
                          , ( "ownedShopUpgrades"
                            , Type.namedWith
                                  [ "Types" ]
                                  "ShopUpgradeRecord"
                                  [ Type.bool ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "seed" game_args.seed
                     , Tuple.pair "xp" game_args.xp
                     , Tuple.pair "mxp" game_args.mxp
                     , Tuple.pair "activity" game_args.activity
                     , Tuple.pair "coin" game_args.coin
                     , Tuple.pair "resources" game_args.resources
                     , Tuple.pair
                         "ownedShopUpgrades"
                         game_args.ownedShopUpgrades
                     ]
                )
    , timePassesData =
        \timePassesData_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "TimePassesData"
                     []
                     (Type.record
                          [ ( "xpGains"
                            , Type.list
                                  (Type.namedWith
                                       [ "Types" ]
                                       "TimePassesXpGain"
                                       []
                                  )
                            )
                          , ( "coinGains"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "IdleGame", "Coin" ]
                                       "Coin"
                                       []
                                  )
                            )
                          , ( "resourcesDiff"
                            , Type.namedWith
                                  [ "IdleGame", "Resource" ]
                                  "Diff"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "xpGains" timePassesData_args.xpGains
                     , Tuple.pair "coinGains" timePassesData_args.coinGains
                     , Tuple.pair
                         "resourcesDiff"
                         timePassesData_args.resourcesDiff
                     ]
                )
    , timePassesXpGain =
        \timePassesXpGain_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "TimePassesXpGain"
                     []
                     (Type.record
                          [ ( "originalXp"
                            , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                            )
                          , ( "currentXp"
                            , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                            )
                          , ( "skill", Type.namedWith [ "Types" ] "Skill" [] )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "originalXp" timePassesXpGain_args.originalXp
                     , Tuple.pair "currentXp" timePassesXpGain_args.currentXp
                     , Tuple.pair "skill" timePassesXpGain_args.skill
                     ]
                )
    , timePassesResourceLoss =
        \timePassesResourceLoss_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "TimePassesResourceLoss"
                     []
                     (Type.record
                          [ ( "amount", Type.int ), ( "title", Type.string ) ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "amount" timePassesResourceLoss_args.amount
                     , Tuple.pair "title" timePassesResourceLoss_args.title
                     ]
                )
    , timePassesResourceGain =
        \timePassesResourceGain_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "TimePassesResourceGain"
                     []
                     (Type.record
                          [ ( "amount", Type.int ), ( "title", Type.string ) ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "amount" timePassesResourceGain_args.amount
                     , Tuple.pair "title" timePassesResourceGain_args.title
                     ]
                )
    , noOpToFrontend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpToFrontend"
            , annotation = Just (Type.namedWith [] "ToFrontend" [])
            }
    , initializeGame =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "InitializeGame"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0 ]
    , noOpBackend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpBackend"
            , annotation = Just (Type.namedWith [] "BackendMsg" [])
            }
    , handleConnect =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleConnect"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , handleConnectWithTime =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleConnectWithTime"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , noOpToBackend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpToBackend"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , save =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Save"
                     , annotation = Just (Type.namedWith [] "ToBackend" [])
                     }
                )
                [ ar0 ]
    , noOp =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOp"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , urlClicked =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UrlClicked"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , urlChanged =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UrlChanged"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , initializeGameHelp =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "InitializeGameHelp"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , closePreview =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ClosePreview"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , expandActivity =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ExpandActivity"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , collapseActivity =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "CollapseActivity"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , collapseDetailView =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "CollapseDetailView"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , expandDetailView =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ExpandDetailView"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleSyllabusClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleSyllabusClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleActivityClick =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleActivityClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , handlePreviewClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandlePreviewClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handlePlayClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandlePlayClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleStopClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleStopClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , openDebugPanel =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "OpenDebugPanel"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , closeDebugPanel =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "CloseDebugPanel"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , addTime =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "AddTime"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , addTimeHelp =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "AddTimeHelp"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , handleShopResourceClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleShopResourceClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleOneLessButtonClick =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandleOneLessButtonClick"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleOneMoreButtonClick =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandleOneMoreButtonClick"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleMinButtonClick =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandleMinButtonClick"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleMaxButtonClick =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandleMaxButtonClick"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleShopResourceQuantityChange =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleShopResourceQuantityChange"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleShopResourceBuyClick =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandleShopResourceBuyClick"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleTestingCenterTabClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleTestingCenterTabClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , toastMsg =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ToastMsg"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , addToast =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "AddToast"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleFastForward =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleFastForward"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleAnimationFrame =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleAnimationFrame"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleAnimationFrameDelta =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleAnimationFrameDelta"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , setDrawerOpen =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "SetDrawerOpen"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleVisibilityChangeHelp =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleVisibilityChangeHelp"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , handleVisibilityChange =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleVisibilityChange"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , closeModal =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "CloseModal"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , openMasteryUnlocksModal =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "OpenMasteryUnlocksModal"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleTabClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleTabClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handleShopUpgradeClick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleShopUpgradeClick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handlePointerDown =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandlePointerDown"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , handlePointerUp =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandlePointerUp"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handlePointerCancel =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "HandlePointerCancel"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , handleGetViewportResult =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "HandleGetViewportResult"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , screenXs =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ScreenXs"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , screenSm =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ScreenSm"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , screenMd =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ScreenMd"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , screenLg =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ScreenLg"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , screenXl =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ScreenXl"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , screen2xl =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "Screen2xl"
            , annotation = Just (Type.namedWith [] "ScreenWidth" [])
            }
    , quizzes =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "Quizzes"
            , annotation = Just (Type.namedWith [] "TestingCenterTab" [])
            }
    , shelfExams =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ShelfExams"
            , annotation = Just (Type.namedWith [] "TestingCenterTab" [])
            }
    , usmleStep1 =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "UsmleStep1"
            , annotation = Just (Type.namedWith [] "TestingCenterTab" [])
            }
    , locationAll =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "LocationAll"
            , annotation = Just (Type.namedWith [] "LocationFilter" [])
            }
    , locationMonsters =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "LocationMonsters"
            , annotation = Just (Type.namedWith [] "LocationFilter" [])
            }
    , locationQuests =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "LocationQuests"
            , annotation = Just (Type.namedWith [] "LocationFilter" [])
            }
    , preview =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Preview"
                     , annotation = Just (Type.namedWith [] "Preview" [])
                     }
                )
                [ ar0 ]
    , initializing =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "Initializing"
            , annotation = Just (Type.namedWith [] "FrontendGameState" [])
            }
    , playing =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Playing"
                     , annotation =
                         Just (Type.namedWith [] "FrontendGameState" [])
                     }
                )
                [ ar0 ]
    , fastForward =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "FastForward"
                     , annotation =
                         Just (Type.namedWith [] "FrontendGameState" [])
                     }
                )
                [ ar0 ]
    , timePassesModal =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "TimePassesModal"
                     , annotation = Just (Type.namedWith [] "Modal" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , choreItemUnlocksModal =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ChoreItemUnlocksModal"
            , annotation = Just (Type.namedWith [] "Modal" [])
            }
    , shopResourceModal =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ShopResourceModal"
                     , annotation = Just (Type.namedWith [] "Modal" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , syllabusModal =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "SyllabusModal"
                     , annotation = Just (Type.namedWith [] "Modal" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { toFrontend :
        Elm.Expression
        -> { toFrontendTags_0_0
            | noOpToFrontend : Elm.Expression
            , initializeGame : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , backendMsg :
        Elm.Expression
        -> { backendMsgTags_1_0
            | noOpBackend : Elm.Expression
            , handleConnect : Elm.Expression -> Elm.Expression -> Elm.Expression
            , handleConnectWithTime :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
        }
        -> Elm.Expression
    , toBackend :
        Elm.Expression
        -> { toBackendTags_2_0
            | noOpToBackend : Elm.Expression
            , save : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , frontendMsg :
        Elm.Expression
        -> { frontendMsgTags_3_0
            | noOp : Elm.Expression
            , urlClicked : Elm.Expression -> Elm.Expression
            , urlChanged : Elm.Expression -> Elm.Expression
            , initializeGameHelp :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , closePreview : Elm.Expression
            , expandActivity : Elm.Expression
            , collapseActivity : Elm.Expression
            , collapseDetailView : Elm.Expression
            , expandDetailView : Elm.Expression
            , handleSyllabusClick : Elm.Expression -> Elm.Expression
            , handleActivityClick :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , handlePreviewClick : Elm.Expression -> Elm.Expression
            , handlePlayClick : Elm.Expression -> Elm.Expression
            , handleStopClick : Elm.Expression -> Elm.Expression
            , openDebugPanel : Elm.Expression
            , closeDebugPanel : Elm.Expression
            , addTime : Elm.Expression -> Elm.Expression
            , addTimeHelp : Elm.Expression -> Elm.Expression -> Elm.Expression
            , handleShopResourceClick : Elm.Expression -> Elm.Expression
            , handleOneLessButtonClick : Elm.Expression
            , handleOneMoreButtonClick : Elm.Expression
            , handleMinButtonClick : Elm.Expression
            , handleMaxButtonClick : Elm.Expression
            , handleShopResourceQuantityChange :
                Elm.Expression -> Elm.Expression
            , handleShopResourceBuyClick : Elm.Expression
            , handleTestingCenterTabClick : Elm.Expression -> Elm.Expression
            , toastMsg : Elm.Expression -> Elm.Expression
            , addToast : Elm.Expression -> Elm.Expression
            , handleFastForward : Elm.Expression -> Elm.Expression
            , handleAnimationFrame : Elm.Expression -> Elm.Expression
            , handleAnimationFrameDelta : Elm.Expression -> Elm.Expression
            , setDrawerOpen : Elm.Expression -> Elm.Expression
            , handleVisibilityChangeHelp :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , handleVisibilityChange : Elm.Expression -> Elm.Expression
            , closeModal : Elm.Expression
            , openMasteryUnlocksModal : Elm.Expression
            , handleTabClick : Elm.Expression -> Elm.Expression
            , handleShopUpgradeClick : Elm.Expression -> Elm.Expression
            , handlePointerDown : Elm.Expression -> Elm.Expression
            , handlePointerUp : Elm.Expression
            , handlePointerCancel : Elm.Expression
            , handleGetViewportResult : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , screenWidth :
        Elm.Expression
        -> { screenWidthTags_4_0
            | screenXs : Elm.Expression
            , screenSm : Elm.Expression
            , screenMd : Elm.Expression
            , screenLg : Elm.Expression
            , screenXl : Elm.Expression
            , screen2xl : Elm.Expression
        }
        -> Elm.Expression
    , testingCenterTab :
        Elm.Expression
        -> { testingCenterTabTags_5_0
            | quizzes : Elm.Expression
            , shelfExams : Elm.Expression
            , usmleStep1 : Elm.Expression
        }
        -> Elm.Expression
    , locationFilter :
        Elm.Expression
        -> { locationFilterTags_6_0
            | locationAll : Elm.Expression
            , locationMonsters : Elm.Expression
            , locationQuests : Elm.Expression
        }
        -> Elm.Expression
    , preview :
        Elm.Expression
        -> { previewTags_7_0 | preview : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , frontendGameState :
        Elm.Expression
        -> { frontendGameStateTags_8_0
            | initializing : Elm.Expression
            , playing : Elm.Expression -> Elm.Expression
            , fastForward : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , modal :
        Elm.Expression
        -> { modalTags_9_0
            | timePassesModal :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , choreItemUnlocksModal : Elm.Expression
            , shopResourceModal :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , syllabusModal : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { toFrontend =
        \toFrontendExpression toFrontendTags ->
            Elm.Case.custom
                toFrontendExpression
                (Type.namedWith [ "Types" ] "ToFrontend" [])
                [ Elm.Case.branch0
                    "NoOpToFrontend"
                    toFrontendTags.noOpToFrontend
                , Elm.Case.branch1
                    "InitializeGame"
                    ( "idleGameSnapshotSnapshot"
                    , Type.namedWith
                          [ "IdleGame", "Snapshot" ]
                          "Snapshot"
                          [ Type.namedWith [ "Types" ] "Game" [] ]
                    )
                    toFrontendTags.initializeGame
                ]
    , backendMsg =
        \backendMsgExpression backendMsgTags ->
            Elm.Case.custom
                backendMsgExpression
                (Type.namedWith [ "Types" ] "BackendMsg" [])
                [ Elm.Case.branch0 "NoOpBackend" backendMsgTags.noOpBackend
                , Elm.Case.branch2
                    "HandleConnect"
                    ( "lamderaSessionId"
                    , Type.namedWith [ "Lamdera" ] "SessionId" []
                    )
                    ( "lamderaClientId"
                    , Type.namedWith [ "Lamdera" ] "ClientId" []
                    )
                    backendMsgTags.handleConnect
                , Elm.Case.branch3
                    "HandleConnectWithTime"
                    ( "lamderaSessionId"
                    , Type.namedWith [ "Lamdera" ] "SessionId" []
                    )
                    ( "lamderaClientId"
                    , Type.namedWith [ "Lamdera" ] "ClientId" []
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    backendMsgTags.handleConnectWithTime
                ]
    , toBackend =
        \toBackendExpression toBackendTags ->
            Elm.Case.custom
                toBackendExpression
                (Type.namedWith [ "Types" ] "ToBackend" [])
                [ Elm.Case.branch0 "NoOpToBackend" toBackendTags.noOpToBackend
                , Elm.Case.branch1
                    "Save"
                    ( "idleGameSnapshotSnapshot"
                    , Type.namedWith
                          [ "IdleGame", "Snapshot" ]
                          "Snapshot"
                          [ Type.namedWith [ "Types" ] "Game" [] ]
                    )
                    toBackendTags.save
                ]
    , frontendMsg =
        \frontendMsgExpression frontendMsgTags ->
            Elm.Case.custom
                frontendMsgExpression
                (Type.namedWith [ "Types" ] "FrontendMsg" [])
                [ Elm.Case.branch0 "NoOp" frontendMsgTags.noOp
                , Elm.Case.branch1
                    "UrlClicked"
                    ( "browserUrlRequest"
                    , Type.namedWith [ "Browser" ] "UrlRequest" []
                    )
                    frontendMsgTags.urlClicked
                , Elm.Case.branch1
                    "UrlChanged"
                    ( "urlUrl", Type.namedWith [ "Url" ] "Url" [] )
                    frontendMsgTags.urlChanged
                , Elm.Case.branch2
                    "InitializeGameHelp"
                    ( "idleGameSnapshotSnapshot"
                    , Type.namedWith
                          [ "IdleGame", "Snapshot" ]
                          "Snapshot"
                          [ Type.namedWith [ "Types" ] "Game" [] ]
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    frontendMsgTags.initializeGameHelp
                , Elm.Case.branch0 "ClosePreview" frontendMsgTags.closePreview
                , Elm.Case.branch0
                    "ExpandActivity"
                    frontendMsgTags.expandActivity
                , Elm.Case.branch0
                    "CollapseActivity"
                    frontendMsgTags.collapseActivity
                , Elm.Case.branch0
                    "CollapseDetailView"
                    frontendMsgTags.collapseDetailView
                , Elm.Case.branch0
                    "ExpandDetailView"
                    frontendMsgTags.expandDetailView
                , Elm.Case.branch1
                    "HandleSyllabusClick"
                    ( "typesSkill", Type.namedWith [ "Types" ] "Skill" [] )
                    frontendMsgTags.handleSyllabusClick
                , Elm.Case.branch2
                    "HandleActivityClick"
                    ( "one"
                    , Type.record
                          [ ( "screenWidth"
                            , Type.namedWith [ "Types" ] "ScreenWidth" []
                            )
                          ]
                    )
                    ( "typesActivity"
                    , Type.namedWith [ "Types" ] "Activity" []
                    )
                    frontendMsgTags.handleActivityClick
                , Elm.Case.branch1
                    "HandlePreviewClick"
                    ( "typesActivity"
                    , Type.namedWith [ "Types" ] "Activity" []
                    )
                    frontendMsgTags.handlePreviewClick
                , Elm.Case.branch1
                    "HandlePlayClick"
                    ( "typesActivity"
                    , Type.namedWith [ "Types" ] "Activity" []
                    )
                    frontendMsgTags.handlePlayClick
                , Elm.Case.branch1
                    "HandleStopClick"
                    ( "typesActivity"
                    , Type.namedWith [ "Types" ] "Activity" []
                    )
                    frontendMsgTags.handleStopClick
                , Elm.Case.branch0
                    "OpenDebugPanel"
                    frontendMsgTags.openDebugPanel
                , Elm.Case.branch0
                    "CloseDebugPanel"
                    frontendMsgTags.closeDebugPanel
                , Elm.Case.branch1
                    "AddTime"
                    ( "durationDuration"
                    , Type.namedWith [ "Duration" ] "Duration" []
                    )
                    frontendMsgTags.addTime
                , Elm.Case.branch2
                    "AddTimeHelp"
                    ( "durationDuration"
                    , Type.namedWith [ "Duration" ] "Duration" []
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    frontendMsgTags.addTimeHelp
                , Elm.Case.branch1
                    "HandleShopResourceClick"
                    ( "typesResource"
                    , Type.namedWith [ "Types" ] "Resource" []
                    )
                    frontendMsgTags.handleShopResourceClick
                , Elm.Case.branch0
                    "HandleOneLessButtonClick"
                    frontendMsgTags.handleOneLessButtonClick
                , Elm.Case.branch0
                    "HandleOneMoreButtonClick"
                    frontendMsgTags.handleOneMoreButtonClick
                , Elm.Case.branch0
                    "HandleMinButtonClick"
                    frontendMsgTags.handleMinButtonClick
                , Elm.Case.branch0
                    "HandleMaxButtonClick"
                    frontendMsgTags.handleMaxButtonClick
                , Elm.Case.branch1
                    "HandleShopResourceQuantityChange"
                    ( "stringString", Type.string )
                    frontendMsgTags.handleShopResourceQuantityChange
                , Elm.Case.branch0
                    "HandleShopResourceBuyClick"
                    frontendMsgTags.handleShopResourceBuyClick
                , Elm.Case.branch1
                    "HandleTestingCenterTabClick"
                    ( "typesTestingCenterTab"
                    , Type.namedWith [ "Types" ] "TestingCenterTab" []
                    )
                    frontendMsgTags.handleTestingCenterTabClick
                , Elm.Case.branch1
                    "ToastMsg"
                    ( "toastMsg", Type.namedWith [ "Toast" ] "Msg" [] )
                    frontendMsgTags.toastMsg
                , Elm.Case.branch1
                    "AddToast"
                    ( "typesToast", Type.namedWith [ "Types" ] "Toast" [] )
                    frontendMsgTags.addToast
                , Elm.Case.branch1
                    "HandleFastForward"
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    frontendMsgTags.handleFastForward
                , Elm.Case.branch1
                    "HandleAnimationFrame"
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    frontendMsgTags.handleAnimationFrame
                , Elm.Case.branch1
                    "HandleAnimationFrameDelta"
                    ( "basicsFloat", Type.float )
                    frontendMsgTags.handleAnimationFrameDelta
                , Elm.Case.branch1
                    "SetDrawerOpen"
                    ( "basicsBool", Type.bool )
                    frontendMsgTags.setDrawerOpen
                , Elm.Case.branch2
                    "HandleVisibilityChangeHelp"
                    ( "browserEventsVisibility"
                    , Type.namedWith [ "Browser", "Events" ] "Visibility" []
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    frontendMsgTags.handleVisibilityChangeHelp
                , Elm.Case.branch1
                    "HandleVisibilityChange"
                    ( "browserEventsVisibility"
                    , Type.namedWith [ "Browser", "Events" ] "Visibility" []
                    )
                    frontendMsgTags.handleVisibilityChange
                , Elm.Case.branch0 "CloseModal" frontendMsgTags.closeModal
                , Elm.Case.branch0
                    "OpenMasteryUnlocksModal"
                    frontendMsgTags.openMasteryUnlocksModal
                , Elm.Case.branch1
                    "HandleTabClick"
                    ( "idleGameTabTab"
                    , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                    )
                    frontendMsgTags.handleTabClick
                , Elm.Case.branch1
                    "HandleShopUpgradeClick"
                    ( "typesShopUpgrade"
                    , Type.namedWith [ "Types" ] "ShopUpgrade" []
                    )
                    frontendMsgTags.handleShopUpgradeClick
                , Elm.Case.branch1
                    "HandlePointerDown"
                    ( "typesPointerState"
                    , Type.namedWith [ "Types" ] "PointerState" []
                    )
                    frontendMsgTags.handlePointerDown
                , Elm.Case.branch0
                    "HandlePointerUp"
                    frontendMsgTags.handlePointerUp
                , Elm.Case.branch0
                    "HandlePointerCancel"
                    frontendMsgTags.handlePointerCancel
                , Elm.Case.branch1
                    "HandleGetViewportResult"
                    ( "browserDomViewport"
                    , Type.namedWith [ "Browser", "Dom" ] "Viewport" []
                    )
                    frontendMsgTags.handleGetViewportResult
                ]
    , screenWidth =
        \screenWidthExpression screenWidthTags ->
            Elm.Case.custom
                screenWidthExpression
                (Type.namedWith [ "Types" ] "ScreenWidth" [])
                [ Elm.Case.branch0 "ScreenXs" screenWidthTags.screenXs
                , Elm.Case.branch0 "ScreenSm" screenWidthTags.screenSm
                , Elm.Case.branch0 "ScreenMd" screenWidthTags.screenMd
                , Elm.Case.branch0 "ScreenLg" screenWidthTags.screenLg
                , Elm.Case.branch0 "ScreenXl" screenWidthTags.screenXl
                , Elm.Case.branch0 "Screen2xl" screenWidthTags.screen2xl
                ]
    , testingCenterTab =
        \testingCenterTabExpression testingCenterTabTags ->
            Elm.Case.custom
                testingCenterTabExpression
                (Type.namedWith [ "Types" ] "TestingCenterTab" [])
                [ Elm.Case.branch0 "Quizzes" testingCenterTabTags.quizzes
                , Elm.Case.branch0 "ShelfExams" testingCenterTabTags.shelfExams
                , Elm.Case.branch0 "UsmleStep1" testingCenterTabTags.usmleStep1
                ]
    , locationFilter =
        \locationFilterExpression locationFilterTags ->
            Elm.Case.custom
                locationFilterExpression
                (Type.namedWith [ "Types" ] "LocationFilter" [])
                [ Elm.Case.branch0 "LocationAll" locationFilterTags.locationAll
                , Elm.Case.branch0
                    "LocationMonsters"
                    locationFilterTags.locationMonsters
                , Elm.Case.branch0
                    "LocationQuests"
                    locationFilterTags.locationQuests
                ]
    , preview =
        \previewExpression previewTags ->
            Elm.Case.custom
                previewExpression
                (Type.namedWith [ "Types" ] "Preview" [])
                [ Elm.Case.branch1
                    "Preview"
                    ( "typesActivity"
                    , Type.namedWith [ "Types" ] "Activity" []
                    )
                    previewTags.preview
                ]
    , frontendGameState =
        \frontendGameStateExpression frontendGameStateTags ->
            Elm.Case.custom
                frontendGameStateExpression
                (Type.namedWith [ "Types" ] "FrontendGameState" [])
                [ Elm.Case.branch0
                    "Initializing"
                    frontendGameStateTags.initializing
                , Elm.Case.branch1
                    "Playing"
                    ( "idleGameSnapshotSnapshot"
                    , Type.namedWith
                          [ "IdleGame", "Snapshot" ]
                          "Snapshot"
                          [ Type.namedWith [ "Types" ] "Game" [] ]
                    )
                    frontendGameStateTags.playing
                , Elm.Case.branch1
                    "FastForward"
                    ( "typesFastForwardState"
                    , Type.namedWith [ "Types" ] "FastForwardState" []
                    )
                    frontendGameStateTags.fastForward
                ]
    , modal =
        \modalExpression modalTags ->
            Elm.Case.custom
                modalExpression
                (Type.namedWith [ "Types" ] "Modal" [])
                [ Elm.Case.branch3
                    "TimePassesModal"
                    ( "durationDuration"
                    , Type.namedWith [ "Duration" ] "Duration" []
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    ( "typesTimePassesData"
                    , Type.namedWith [ "Types" ] "TimePassesData" []
                    )
                    modalTags.timePassesModal
                , Elm.Case.branch0
                    "ChoreItemUnlocksModal"
                    modalTags.choreItemUnlocksModal
                , Elm.Case.branch3
                    "ShopResourceModal"
                    ( "basicsInt", Type.int )
                    ( "typesResource"
                    , Type.namedWith [ "Types" ] "Resource" []
                    )
                    ( "idleGameCoinCoin"
                    , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                    )
                    modalTags.shopResourceModal
                , Elm.Case.branch1
                    "SyllabusModal"
                    ( "typesSkill", Type.namedWith [ "Types" ] "Skill" [] )
                    modalTags.syllabusModal
                ]
    }