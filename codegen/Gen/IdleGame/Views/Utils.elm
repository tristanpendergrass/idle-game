module Gen.IdleGame.Views.Utils exposing (annotation_, call_, cardImage, caseOf_, classTopNav, day, floatToString, getDurationString, getDurationStringParts, hour, intToString, make_, masteryXpBadge, minute, modToString, moduleName_, priceLabel, progressBar, resource, resourceAndQuantity, resourceQuantity, screenSupportsRighRail, second, skillXpBadge, values_, withScreenWidth)

{-| 
@docs moduleName_, cardImage, priceLabel, modToString, resourceQuantity, resource, resourceAndQuantity, screenSupportsRighRail, withScreenWidth, progressBar, classTopNav, getDurationStringParts, day, hour, minute, second, getDurationString, masteryXpBadge, skillXpBadge, floatToString, intToString, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Utils" ]


{-| cardImage: IdleGame.Views.Utils.CardImage -> IdleGame.Views.Utils.Html msg -}
cardImage : Elm.Expression -> Elm.Expression
cardImage cardImageArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "cardImage"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "CardImage"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ cardImageArg ]


{-| priceLabel: { price : IdleGame.Coin.Coin, isError : Bool } -> IdleGame.Views.Utils.Html msg -}
priceLabel : { price : Elm.Expression, isError : Bool } -> Elm.Expression
priceLabel priceLabelArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "priceLabel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "price"
                                , Type.namedWith
                                    [ "IdleGame", "Coin" ]
                                    "Coin"
                                    []
                                )
                              , ( "isError", Type.bool )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "price" priceLabelArg.price
            , Tuple.pair "isError" (Elm.bool priceLabelArg.isError)
            ]
        ]


{-| modToString: IdleGame.Mod.Mod -> String -}
modToString : Elm.Expression -> Elm.Expression
modToString modToStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "modToString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" [] ]
                          Type.string
                     )
             }
        )
        [ modToStringArg ]


{-| resourceQuantity: { quantity : Int } -> IdleGame.Views.Utils.Html msg -}
resourceQuantity : { quantity : Int } -> Elm.Expression
resourceQuantity resourceQuantityArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "resourceQuantity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record [ ( "quantity", Type.int ) ] ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "quantity" (Elm.int resourceQuantityArg.quantity) ]
        ]


{-| resource: 
    { resource : IdleGame.Views.Utils.Resource
    , iconSize : IdleGame.Views.Icon.Size
    }
    -> IdleGame.Views.Utils.Html msg
-}
resource :
    { resource : Elm.Expression, iconSize : Elm.Expression } -> Elm.Expression
resource resourceArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "resource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "resource"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "Resource"
                                    []
                                )
                              , ( "iconSize"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Icon" ]
                                    "Size"
                                    []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "resource" resourceArg.resource
            , Tuple.pair "iconSize" resourceArg.iconSize
            ]
        ]


{-| resourceAndQuantity: 
    { resource : IdleGame.Views.Utils.Resource
    , quantity : Int
    , iconSize : IdleGame.Views.Icon.Size
    }
    -> IdleGame.Views.Utils.Html msg
-}
resourceAndQuantity :
    { resource : Elm.Expression, quantity : Int, iconSize : Elm.Expression }
    -> Elm.Expression
resourceAndQuantity resourceAndQuantityArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "resourceAndQuantity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "resource"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "Resource"
                                    []
                                )
                              , ( "quantity", Type.int )
                              , ( "iconSize"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Icon" ]
                                    "Size"
                                    []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "resource" resourceAndQuantityArg.resource
            , Tuple.pair "quantity" (Elm.int resourceAndQuantityArg.quantity)
            , Tuple.pair "iconSize" resourceAndQuantityArg.iconSize
            ]
        ]


{-| {-| Returns true if the screen is large enough to display the game in full screen mode, with right rail and left drawer displayed.
-}

screenSupportsRighRail: IdleGame.Views.Utils.ScreenWidth -> Bool
-}
screenSupportsRighRail : Elm.Expression -> Elm.Expression
screenSupportsRighRail screenSupportsRighRailArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "screenSupportsRighRail"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "ScreenWidth"
                              []
                          ]
                          Type.bool
                     )
             }
        )
        [ screenSupportsRighRailArg ]


{-| withScreenWidth: 
    (IdleGame.Views.Utils.ScreenWidth -> IdleGame.Views.Utils.Html msg)
    -> IdleGame.Views.Utils.Html msg
-}
withScreenWidth : (Elm.Expression -> Elm.Expression) -> Elm.Expression
withScreenWidth withScreenWidthArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "withScreenWidth"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "ScreenWidth"
                                    []
                              ]
                              (Type.namedWith
                                 [ "IdleGame", "Views", "Utils" ]
                                 "Html"
                                 [ Type.var "msg" ]
                              )
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "withScreenWidthUnpack" withScreenWidthArg ]


