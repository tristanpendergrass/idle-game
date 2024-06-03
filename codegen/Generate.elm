module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Case
import Gen.CodeGen.Generate as Generate
import Gen.Duration
import Gen.IdleGame.Views.Icon
import Json.Decode


main : Program Json.Decode.Value () ()
main =
    Generate.fromJson
        flagsDecoder
        (\flags ->
            [ file flags
            ]
        )


file : Flags -> Elm.File
file flags =
    Elm.file [ "IdleGame", "Kinds" ]
        (List.concat
            [ [ Elm.comment "!! Generated code, do not edit by hand !!" ]
            , [ Elm.comment "Resources" ]
            , getDeclarations "Resource" "Resources" resources
            , [ Elm.comment "Skills" ]
            , getDeclarations "Skill" "Skills" skills
            , skillStats flags.subjectConfig
            , [ Elm.comment "Activities" ]
            , getDeclarations "Activity" "Activities" activities
            , activityStats flags.activityConfig
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


capitalize : String -> String
capitalize s =
    case s of
        "" ->
            ""

        _ ->
            String.toUpper (String.left 1 s) ++ String.dropLeft 1 s


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
    [ "AnatomyK"
    , "AnatomyPk"
    , "BiochemistryK"
    , "BiochemistryPk"
    , "PhysiologyK"
    , "PhysiologyPk"
    , "PharmacologyK"
    , "PharmacologyPk"
    , "MicrobiologyK"
    , "MicrobiologyPk"
    , "PathologyK"
    , "PathologyPk"
    , "MedicalEthicsK"
    , "MedicalEthicsPk"
    ]



-- Skills


skills : List String
skills =
    [ "Anatomy"
    , "Biochemistry"
    , "Physiology"
    , "Pharmacology"
    , "Microbiology"
    , "Pathology"
    , "MedicalEthics"
    ]


activities : List String
activities =
    [ -- Anatomy
      "BackAndSpine"
    , "UpperLimb"
    , "LowerLimb"

    -- Biochemistry
    , "MetabolicPathways"
    , "Enzymology"
    , "MolecularBiology"

    -- Physiology
    , "CellularFunction"
    , "CardiovascularSystem"
    , "RespiratorySystem"

    -- Pharmacology
    -- , "Pharmacokinetics"
    -- , "Pharmacodynamics"
    -- , "Toxicology"
    -- Microbiology
    -- , "Bacteriology"
    -- , "Virology"
    -- , "Mycology"
    -- Pathology
    -- , "CellInjury"
    -- , "Inflammation"
    -- , "HemodynamicDisorders"
    -- Medical Ethics
    -- , "PrinciplesOfMedicalEthics"
    -- , "InformedConsent"
    -- , "ConfidentialityAndPrivacy"
    ]


shopUpgrades : List String
shopUpgrades =
    [ "Glasses"
    ]


stringToIcon : String -> Elm.Expression
stringToIcon str =
    Gen.IdleGame.Views.Icon.call_.createIconPublic (Elm.string str)


skillStats : List SkillConfigObject -> List Elm.Declaration
skillStats subjectConfigResult =
    [ Elm.alias "SkillStats"
        (Type.record
            [ ( "title", Type.string )
            , ( "icon", Gen.IdleGame.Views.Icon.annotation_.icon )
            ]
        )
    , Elm.declaration "skillStats" <|
        Elm.withType (Type.namedWith [] "SkillRecord" [ Type.named [] "SkillStats" ])
            (Elm.record
                (List.map
                    (\n -> ( n.id, Elm.record [ ( "title", Elm.string n.title ), ( "icon", stringToIcon n.icon ) ] ))
                    subjectConfigResult
                )
            )
    , Elm.declaration "getSkillStats" <|
        Elm.withType (Type.function [ Type.named [] "skill" ] (Type.named [] "SkillStats"))
            (Elm.fn ( "kind", Nothing )
                (\kind ->
                    Elm.Case.custom kind
                        (Type.named [] "kind")
                        (List.map
                            (\n ->
                                Elm.Case.branch0
                                    n.id
                                    (Elm.record [ ( "title", Elm.string n.title ), ( "icon", stringToIcon n.icon ) ])
                            )
                            subjectConfigResult
                        )
                )
            )
    ]


activityStats : List ActivityConfigObject -> List Elm.Declaration
activityStats activityConfigObjects =
    let
        toExpression : ActivityConfigObject -> Elm.Expression
        toExpression activityConfig =
            Elm.record <|
                [ ( "subject", Elm.val (capitalize activityConfig.subject) )
                , ( "title", Elm.string activityConfig.title )
                , ( "image", Elm.string activityConfig.image )
                , ( "level", Elm.int activityConfig.level )
                , ( "duration", Gen.Duration.call_.seconds (Elm.int activityConfig.duration) )
                , ( "knowledge", Elm.int activityConfig.knowledge )
                , ( "type_", Elm.string activityConfig.type_ )
                ]
    in
    [ Elm.alias "ActivityStats"
        (Type.record
            [ ( "subject", Type.named [] "Skill" )
            , ( "title", Type.string )
            , ( "image", Type.string )
            , ( "level", Type.int )
            , ( "duration", Gen.Duration.annotation_.duration )
            , ( "knowledge", Type.int )
            , ( "type_", Type.string )
            ]
        )
    , Elm.declaration "activityStats" <|
        Elm.withType (Type.namedWith [] "ActivityRecord" [ Type.named [] "ActivityStats" ])
            (Elm.record
                (List.map (\activityConfig -> ( activityConfig.id, toExpression activityConfig )) activityConfigObjects)
            )
    , Elm.declaration "getActivityStats" <|
        Elm.withType (Type.function [ Type.named [] "activity" ] (Type.named [] "ActivityStats"))
            (Elm.fn ( "kind", Nothing )
                (\kind ->
                    Elm.apply (Elm.val "getByActivity") [ kind, Elm.val "activityStats" ]
                )
            )

    -- , Elm.declaration "getActivityStats" <|
    --     Elm.withType (Type.function [ Type.named [] "skill" ] (Type.named [] "SkillStats"))
    --         (Elm.fn ( "kind", Nothing )
    --             (\kind ->
    --                 Elm.Case.custom kind
    --                     (Type.named [] "kind")
    --                     (List.map
    --                         (\n ->
    --                             Elm.Case.branch0
    --                                 n.id
    --                                 -- (Elm.record [ ( "title", Elm.string n.title ), ( "icon", stringToIcon n.icon ) ])
    --                                 (toExpression n)
    --                         )
    --                         activityConfigObjects
    --                     )
    --             )
    --         )
    ]



-- Decode flags


type alias SkillConfigObject =
    { id : String
    , title : String
    , icon : String
    }


type alias ActivityConfigObject =
    { id : String
    , subject : String
    , title : String
    , image : String
    , level : Int
    , duration : Int
    , knowledge : Int
    , type_ : String
    }


type alias Flags =
    { subjectConfig : List SkillConfigObject, activityConfig : List ActivityConfigObject }


flagsDecoder : Json.Decode.Decoder Flags
flagsDecoder =
    Json.Decode.map2 Flags
        (Json.Decode.field "subjectConfig" (Json.Decode.list subjectConfigDecoder))
        (Json.Decode.field "activityConfig" (Json.Decode.list activityConfigDecoder))


subjectConfigDecoder : Json.Decode.Decoder SkillConfigObject
subjectConfigDecoder =
    Json.Decode.map3 SkillConfigObject
        (Json.Decode.field "id" Json.Decode.string)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "icon" Json.Decode.string)


activityConfigDecoder : Json.Decode.Decoder ActivityConfigObject
activityConfigDecoder =
    Json.Decode.map8 ActivityConfigObject
        (Json.Decode.field "id" Json.Decode.string)
        (Json.Decode.field "subject" Json.Decode.string)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "image" Json.Decode.string)
        (Json.Decode.field "level" Json.Decode.int)
        (Json.Decode.field "duration" Json.Decode.int)
        (Json.Decode.field "knowledge" Json.Decode.int)
        (Json.Decode.field "type" Json.Decode.string)
