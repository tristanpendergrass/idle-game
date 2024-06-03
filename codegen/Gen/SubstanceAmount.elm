module Gen.SubstanceAmount exposing (annotation_, call_, centimoles, decimoles, gigamoles, inCentimoles, inDecimoles, inGigamoles, inKilomoles, inMegamoles, inMicromoles, inMillimoles, inMoles, inNanomoles, inPicomoles, kilomoles, megamoles, micromoles, millimoles, moduleName_, moles, nanomoles, picomoles, values_)

{-| 
@docs moduleName_, moles, inMoles, picomoles, inPicomoles, nanomoles, inNanomoles, micromoles, inMicromoles, millimoles, inMillimoles, centimoles, inCentimoles, decimoles, inDecimoles, kilomoles, inKilomoles, megamoles, inMegamoles, gigamoles, inGigamoles, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "SubstanceAmount" ]


{-| Construct a substance amount from a number of moles.

moles: Float -> SubstanceAmount.SubstanceAmount
-}
moles : Float -> Elm.Expression
moles molesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "moles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float molesArg ]


{-| Convert a substance amount to a number of moles.

inMoles: SubstanceAmount.SubstanceAmount -> Float
-}
inMoles : Elm.Expression -> Elm.Expression
inMoles inMolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inMoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inMolesArg ]


{-| Construct a substance amount from a number of picomoles.

picomoles: Float -> SubstanceAmount.SubstanceAmount
-}
picomoles : Float -> Elm.Expression
picomoles picomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "picomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float picomolesArg ]


{-| Convert a substance amount to a number of picomoles.

inPicomoles: SubstanceAmount.SubstanceAmount -> Float
-}
inPicomoles : Elm.Expression -> Elm.Expression
inPicomoles inPicomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inPicomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inPicomolesArg ]


{-| Construct a substance amount from a number of nanomoles.

nanomoles: Float -> SubstanceAmount.SubstanceAmount
-}
nanomoles : Float -> Elm.Expression
nanomoles nanomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "nanomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float nanomolesArg ]


{-| Convert a substance amount to a number of nanomoles.

inNanomoles: SubstanceAmount.SubstanceAmount -> Float
-}
inNanomoles : Elm.Expression -> Elm.Expression
inNanomoles inNanomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inNanomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inNanomolesArg ]


{-| Construct a substance amount from a number of micromoles.

micromoles: Float -> SubstanceAmount.SubstanceAmount
-}
micromoles : Float -> Elm.Expression
micromoles micromolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "micromoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float micromolesArg ]


{-| Convert a substance amount to a number of micromoles.

inMicromoles: SubstanceAmount.SubstanceAmount -> Float
-}
inMicromoles : Elm.Expression -> Elm.Expression
inMicromoles inMicromolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inMicromoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inMicromolesArg ]


{-| Construct a substance amount from a number of millimoles.

millimoles: Float -> SubstanceAmount.SubstanceAmount
-}
millimoles : Float -> Elm.Expression
millimoles millimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "millimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float millimolesArg ]


{-| Convert a substance amount to a number of millimoles.

inMillimoles: SubstanceAmount.SubstanceAmount -> Float
-}
inMillimoles : Elm.Expression -> Elm.Expression
inMillimoles inMillimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inMillimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inMillimolesArg ]


{-| Construct a substance amount from a number of centimoles.

centimoles: Float -> SubstanceAmount.SubstanceAmount
-}
centimoles : Float -> Elm.Expression
centimoles centimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "centimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float centimolesArg ]


{-| Convert a substance amount to a number of centimoles.

inCentimoles: SubstanceAmount.SubstanceAmount -> Float
-}
inCentimoles : Elm.Expression -> Elm.Expression
inCentimoles inCentimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inCentimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inCentimolesArg ]


{-| Construct a substance amount from a number of decimoles.

decimoles: Float -> SubstanceAmount.SubstanceAmount
-}
decimoles : Float -> Elm.Expression
decimoles decimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "decimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float decimolesArg ]


{-| Convert a substance amount to a number of decimoles.

inDecimoles: SubstanceAmount.SubstanceAmount -> Float
-}
inDecimoles : Elm.Expression -> Elm.Expression
inDecimoles inDecimolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inDecimoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inDecimolesArg ]


{-| Construct a substance amount from a number of kilomoles.

kilomoles: Float -> SubstanceAmount.SubstanceAmount
-}
kilomoles : Float -> Elm.Expression
kilomoles kilomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "kilomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float kilomolesArg ]


{-| Convert a substance amount to a number of kilomoles.

inKilomoles: SubstanceAmount.SubstanceAmount -> Float
-}
inKilomoles : Elm.Expression -> Elm.Expression
inKilomoles inKilomolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inKilomoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inKilomolesArg ]


{-| Construct a substance amount from a number of megamoles.

megamoles: Float -> SubstanceAmount.SubstanceAmount
-}
megamoles : Float -> Elm.Expression
megamoles megamolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "megamoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float megamolesArg ]


{-| Convert a substance amount to a number of megamoles.

inMegamoles: SubstanceAmount.SubstanceAmount -> Float
-}
inMegamoles : Elm.Expression -> Elm.Expression
inMegamoles inMegamolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inMegamoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inMegamolesArg ]


{-| Construct a substance amount from a number of gigamoles.

gigamoles: Float -> SubstanceAmount.SubstanceAmount
-}
gigamoles : Float -> Elm.Expression
gigamoles gigamolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "gigamoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "SubstanceAmount" ]
                               "SubstanceAmount"
                               []
                          )
                     )
             }
        )
        [ Elm.float gigamolesArg ]