{-| progressBar: 
    { progressText : String
    , percent : Percent.Percent
    , primaryOrSecondary : IdleGame.Views.Utils.PrimaryOrSecondary
    , size : IdleGame.Views.Utils.ProgressBarSize
    }
    -> IdleGame.Views.Utils.Html msg
-}
progressBar :
    { progressText : String
    , percent : Elm.Expression
    , primaryOrSecondary : Elm.Expression
    , size : Elm.Expression
    }
    -> Elm.Expression
progressBar progressBarArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "progressBar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "progressText", Type.string )
                              , ( "percent"
                                , Type.namedWith [ "Percent" ] "Percent" []
                                )
                              , ( "primaryOrSecondary"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "PrimaryOrSecondary"
                                    []
                                )
                              , ( "size"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "ProgressBarSize"
                                    []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "progressText" (Elm.string progressBarArg.progressText)
            , Tuple.pair "percent" progressBarArg.percent
            , Tuple.pair "primaryOrSecondary" progressBarArg.primaryOrSecondary
            , Tuple.pair "size" progressBarArg.size
            ]
        ]


{-| classTopNav: 
    { skill : IdleGame.Views.Utils.Skill, xp : IdleGame.Xp.Xp }
    -> IdleGame.Views.Utils.Html IdleGame.Views.Utils.FrontendMsg
-}
classTopNav : { skill : Elm.Expression, xp : Elm.Expression } -> Elm.Expression
classTopNav classTopNavArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "classTopNav"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "skill"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Utils" ]
                                    "Skill"
                                    []
                                )
                              , ( "xp"
                                , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "skill" classTopNavArg.skill
            , Tuple.pair "xp" classTopNavArg.xp
            ]
        ]


{-| getDurationStringParts: Int -> List String -}
getDurationStringParts : Int -> Elm.Expression
getDurationStringParts getDurationStringPartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "getDurationStringParts"
             , annotation =
                 Just (Type.function [ Type.int ] (Type.list Type.string))
             }
        )
        [ Elm.int getDurationStringPartsArg ]


{-| day: Int -}
day : Elm.Expression
day =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils" ]
        , name = "day"
        , annotation = Just Type.int
        }


{-| hour: Int -}
hour : Elm.Expression
hour =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils" ]
        , name = "hour"
        , annotation = Just Type.int
        }


{-| minute: Int -}
minute : Elm.Expression
minute =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils" ]
        , name = "minute"
        , annotation = Just Type.int
        }


{-| second: Int -}
second : Elm.Expression
second =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils" ]
        , name = "second"
        , annotation = Just Type.int
        }


{-| getDurationString: Int -> String -}
getDurationString : Int -> Elm.Expression
getDurationString getDurationStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "getDurationString"
             , annotation = Just (Type.function [ Type.int ] Type.string)
             }
        )
        [ Elm.int getDurationStringArg ]


{-| masteryXpBadge: IdleGame.Views.Utils.Html msg -}
masteryXpBadge : Elm.Expression
masteryXpBadge =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils" ]
        , name = "masteryXpBadge"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "Utils" ]
                     "Html"
                     [ Type.var "msg" ]
                )
        }


{-| skillXpBadge: IdleGame.Views.Utils.Skill -> IdleGame.Views.Utils.Html msg -}
skillXpBadge : Elm.Expression -> Elm.Expression
skillXpBadge skillXpBadgeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "skillXpBadge"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Skill"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Utils" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ skillXpBadgeArg ]


{-| floatToString: Int -> Float -> String -}
floatToString : Int -> Float -> Elm.Expression
floatToString floatToStringArg floatToStringArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "floatToString"
             , annotation =
                 Just (Type.function [ Type.int, Type.float ] Type.string)
             }
        )
        [ Elm.int floatToStringArg, Elm.float floatToStringArg0 ]


{-| intToString: Int -> String -}
intToString : Int -> Elm.Expression
intToString intToStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Utils" ]
             , name = "intToString"
             , annotation = Just (Type.function [ Type.int ] Type.string)
             }
        )
        [ Elm.int intToStringArg ]


annotation_ :
    { progressBarSize : Type.Annotation, primaryOrSecondary : Type.Annotation }
annotation_ =
    { progressBarSize =
        Type.namedWith [ "IdleGame", "Views", "Utils" ] "ProgressBarSize" []
    , primaryOrSecondary =
        Type.namedWith [ "IdleGame", "Views", "Utils" ] "PrimaryOrSecondary" []
    }


make_ :
    { progressBarSmall : Elm.Expression
    , progressBarLarge : Elm.Expression
    , primary : Elm.Expression
    , secondary : Elm.Expression
    }
