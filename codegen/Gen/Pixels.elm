module Gen.Pixels exposing (annotation_, call_, float, inPixels, inPixelsPerSecond, inPixelsPerSecondSquared, inSquarePixels, int, moduleName_, pixel, pixels, pixelsPerSecond, pixelsPerSecondSquared, squarePixels, toFloat, toInt, values_)

{-| 
@docs moduleName_, int, float, toInt, toFloat, pixels, inPixels, pixel, pixelsPerSecond, inPixelsPerSecond, pixelsPerSecondSquared, inPixelsPerSecondSquared, squarePixels, inSquarePixels, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pixels" ]


{-| Construct a quantity representing an integer number of on-screen pixels:

    screenWidth =
        Pixels.int 1920

int: Int -> Quantity.Quantity Int Pixels.Pixels
-}
int : Int -> Elm.Expression
int intArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int
                               , Type.namedWith [ "Pixels" ] "Pixels" []
                               ]
                          )
                     )
             }
        )
        [ Elm.int intArg ]


{-| Construct a quantity representing a floating-point number of on-screen
pixels:

    lineWeight =
        Pixels.float 1.5

float: Float -> Quantity.Quantity Float Pixels.Pixels
-}
float : Float -> Elm.Expression
float floatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "float"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith [ "Pixels" ] "Pixels" []
                               ]
                          )
                     )
             }
        )
        [ Elm.float floatArg ]


{-| Convert an integer number of pixels back into a plain `Int`:

    Pixels.int 1920
        |> Quantity.multiplyBy 2
        |> Pixels.toInt
    --> 3840

toInt: Quantity.Quantity Int Pixels.Pixels -> Int
-}
toInt : Elm.Expression -> Elm.Expression
toInt toIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "toInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                          ]
                          Type.int
                     )
             }
        )
        [ toIntArg ]


{-| Convert a floating-point number of pixels back into a plain `Float`:

    pixelDensity =
        Pixels.float 96 |> Quantity.per (Length.inches 1)

    Length.centimeters 1
        |> Quantity.at pixelDensity
        |> Pixels.toFloat
    --> 37.795275590551185

toFloat: Quantity.Quantity Float Pixels.Pixels -> Float
-}
toFloat : Elm.Expression -> Elm.Expression
toFloat toFloatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "toFloat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                          ]
                          Type.float
                     )
             }
        )
        [ toFloatArg ]


{-| Generic version of `Pixels.int`/`Pixels.float`, for consistency with other
modules like `Length`. Note that passing an `Int` will give you a

    Quantity Int Pixels

while passing a `Float` will give you a

    Quantity Float Pixels

If you pass a _literal_ integer like `1920`, you will get a generic `Quantity
number Pixels` which can be used as either an `Int` _or_ `Float` number of
pixels.

pixels: number -> Quantity.Quantity number Pixels.Pixels
-}
pixels : Elm.Expression -> Elm.Expression
pixels pixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "pixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "number" ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith [ "Pixels" ] "Pixels" []
                               ]
                          )
                     )
             }
        )
        [ pixelsArg ]


{-| Convert a `Pixels` value to a plain number of pixels. This is a generic
version of `Pixels.toInt`/`Pixels.toFloat`.

inPixels: Quantity.Quantity number Pixels.Pixels -> number
-}
inPixels : Elm.Expression -> Elm.Expression
inPixels inPixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "inPixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                          ]
                          (Type.var "number")
                     )
             }
        )
        [ inPixelsArg ]


{-| Shorthand for `Pixels.pixels 1`. Can be convenient to use with
[`Quantity.per`](Quantity#per).

pixel: Quantity.Quantity number Pixels.Pixels
-}
pixel : Elm.Expression
pixel =
    Elm.value
        { importFrom = [ "Pixels" ]
        , name = "pixel"
        , annotation =
            Just
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.var "number"
                     , Type.namedWith [ "Pixels" ] "Pixels" []
                     ]
                )
        }


{-| Construct an on-screen speed from a number of pixels per second.

pixelsPerSecond: Float -> Quantity.Quantity Float Pixels.PixelsPerSecond
-}
pixelsPerSecond : Float -> Elm.Expression
pixelsPerSecond pixelsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "pixelsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Pixels" ]
                                   "PixelsPerSecond"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.float pixelsPerSecondArg ]


