module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Case
import Elm.Let
import Gen.CodeGen.Generate as Generate
import Gen.Duration
import Gen.IdleGame.Coin
import Gen.IdleGame.Views.Icon
import Gen.List
import Json.Decode
import Json.Decode.Extra


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
            , [ Elm.comment "Skills" ]
            , getDeclarations "Skill" "Skills" (List.map (\configObject -> capitalize configObject.id) flags.skillConfig)
            , skillStats flags.skillConfig
            , [ Elm.comment "Activities" ]
            , getDeclarations "Activity" "Activities" (List.map (\configObject -> capitalize configObject.id) flags.activityConfig)
            , activityStats flags.activityConfig
            , [ Elm.comment "Resources" ]
            , getDeclarations "Resource" "Resources" (List.map (\configObject -> capitalize configObject.id) flags.resourceConfig)
            , resourceStats flags.resourceConfig
            , [ Elm.comment "AcademicTests" ]
            , [ academicTestCategoryDeclaration ]
            , getDeclarations "AcademicTest" "AcademicTests" (List.map (\configObject -> capitalize configObject.id) flags.academicTestConfig)
            , academicTestStats flags.academicTestConfig
            , [ Elm.comment "Shop Upgrades" ]
            , getDeclarations "ShopUpgrade" "ShopUpgrades" [ "Glasses" ]
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


decodeMaybeString : Json.Decode.Decoder (Maybe String)
decodeMaybeString =
    let
        strToMaybe : String -> Maybe String
        strToMaybe s =
            if s == "" then
                Nothing

            else
                Just s
    in
    Json.Decode.map strToMaybe Json.Decode.string