{-| Convert a substance amount to a number of gigamoles.

inGigamoles: SubstanceAmount.SubstanceAmount -> Float
-}
inGigamoles : Elm.Expression -> Elm.Expression
inGigamoles inGigamolesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SubstanceAmount" ]
             , name = "inGigamoles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inGigamolesArg ]


annotation_ : { substanceAmount : Type.Annotation, moles : Type.Annotation }
annotation_ =
    { substanceAmount =
        Type.alias
            moduleName_
            "SubstanceAmount"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "SubstanceAmount" ] "Moles" [] ]
            )
    , moles = Type.namedWith [ "SubstanceAmount" ] "Moles" []
    }


call_ :
    { moles : Elm.Expression -> Elm.Expression
    , inMoles : Elm.Expression -> Elm.Expression
    , picomoles : Elm.Expression -> Elm.Expression
    , inPicomoles : Elm.Expression -> Elm.Expression
    , nanomoles : Elm.Expression -> Elm.Expression
    , inNanomoles : Elm.Expression -> Elm.Expression
    , micromoles : Elm.Expression -> Elm.Expression
    , inMicromoles : Elm.Expression -> Elm.Expression
    , millimoles : Elm.Expression -> Elm.Expression
    , inMillimoles : Elm.Expression -> Elm.Expression
    , centimoles : Elm.Expression -> Elm.Expression
    , inCentimoles : Elm.Expression -> Elm.Expression
    , decimoles : Elm.Expression -> Elm.Expression
    , inDecimoles : Elm.Expression -> Elm.Expression
    , kilomoles : Elm.Expression -> Elm.Expression
    , inKilomoles : Elm.Expression -> Elm.Expression
    , megamoles : Elm.Expression -> Elm.Expression
    , inMegamoles : Elm.Expression -> Elm.Expression
    , gigamoles : Elm.Expression -> Elm.Expression
    , inGigamoles : Elm.Expression -> Elm.Expression
    }
call_ =
    { moles =
        \molesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "moles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ molesArg ]
    , inMoles =
        \inMolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inMoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMolesArg ]
    , picomoles =
        \picomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "picomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ picomolesArg ]
    , inPicomoles =
        \inPicomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inPicomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPicomolesArg ]
    , nanomoles =
        \nanomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "nanomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ nanomolesArg ]
    , inNanomoles =
        \inNanomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inNanomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inNanomolesArg ]
    , micromoles =
        \micromolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "micromoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ micromolesArg ]
    , inMicromoles =
        \inMicromolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inMicromoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMicromolesArg ]
    , millimoles =
        \millimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "millimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ millimolesArg ]
    , inMillimoles =
        \inMillimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inMillimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMillimolesArg ]
    , centimoles =
        \centimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "centimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ centimolesArg ]
    , inCentimoles =
        \inCentimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inCentimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inCentimolesArg ]
    , decimoles =
        \decimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "decimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ decimolesArg ]
    , inDecimoles =
        \inDecimolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inDecimoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDecimolesArg ]
    , kilomoles =
        \kilomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "kilomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ kilomolesArg ]
    , inKilomoles =
        \inKilomolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inKilomoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inKilomolesArg ]
    , megamoles =
        \megamolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "megamoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ megamolesArg ]
    , inMegamoles =
        \inMegamolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inMegamoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMegamolesArg ]
    , gigamoles =
        \gigamolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "gigamoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SubstanceAmount" ]
                                       "SubstanceAmount"
                                       []
                                  )
                             )
                     }
                )
                [ gigamolesArg ]
    , inGigamoles =
        \inGigamolesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SubstanceAmount" ]
                     , name = "inGigamoles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SubstanceAmount" ]
                                      "SubstanceAmount"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inGigamolesArg ]
    }


values_ :
    { moles : Elm.Expression
    , inMoles : Elm.Expression
    , picomoles : Elm.Expression
    , inPicomoles : Elm.Expression
    , nanomoles : Elm.Expression
    , inNanomoles : Elm.Expression
    , micromoles : Elm.Expression
    , inMicromoles : Elm.Expression
    , millimoles : Elm.Expression
    , inMillimoles : Elm.Expression
    , centimoles : Elm.Expression
    , inCentimoles : Elm.Expression
    , decimoles : Elm.Expression
    , inDecimoles : Elm.Expression
    , kilomoles : Elm.Expression
    , inKilomoles : Elm.Expression
    , megamoles : Elm.Expression
    , inMegamoles : Elm.Expression
    , gigamoles : Elm.Expression
    , inGigamoles : Elm.Expression
    }
values_ =
    { moles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "moles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inMoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inMoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , picomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "picomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inPicomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inPicomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , nanomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "nanomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inNanomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inNanomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , micromoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "micromoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inMicromoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inMicromoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , millimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "millimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inMillimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inMillimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , centimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "centimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inCentimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inCentimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , decimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "decimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inDecimoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inDecimoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , kilomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "kilomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inKilomoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inKilomoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , megamoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "megamoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inMegamoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inMegamoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    , gigamoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "gigamoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "SubstanceAmount" ]
                              "SubstanceAmount"
                              []
                         )
                    )
            }
    , inGigamoles =
        Elm.value
            { importFrom = [ "SubstanceAmount" ]
            , name = "inGigamoles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "SubstanceAmount" ]
                             "SubstanceAmount"
                             []
                         ]
                         Type.float
                    )
            }
    }