{-| Convert an on-screen speed to a number of pixels per second.

    elapsedTime =
        Duration.milliseconds 16

    dragDistance =
        Pixels.float 2

    dragSpeed =
        dragDistance |> Quantity.per elapsedTime

    dragSpeed |> Pixels.inPixelsPerSecond
    --> 125

inPixelsPerSecond: Quantity.Quantity Float Pixels.PixelsPerSecond -> Float
-}
inPixelsPerSecond : Elm.Expression -> Elm.Expression
inPixelsPerSecond inPixelsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "inPixelsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Pixels" ] "PixelsPerSecond" []
                              ]
                          ]
                          Type.float
                     )
             }
        )
        [ inPixelsPerSecondArg ]


{-| Construct an on-screen acceleration from a number of pixels per second
squared.

pixelsPerSecondSquared: Float -> Quantity.Quantity Float Pixels.PixelsPerSecondSquared
-}
pixelsPerSecondSquared : Float -> Elm.Expression
pixelsPerSecondSquared pixelsPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "pixelsPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Pixels" ]
                                   "PixelsPerSecondSquared"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.float pixelsPerSecondSquaredArg ]


{-| Convert an on-screen acceleration to a number of pixels per second squared.

inPixelsPerSecondSquared: Quantity.Quantity Float Pixels.PixelsPerSecondSquared -> Float
-}
inPixelsPerSecondSquared : Elm.Expression -> Elm.Expression
inPixelsPerSecondSquared inPixelsPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "inPixelsPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Pixels" ]
                                    "PixelsPerSecondSquared"
                                    []
                              ]
                          ]
                          Type.float
                     )
             }
        )
        [ inPixelsPerSecondSquaredArg ]


{-| Construct an on-screen area from a number of square pixels.

squarePixels: number -> Quantity.Quantity number Pixels.SquarePixels
-}
squarePixels : Elm.Expression -> Elm.Expression
squarePixels squarePixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "squarePixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "number" ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith [ "Pixels" ] "SquarePixels" []
                               ]
                          )
                     )
             }
        )
        [ squarePixelsArg ]


{-| Convert an on-screen area to a number of square pixels.

    area =
        Pixels.int 1928 |> Quantity.times (Pixels.int 1080)

    area |> Pixels.inSquarePixels
    --> 2073600

inSquarePixels: Quantity.Quantity number Pixels.SquarePixels -> number
-}
inSquarePixels : Elm.Expression -> Elm.Expression
inSquarePixels inSquarePixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pixels" ]
             , name = "inSquarePixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Pixels" ] "SquarePixels" []
                              ]
                          ]
                          (Type.var "number")
                     )
             }
        )
        [ inSquarePixelsArg ]


annotation_ :
    { pixels : Type.Annotation
    , pixelsPerSecond : Type.Annotation
    , pixelsPerSecondSquared : Type.Annotation
    , squarePixels : Type.Annotation
    }
annotation_ =
    { pixels = Type.namedWith [ "Pixels" ] "Pixels" []
    , pixelsPerSecond =
        Type.alias
            moduleName_
            "PixelsPerSecond"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Pixels" ] "Pixels" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    , pixelsPerSecondSquared =
        Type.alias
            moduleName_
            "PixelsPerSecondSquared"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Pixels" ] "PixelsPerSecond" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    , squarePixels =
        Type.alias
            moduleName_
            "SquarePixels"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Squared"
                 [ Type.namedWith [ "Pixels" ] "Pixels" [] ]
            )
    }


call_ :
    { int : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    , toInt : Elm.Expression -> Elm.Expression
    , toFloat : Elm.Expression -> Elm.Expression
    , pixels : Elm.Expression -> Elm.Expression
    , inPixels : Elm.Expression -> Elm.Expression
    , pixelsPerSecond : Elm.Expression -> Elm.Expression
    , inPixelsPerSecond : Elm.Expression -> Elm.Expression
    , pixelsPerSecondSquared : Elm.Expression -> Elm.Expression
    , inPixelsPerSecondSquared : Elm.Expression -> Elm.Expression
    , squarePixels : Elm.Expression -> Elm.Expression
    , inSquarePixels : Elm.Expression -> Elm.Expression
    }