decodeMaybeInt : Json.Decode.Decoder (Maybe Int)
decodeMaybeInt =
    Json.Decode.oneOf
        [ Json.Decode.map Just Json.Decode.int
        , Json.Decode.succeed Nothing
        ]


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

        mapKind : Elm.Expression
        mapKind =
            Elm.withType
                (Type.function
                    [ Type.function [ Type.var "a" ] (Type.var "a")
                    , Type.namedWith [] (category ++ "Record") [ Type.var "a" ]
                    ]
                    (Type.namedWith [] (category ++ "Record") [ Type.var "a" ])
                )
                (Elm.fn2 ( "fn", Nothing )
                    ( "record", Nothing )
                    (\fn record ->
                        Elm.Let.letIn
                            (\foldFn -> Gen.List.call_.foldl foldFn record (Elm.val ("all" ++ categoryPlural)))
                            |> Elm.Let.value "foldFn"
                                (Elm.fn2 ( "el", Nothing )
                                    ( "accum", Nothing )
                                    (\el accum ->
                                        -- Elm.apply (Elm.val ("setBy" ++ category)) [ el, Elm.apply fn [ Elm.apply (Elm.val ("getBy" ++ category)) [ el, accum ] ], accum ]
                                        Elm.apply (Elm.val ("setBy" ++ category)) [ el, Elm.apply fn [ Elm.apply (Elm.val ("getBy" ++ category)) [ el, accum ] ], accum ]
                                     -- Elm.apply (Elm.val ("setBy" ++ category)) [ el, el, accum ]
                                    )
                                )
                            |> Elm.Let.toExpression
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
    , Elm.declaration ("map" ++ categoryPlural) mapKind
    ]



-- Skills


getStats : String -> Type.Annotation -> (a -> ( String, Elm.Expression )) -> List a -> List Elm.Declaration
getStats title annotation fn objects =
    [ Elm.alias (title ++ "Stats")
        annotation
    , Elm.declaration (uncapitalize title ++ "Stats") <|
        Elm.withType (Type.namedWith [] (title ++ "Record") [ Type.named [] (title ++ "Stats") ])
            (Elm.record (List.map fn objects))
    , Elm.declaration ("get" ++ title ++ "Stats") <|
        Elm.withType (Type.function [ Type.named [] (uncapitalize title) ] (Type.named [] (title ++ "Stats")))
            (Elm.fn ( "kind", Nothing )
                (\kind ->
                    Elm.apply (Elm.val ("getBy" ++ title)) [ kind, Elm.val (uncapitalize title ++ "Stats") ]
                )
            )
    ]


iconImport : String -> Elm.Expression
iconImport icon =
    Elm.value { importFrom = [ "IdleGame", "Views", "Icon" ], name = icon, annotation = Nothing }


skillStats : List SkillConfigObject -> List Elm.Declaration
skillStats skillConfigResult =
    let
        skillStatsType : Type.Annotation
        skillStatsType =
            Type.record
                [ ( "title", Type.string )
                , ( "icon", Gen.IdleGame.Views.Icon.annotation_.icon )
                ]

        toExpression : SkillConfigObject -> Elm.Expression
        toExpression skillConfig =
            Elm.record
                [ ( "title", Elm.string skillConfig.title )
                , ( "icon", iconImport skillConfig.icon )
                ]
    in
    getStats "Skill"
        skillStatsType
        (\skillConfig -> ( skillConfig.id, toExpression skillConfig ))
        skillConfigResult


activityStats : List ActivityConfigObject -> List Elm.Declaration
activityStats activityConfigObjects =
    let
        activityStatsType : Type.Annotation
        activityStatsType =
            Type.record
                [ ( "skill", Type.named [] "Skill" )
                , ( "title", Type.string )
                , ( "image", Type.string )
                , ( "level", Type.int )
                , ( "duration", Gen.Duration.annotation_.duration )
                , ( "knowledge", Type.maybe Type.int )
                , ( "type_", Type.string )
                , ( "coin", Type.maybe Type.int )
                , ( "uniqueReward", Type.maybe (Type.named [] "Resource") )
                ]

        toExpression : ActivityConfigObject -> Elm.Expression
        toExpression activityConfig =
            Elm.record
                [ ( "skill", Elm.val (capitalize activityConfig.skill) )
                , ( "title", Elm.string activityConfig.title )
                , ( "image", Elm.string activityConfig.image )
                , ( "level", Elm.int activityConfig.level )
                , ( "duration", Gen.Duration.call_.seconds (Elm.int activityConfig.duration) )
                , ( "knowledge"
                  , activityConfig.knowledge
                        |> Maybe.map Elm.int
                        |> Elm.maybe
                  )
                , ( "type_", Elm.string activityConfig.type_ )
                , ( "coin"
                  , activityConfig.coin
                        |> Maybe.map Elm.int
                        |> Elm.maybe
                  )
                , ( "uniqueReward"
                  , activityConfig.uniqueReward
                        |> Maybe.map (capitalize >> Elm.val)
                        |> Elm.maybe
                  )
                ]
    in
    getStats "Activity"
        activityStatsType
        (\activityConfig -> ( activityConfig.id, toExpression activityConfig ))
        activityConfigObjects


resourceStats : List ResourceConfigObject -> List Elm.Declaration
resourceStats resourceConfigObjects =
    let
        toExpression : ResourceConfigObject -> Elm.Expression
        toExpression resourceConfig =
            Elm.record <|
                [ ( "title", Elm.string resourceConfig.title )
                , ( "icon", Gen.IdleGame.Views.Icon.call_.createIconPublic (Elm.string resourceConfig.icon) )
                , ( "price", Elm.maybe (Maybe.map Gen.IdleGame.Coin.int resourceConfig.price) )

                -- , ( "reducedBy", Elm.maybe (Maybe.map Elm.val (Maybe.map capitalize resourceConfig.reducedBy)) )
                , ( "reducedBy", Elm.maybe (Maybe.map (capitalize >> Elm.val) resourceConfig.reducedBy) )
                ]
    in
    getStats "Resource"
        (Type.record
            [ ( "title", Type.string )
            , ( "icon", Gen.IdleGame.Views.Icon.annotation_.icon )
            , ( "price", Type.maybe Gen.IdleGame.Coin.annotation_.coin )
            , ( "reducedBy", Type.maybe (Type.named [] "Resource") )
            ]
        )
        (\resourceConfig -> ( resourceConfig.id, toExpression resourceConfig ))
        resourceConfigObjects


academicTestCategoryDeclaration : Elm.Declaration
academicTestCategoryDeclaration =
    Elm.customType "AcademicTestCategory" [ Elm.variant "Quiz", Elm.variant "ShelfExam", Elm.variant "UsmleStep1" ]


academicTestStats : List AcademicTestConfigObject -> List Elm.Declaration
academicTestStats academicTestConfigObjects =
    let
        toExpression : AcademicTestConfigObject -> Elm.Expression
        toExpression academicTestConfig =
            Elm.record
                [ ( "title", Elm.string academicTestConfig.title )
                , ( "category", academicTestConfig.category )
                , ( "rewardCoin", Elm.maybe (Maybe.map Gen.IdleGame.Coin.int academicTestConfig.rewardCoin) )
                , ( "rewardResource"
                  , Elm.maybe
                        (Maybe.map
                            (\rewardResource ->
                                Elm.record
                                    [ ( "resource", Elm.val (capitalize rewardResource.resource) )
                                    , ( "amount", Elm.int rewardResource.amount )
                                    ]
                            )
                            academicTestConfig.rewardResource
                        )
                  )
                , ( "costs"
                  , Elm.list
                        (List.map
                            (\resourceAndAmount ->
                                Elm.record
                                    [ ( "resource", Elm.val (capitalize resourceAndAmount.resource) )
                                    , ( "amount", Elm.int resourceAndAmount.amount )
                                    ]
                            )
                            academicTestConfig.costs
                        )
                  )
                , ( "lockedBy"
                  , Elm.maybe
                        (Maybe.map
                            (\lockedBy -> Elm.val (capitalize lockedBy))
                            academicTestConfig.lockedBy
                        )
                  )
                ]
    in
    getStats "AcademicTest"
        (Type.record
            [ ( "title", Type.string )
            , ( "category", Type.named [] "AcademicTestCategory" )
            , ( "rewardCoin", Type.maybe Gen.IdleGame.Coin.annotation_.coin )
            , ( "rewardResource"
              , Type.maybe
                    (Type.record
                        [ ( "resource", Type.named [] "Resource" )
                        , ( "amount", Type.int )
                        ]
                    )
              )
            , ( "costs"
              , Type.list
                    (Type.record
                        [ ( "resource", Type.named [] "Resource" )
                        , ( "amount", Type.int )
                        ]
                    )
              )
            , ( "lockedBy", Type.maybe (Type.named [] "AcademicTest") )
            ]
        )
        (\academicTestConfig -> ( academicTestConfig.id, toExpression academicTestConfig ))
        academicTestConfigObjects



-- Decode flags


type alias SkillConfigObject =
    { id : String
    , title : String
    , icon : String
    }


type alias ActivityConfigObject =
    { id : String
    , skill : String
    , title : String
    , image : String
    , level : Int
    , duration : Int
    , knowledge : Maybe Int
    , type_ : String
    , coin : Maybe Int
    , uniqueReward : Maybe String
    }


type alias ResourceConfigObject =
    { id : String
    , title : String
    , icon : String
    , price : Maybe Int
    , reducedBy : Maybe String
    }


type alias ResourceAndAmount =
    { resource : String
    , amount : Int
    }


type alias AcademicTestConfigObject =
    { id : String
    , title : String
    , category : Elm.Expression
    , rewardCoin : Maybe Int
    , rewardResource : Maybe ResourceAndAmount
    , costs : List ResourceAndAmount
    , lockedBy : Maybe String
    }


type alias Flags =
    { skillConfig : List SkillConfigObject
    , activityConfig : List ActivityConfigObject
    , resourceConfig : List ResourceConfigObject
    , academicTestConfig : List AcademicTestConfigObject
    }


flagsDecoder : Json.Decode.Decoder Flags
flagsDecoder =
    Json.Decode.map4 Flags
        (Json.Decode.field "skillConfig" (Json.Decode.list skillConfigDecoder))
        (Json.Decode.field "activityConfig" (Json.Decode.list activityConfigDecoder))
        (Json.Decode.field "resourceConfig" (Json.Decode.list resourceConfigDecoder))
        (Json.Decode.field "academicTestConfig" (Json.Decode.list academicTestConfigDecoder))


skillConfigDecoder : Json.Decode.Decoder SkillConfigObject
skillConfigDecoder =
    Json.Decode.map3 SkillConfigObject
        (Json.Decode.field "id" Json.Decode.string)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "icon" Json.Decode.string)


