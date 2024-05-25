module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Case
import Gen.CodeGen.Generate as Generate


main : Program {} () ()
main =
    Generate.run
        [ file
        ]


file : Elm.File
file =
    Elm.file [ "IdleGame.Kinds" ]
        (List.concat
            [ [ Elm.comment "!! Generated code, do not edit by hand !!" ]
            , [ Elm.comment "Resources" ]
            , getDeclarations "Resource" "Resources" resources
            , [ Elm.comment "Skills" ]
            , getDeclarations "Skill" "Skills" skills
            , [ Elm.comment "Activities" ]
            , getDeclarations "Activity" "Activities" activities
            , [ Elm.comment "Shop Upgrades" ]
            , getDeclarations "ShopUpgrade" "ShopUpgrades" shopUpgrades
            ]
        )


uncapitalize : String -> String
uncapitalize s =
    case s of
        "" ->
            ""

        _ ->
            String.toLower (String.left 1 s) ++ String.dropLeft 1 s


getDeclarations : String -> String -> List String -> List Elm.Declaration
getDeclarations category categoryPlural names =
    let
        namesUncapitalized =
            List.map uncapitalize names

        getByKind : Elm.Expression
        getByKind =
            Elm.withType
                (Type.function
                    [ Type.named [] category
                    , Type.namedWith [] (category ++ "Record") [ Type.var "a" ]
                    ]
                    (Type.var "a")
                )
                (Elm.fn2 ( "kind", Nothing )
                    ( "data", Nothing )
                    (\kind data ->
                        Elm.Case.custom kind
                            (Type.named [] category)
                            (List.map
                                (\n -> Elm.Case.branch0 n (Elm.get (uncapitalize n) data))
                                names
                            )
                    )
                )

        setByKind : Elm.Expression
        setByKind =
            Elm.withType
                (Type.function
                    [ Type.named [] category
                    , Type.var "a"
                    , Type.namedWith [] (category ++ "Record") [ Type.var "a" ]
                    ]
                    (Type.namedWith [] (category ++ "Record") [ Type.var "a" ])
                )
                (Elm.fn3 ( "kind", Nothing )
                    ( "value", Nothing )
                    ( "data", Nothing )
                    (\kind value data ->
                        Elm.Case.custom kind
                            (Type.named [] category)
                            (List.map
                                (\n -> Elm.Case.branch0 n (Elm.updateRecord [ ( uncapitalize n, value ) ] data))
                                names
                            )
                    )
                )
    in
    [ Elm.customType category (List.map Elm.variant names)
    , Elm.declaration ("all" ++ categoryPlural) <|
        Elm.withType (Type.list (Type.named [] category))
            (Elm.list (List.map Elm.val names))
    , Elm.alias (category ++ "Record")
        (Type.record
            (List.map (\n -> ( n, Type.var "a" )) namesUncapitalized)
        )
    , Elm.declaration (uncapitalize category ++ "Record") <|
        Elm.withType (Type.function [ Type.var "a" ] (Type.namedWith [] (category ++ "Record") [ Type.var "a" ]))
            (Elm.fn ( "a", Nothing )
                (\a -> Elm.record (List.map (\n -> ( n, a )) namesUncapitalized))
            )
    , Elm.declaration ("getBy" ++ category) getByKind
    , Elm.declaration ("setBy" ++ category) setByKind

    ]



-- Resources

resources : List String
resources =
    [ "Knowledge"
    ]



-- Skills


skills : List String
skills =
    [ "Anatomy"
    , "MedicalEthics"
    ]


activities : List String
activities =
    [ "GrossAnatomy"
    , "Neuroanatomy"
    ]


shopUpgrades : List String
shopUpgrades =
    [ "Glasses"
    ]