call_ =
    { int =
        \intArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int
                                       , Type.namedWith [ "Pixels" ] "Pixels" []
                                       ]
                                  )
                             )
                     }
                )
                [ intArg ]
    , float =
        \floatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "float"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith [ "Pixels" ] "Pixels" []
                                       ]
                                  )
                             )
                     }
                )
                [ floatArg ]
    , toInt =
        \toIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "toInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int
                                      , Type.namedWith [ "Pixels" ] "Pixels" []
                                      ]
                                  ]
                                  Type.int
                             )
                     }
                )
                [ toIntArg ]
    , toFloat =
        \toFloatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "toFloat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith [ "Pixels" ] "Pixels" []
                                      ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ toFloatArg ]
    , pixels =
        \pixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "pixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "number" ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith [ "Pixels" ] "Pixels" []
                                       ]
                                  )
                             )
                     }
                )
                [ pixelsArg ]
    , inPixels =
        \inPixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "inPixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith [ "Pixels" ] "Pixels" []
                                      ]
                                  ]
                                  (Type.var "number")
                             )
                     }
                )
                [ inPixelsArg ]
    , pixelsPerSecond =
        \pixelsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "pixelsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Pixels" ]
                                           "PixelsPerSecond"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ pixelsPerSecondArg ]
    , inPixelsPerSecond =
        \inPixelsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "inPixelsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Pixels" ]
                                            "PixelsPerSecond"
                                            []
                                      ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPixelsPerSecondArg ]
    , pixelsPerSecondSquared =
        \pixelsPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "pixelsPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Pixels" ]
                                           "PixelsPerSecondSquared"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ pixelsPerSecondSquaredArg ]
    , inPixelsPerSecondSquared =
        \inPixelsPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "inPixelsPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Pixels" ]
                                            "PixelsPerSecondSquared"
                                            []
                                      ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPixelsPerSecondSquaredArg ]
    , squarePixels =
        \squarePixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "squarePixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "number" ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Pixels" ]
                                           "SquarePixels"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ squarePixelsArg ]
    , inSquarePixels =
        \inSquarePixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pixels" ]
                     , name = "inSquarePixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Pixels" ]
                                            "SquarePixels"
                                            []
                                      ]
                                  ]
                                  (Type.var "number")
                             )
                     }
                )
                [ inSquarePixelsArg ]
    }


values_ :
    { int : Elm.Expression
    , float : Elm.Expression
    , toInt : Elm.Expression
    , toFloat : Elm.Expression
    , pixels : Elm.Expression
    , inPixels : Elm.Expression
    , pixel : Elm.Expression
    , pixelsPerSecond : Elm.Expression
    , inPixelsPerSecond : Elm.Expression
    , pixelsPerSecondSquared : Elm.Expression
    , inPixelsPerSecondSquared : Elm.Expression
    , squarePixels : Elm.Expression
    , inSquarePixels : Elm.Expression
    }
values_ =
    { int =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                         )
                    )
            }
    , float =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                         )
                    )
            }
    , toInt =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "toInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int
                             , Type.namedWith [ "Pixels" ] "Pixels" []
                             ]
                         ]
                         Type.int
                    )
            }
    , toFloat =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "toFloat"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Pixels" ] "Pixels" []
                             ]
                         ]
                         Type.float
                    )
            }
    , pixels =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "pixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "number" ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Pixels" ] "Pixels" []
                              ]
                         )
                    )
            }
    , inPixels =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "inPixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith [ "Pixels" ] "Pixels" []
                             ]
                         ]
                         (Type.var "number")
                    )
            }
    , pixel =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "pixel"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Quantity" ]
                         "Quantity"
                         [ Type.var "number"
                         , Type.namedWith [ "Pixels" ] "Pixels" []
                         ]
                    )
            }
    , pixelsPerSecond =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "pixelsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Pixels" ] "PixelsPerSecond" []
                              ]
                         )
                    )
            }
    , inPixelsPerSecond =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "inPixelsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Pixels" ] "PixelsPerSecond" []
                             ]
                         ]
                         Type.float
                    )
            }
    , pixelsPerSecondSquared =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "pixelsPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                  [ "Pixels" ]
                                  "PixelsPerSecondSquared"
                                  []
                              ]
                         )
                    )
            }
    , inPixelsPerSecondSquared =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "inPixelsPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Pixels" ]
                                   "PixelsPerSecondSquared"
                                   []
                             ]
                         ]
                         Type.float
                    )
            }
    , squarePixels =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "squarePixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "number" ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Pixels" ] "SquarePixels" []
                              ]
                         )
                    )
            }
    , inSquarePixels =
        Elm.value
            { importFrom = [ "Pixels" ]
            , name = "inSquarePixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith [ "Pixels" ] "SquarePixels" []
                             ]
                         ]
                         (Type.var "number")
                    )
            }
    }