activityConfigDecoder : Json.Decode.Decoder ActivityConfigObject
activityConfigDecoder =
    Json.Decode.succeed ActivityConfigObject
        |> Json.Decode.Extra.andMap (Json.Decode.field "id" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "skill" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "title" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "image" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "level" Json.Decode.int)
        |> Json.Decode.Extra.andMap (Json.Decode.field "duration" Json.Decode.int)
        |> Json.Decode.Extra.andMap (Json.Decode.field "knowledge" decodeMaybeInt)
        |> Json.Decode.Extra.andMap (Json.Decode.field "type" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "coin" (Json.Decode.maybe Json.Decode.int))
        |> Json.Decode.Extra.andMap (Json.Decode.field "uniqueReward" decodeMaybeString)


resourceConfigDecoder : Json.Decode.Decoder ResourceConfigObject
resourceConfigDecoder =
    Json.Decode.map5 ResourceConfigObject
        (Json.Decode.field "id" Json.Decode.string)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "icon" Json.Decode.string)
        (Json.Decode.maybe (Json.Decode.field "price" Json.Decode.int))
        (Json.Decode.field "reducedBy" decodeMaybeString)


academicTestConfigDecoder : Json.Decode.Decoder AcademicTestConfigObject
academicTestConfigDecoder =
    let
        resourceAndAmountDecoder : Json.Decode.Decoder ResourceAndAmount
        resourceAndAmountDecoder =
            Json.Decode.string
                |> Json.Decode.andThen
                    (\str ->
                        case String.split ":" str of
                            [ resourceId, amount ] ->
                                case String.toInt amount of
                                    Just amountInt ->
                                        Json.Decode.succeed (ResourceAndAmount resourceId amountInt)

                                    Nothing ->
                                        Json.Decode.fail "Invalid resource and amount format"

                            _ ->
                                Json.Decode.fail "Invalid resource and amount format"
                    )

        academicTestCostsDecoder : Json.Decode.Decoder (List ResourceAndAmount)
        academicTestCostsDecoder =
            Json.Decode.map6 (\a b c d e f -> [ a, b, c, d, e, f ] |> List.filterMap identity)
                (Json.Decode.maybe (Json.Decode.field "cost1" resourceAndAmountDecoder))
                (Json.Decode.maybe (Json.Decode.field "cost2" resourceAndAmountDecoder))
                (Json.Decode.maybe (Json.Decode.field "cost3" resourceAndAmountDecoder))
                (Json.Decode.maybe (Json.Decode.field "cost4" resourceAndAmountDecoder))
                (Json.Decode.maybe (Json.Decode.field "cost5" resourceAndAmountDecoder))
                (Json.Decode.maybe (Json.Decode.field "cost6" resourceAndAmountDecoder))

        academicTestCategoryDecoder : Json.Decode.Decoder Elm.Expression
        academicTestCategoryDecoder =
            Json.Decode.string
                |> Json.Decode.andThen
                    (\str ->
                        case str of
                            "quiz" ->
                                Json.Decode.succeed (Elm.val "Quiz")

                            "shelfExam" ->
                                Json.Decode.succeed (Elm.val "ShelfExam")

                            "usmleStep1" ->
                                Json.Decode.succeed (Elm.val "UsmleStep1")

                            _ ->
                                Json.Decode.fail ("Invalid category: " ++ str)
                    )
    in
    Json.Decode.map7 AcademicTestConfigObject
        (Json.Decode.field "id" Json.Decode.string)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "category" academicTestCategoryDecoder)
        (Json.Decode.field "rewardCoin" decodeMaybeInt)
        (Json.Decode.maybe (Json.Decode.field "rewardResource" resourceAndAmountDecoder))
        academicTestCostsDecoder
        (Json.Decode.field "lockedBy" decodeMaybeString)
