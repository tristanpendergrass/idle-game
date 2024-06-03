module Gen.Config exposing (annotation_, flags, make_, moduleName_, values_, version)

{-| 
@docs moduleName_, flags, version, annotation_, make_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Config" ]


{-| flags: Config.Flags -}
flags : Elm.Expression
flags =
    Elm.value
        { importFrom = [ "Config" ]
        , name = "flags"
        , annotation = Just (Type.namedWith [ "Config" ] "Flags" [])
        }


{-| version: String -}
version : Elm.Expression
version =
    Elm.value
        { importFrom = [ "Config" ]
        , name = "version"
        , annotation = Just Type.string
        }


annotation_ : { flags : Type.Annotation }
annotation_ =
    { flags =
        Type.alias
            moduleName_
            "Flags"
            []
            (Type.record
                 [ ( "isDev", Type.bool )
                 , ( "showFastForwardSpeed", Type.bool )
                 , ( "extraFastForwardTime"
                   , Type.namedWith [ "Duration" ] "Duration" []
                   )
                 , ( "debugTimePasses", Type.bool )
                 , ( "showTimePasses", Type.bool )
                 , ( "showDebugPanel", Type.bool )
                 , ( "defaultTab"
                   , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                   )
                 , ( "maxOutSkillXp", Type.bool )
                 ]
            )
    }


make_ :
    { flags :
        { isDev : Elm.Expression
        , showFastForwardSpeed : Elm.Expression
        , extraFastForwardTime : Elm.Expression
        , debugTimePasses : Elm.Expression
        , showTimePasses : Elm.Expression
        , showDebugPanel : Elm.Expression
        , defaultTab : Elm.Expression
        , maxOutSkillXp : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { flags =
        \flags_args ->
            Elm.withType
                (Type.alias
                     [ "Config" ]
                     "Flags"
                     []
                     (Type.record
                          [ ( "isDev", Type.bool )
                          , ( "showFastForwardSpeed", Type.bool )
                          , ( "extraFastForwardTime"
                            , Type.namedWith [ "Duration" ] "Duration" []
                            )
                          , ( "debugTimePasses", Type.bool )
                          , ( "showTimePasses", Type.bool )
                          , ( "showDebugPanel", Type.bool )
                          , ( "defaultTab"
                            , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                            )
                          , ( "maxOutSkillXp", Type.bool )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "isDev" flags_args.isDev
                     , Tuple.pair
                         "showFastForwardSpeed"
                         flags_args.showFastForwardSpeed
                     , Tuple.pair
                         "extraFastForwardTime"
                         flags_args.extraFastForwardTime
                     , Tuple.pair "debugTimePasses" flags_args.debugTimePasses
                     , Tuple.pair "showTimePasses" flags_args.showTimePasses
                     , Tuple.pair "showDebugPanel" flags_args.showDebugPanel
                     , Tuple.pair "defaultTab" flags_args.defaultTab
                     , Tuple.pair "maxOutSkillXp" flags_args.maxOutSkillXp
                     ]
                )
    }


values_ : { flags : Elm.Expression, version : Elm.Expression }
values_ =
    { flags =
        Elm.value
            { importFrom = [ "Config" ]
            , name = "flags"
            , annotation = Just (Type.namedWith [ "Config" ] "Flags" [])
            }
    , version =
        Elm.value
            { importFrom = [ "Config" ]
            , name = "version"
            , annotation = Just Type.string
            }
    }