make_ =
    { progressBarSmall =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "ProgressBarSmall"
            , annotation = Just (Type.namedWith [] "ProgressBarSize" [])
            }
    , progressBarLarge =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "ProgressBarLarge"
            , annotation = Just (Type.namedWith [] "ProgressBarSize" [])
            }
    , primary =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "Primary"
            , annotation = Just (Type.namedWith [] "PrimaryOrSecondary" [])
            }
    , secondary =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "Secondary"
            , annotation = Just (Type.namedWith [] "PrimaryOrSecondary" [])
            }
    }


caseOf_ :
    { progressBarSize :
        Elm.Expression
        -> { progressBarSizeTags_0_0
            | progressBarSmall : Elm.Expression
            , progressBarLarge : Elm.Expression
        }
        -> Elm.Expression
    , primaryOrSecondary :
        Elm.Expression
        -> { primaryOrSecondaryTags_1_0
            | primary : Elm.Expression
            , secondary : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { progressBarSize =
        \progressBarSizeExpression progressBarSizeTags ->
            Elm.Case.custom
                progressBarSizeExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "Utils" ]
                     "ProgressBarSize"
                     []
                )
                [ Elm.Case.branch0
                    "ProgressBarSmall"
                    progressBarSizeTags.progressBarSmall
                , Elm.Case.branch0
                    "ProgressBarLarge"
                    progressBarSizeTags.progressBarLarge
                ]
    , primaryOrSecondary =
        \primaryOrSecondaryExpression primaryOrSecondaryTags ->
            Elm.Case.custom
                primaryOrSecondaryExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "Utils" ]
                     "PrimaryOrSecondary"
                     []
                )
                [ Elm.Case.branch0 "Primary" primaryOrSecondaryTags.primary
                , Elm.Case.branch0 "Secondary" primaryOrSecondaryTags.secondary
                ]
    }


call_ :
    { cardImage : Elm.Expression -> Elm.Expression
    , priceLabel : Elm.Expression -> Elm.Expression
    , modToString : Elm.Expression -> Elm.Expression
    , resourceQuantity : Elm.Expression -> Elm.Expression
    , resource : Elm.Expression -> Elm.Expression
    , resourceAndQuantity : Elm.Expression -> Elm.Expression
    , screenSupportsRighRail : Elm.Expression -> Elm.Expression
    , withScreenWidth : Elm.Expression -> Elm.Expression
    , progressBar : Elm.Expression -> Elm.Expression
    , classTopNav : Elm.Expression -> Elm.Expression
    , getDurationStringParts : Elm.Expression -> Elm.Expression
    , getDurationString : Elm.Expression -> Elm.Expression
    , skillXpBadge : Elm.Expression -> Elm.Expression
    , floatToString : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intToString : Elm.Expression -> Elm.Expression
    }
call_ =
    { cardImage =
        \cardImageArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "cardImage"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Utils" ]
                                      "CardImage"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ cardImageArg ]
    , priceLabel =
        \priceLabelArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "priceLabel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "price"
                                        , Type.namedWith
                                            [ "IdleGame", "Coin" ]
                                            "Coin"
                                            []
                                        )
                                      , ( "isError", Type.bool )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ priceLabelArg ]
    , modToString =
        \modToStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "modToString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ modToStringArg ]
    , resourceQuantity =
        \resourceQuantityArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "resourceQuantity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record [ ( "quantity", Type.int ) ] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ resourceQuantityArg ]
    , resource =
        \resourceArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "resource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "resource"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "Resource"
                                            []
                                        )
                                      , ( "iconSize"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Icon" ]
                                            "Size"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ resourceArg ]
    , resourceAndQuantity =
        \resourceAndQuantityArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "resourceAndQuantity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "resource"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "Resource"
                                            []
                                        )
                                      , ( "quantity", Type.int )
                                      , ( "iconSize"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Icon" ]
                                            "Size"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ resourceAndQuantityArg ]
    , screenSupportsRighRail =
        \screenSupportsRighRailArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "screenSupportsRighRail"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Utils" ]
                                      "ScreenWidth"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ screenSupportsRighRailArg ]
    , withScreenWidth =
        \withScreenWidthArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "withScreenWidth"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "ScreenWidth"
                                            []
                                      ]
                                      (Type.namedWith
                                         [ "IdleGame", "Views", "Utils" ]
                                         "Html"
                                         [ Type.var "msg" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ withScreenWidthArg ]
    , progressBar =
        \progressBarArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "progressBar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "progressText", Type.string )
                                      , ( "percent"
                                        , Type.namedWith
                                            [ "Percent" ]
                                            "Percent"
                                            []
                                        )
                                      , ( "primaryOrSecondary"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "PrimaryOrSecondary"
                                            []
                                        )
                                      , ( "size"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "ProgressBarSize"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ progressBarArg ]
    , classTopNav =
        \classTopNavArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "classTopNav"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "skill"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Utils" ]
                                            "Skill"
                                            []
                                        )
                                      , ( "xp"
                                        , Type.namedWith
                                            [ "IdleGame", "Xp" ]
                                            "Xp"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Utils" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ classTopNavArg ]
    , getDurationStringParts =
        \getDurationStringPartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "getDurationStringParts"
                     , annotation =
                         Just
                             (Type.function [ Type.int ] (Type.list Type.string)
                             )
                     }
                )
                [ getDurationStringPartsArg ]
    , getDurationString =
        \getDurationStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "getDurationString"
                     , annotation =
                         Just (Type.function [ Type.int ] Type.string)
                     }
                )
                [ getDurationStringArg ]
    , skillXpBadge =
        \skillXpBadgeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "skillXpBadge"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Utils" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Utils" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ skillXpBadgeArg ]
    , floatToString =
        \floatToStringArg floatToStringArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "floatToString"
                     , annotation =
                         Just
                             (Type.function [ Type.int, Type.float ] Type.string
                             )
                     }
                )
                [ floatToStringArg, floatToStringArg0 ]
    , intToString =
        \intToStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Utils" ]
                     , name = "intToString"
                     , annotation =
                         Just (Type.function [ Type.int ] Type.string)
                     }
                )
                [ intToStringArg ]
    }


values_ :
    { cardImage : Elm.Expression
    , priceLabel : Elm.Expression
    , modToString : Elm.Expression
    , resourceQuantity : Elm.Expression
    , resource : Elm.Expression
    , resourceAndQuantity : Elm.Expression
    , screenSupportsRighRail : Elm.Expression
    , withScreenWidth : Elm.Expression
    , progressBar : Elm.Expression
    , classTopNav : Elm.Expression
    , getDurationStringParts : Elm.Expression
    , day : Elm.Expression
    , hour : Elm.Expression
    , minute : Elm.Expression
    , second : Elm.Expression
    , getDurationString : Elm.Expression
    , masteryXpBadge : Elm.Expression
    , skillXpBadge : Elm.Expression
    , floatToString : Elm.Expression
    , intToString : Elm.Expression
    }
values_ =
    { cardImage =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "cardImage"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Utils" ]
                             "CardImage"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , priceLabel =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "priceLabel"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "price"
                               , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                               )
                             , ( "isError", Type.bool )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , modToString =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "modToString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" [] ]
                         Type.string
                    )
            }
    , resourceQuantity =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "resourceQuantity"
            , annotation =
                Just
                    (Type.function
                         [ Type.record [ ( "quantity", Type.int ) ] ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , resource =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "resource"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "resource"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "Resource"
                                   []
                               )
                             , ( "iconSize"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Icon" ]
                                   "Size"
                                   []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , resourceAndQuantity =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "resourceAndQuantity"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "resource"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "Resource"
                                   []
                               )
                             , ( "quantity", Type.int )
                             , ( "iconSize"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Icon" ]
                                   "Size"
                                   []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , screenSupportsRighRail =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "screenSupportsRighRail"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Utils" ]
                             "ScreenWidth"
                             []
                         ]
                         Type.bool
                    )
            }
    , withScreenWidth =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "withScreenWidth"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "ScreenWidth"
                                   []
                             ]
                             (Type.namedWith
                                [ "IdleGame", "Views", "Utils" ]
                                "Html"
                                [ Type.var "msg" ]
                             )
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , progressBar =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "progressBar"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "progressText", Type.string )
                             , ( "percent"
                               , Type.namedWith [ "Percent" ] "Percent" []
                               )
                             , ( "primaryOrSecondary"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "PrimaryOrSecondary"
                                   []
                               )
                             , ( "size"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "ProgressBarSize"
                                   []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , classTopNav =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "classTopNav"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "skill"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Utils" ]
                                   "Skill"
                                   []
                               )
                             , ( "xp"
                               , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Utils" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , getDurationStringParts =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "getDurationStringParts"
            , annotation =
                Just (Type.function [ Type.int ] (Type.list Type.string))
            }
    , day =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "day"
            , annotation = Just Type.int
            }
    , hour =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "hour"
            , annotation = Just Type.int
            }
    , minute =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "minute"
            , annotation = Just Type.int
            }
    , second =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "second"
            , annotation = Just Type.int
            }
    , getDurationString =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "getDurationString"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    , masteryXpBadge =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "masteryXpBadge"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "Utils" ]
                         "Html"
                         [ Type.var "msg" ]
                    )
            }
    , skillXpBadge =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "skillXpBadge"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Utils" ]
                             "Skill"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Utils" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , floatToString =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "floatToString"
            , annotation =
                Just (Type.function [ Type.int, Type.float ] Type.string)
            }
    , intToString =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils" ]
            , name = "intToString"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    }