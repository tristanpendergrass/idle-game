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
            , [ Elm.comment "Spells" ]
            , getDeclarations "Spell" "Spells" spells
            , [ Elm.comment "Locations" ]
            , getDeclarations "Location" "Locations" locations
            , [ Elm.comment "Monsters" ]
            , getDeclarations "Monster" "Monsters" monsters
            , [ Elm.comment "Shop Upgrades" ]
            , getDeclarations "ShopUpgrade" "ShopUpgrades" shopUpgrades
            , [ Elm.comment "Quests" ]
            , getDeclarations "Quest" "Quests" quests
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

    -- Commented out "updateByKind" since getting weird error that seems like it may be an elm-codegen bug?
    -- , Elm.declaration ("updateBy" ++ category) <|
    --     Elm.withType
    --         (Type.function
    --             [ Type.named [] category
    --             , Type.function [ Type.var "a" ] (Type.var "a")
    --             , Type.namedWith [] (category ++ "Record") [ Type.var "a" ]
    --             ]
    --             (Type.namedWith [] (category ++ "Record") [ Type.var "a" ])
    --         )
    --         (Elm.fn3 ( "kind", Nothing )
    --             ( "f", Nothing )
    --             ( "data", Nothing )
    --             (\kind f data ->
    --                 Elm.apply setByKind
    --                     [ kind
    --                     , Elm.apply f [ Elm.apply getByKind [ kind, data ] ]
    --                     , data
    --                     ]
    --             )
    --         )
    ]



-- Resources


resources : List String
resources =
    [ "Manure"
    , "Soot"
    , "GreenhouseDirt"
    , "WashWater"
    , "EmptyBottle"
    , "Scrap"
    , "Ectoplasm"
    , "Parchment"
    ]



-- Skills


skills : List String
skills =
    [ "Chores"
    , "Hexes"
    , "Weathermancing"
    ]


activities : List String
activities =
    [ "CleanStables"
    , "CleanBigBubba"
    , "SweepChimneys"
    , "WaterGreenhousePlants"
    , "WashAndIronRobes"
    , "OrganizePotionIngredients"
    , "RepairInstruments"
    , "FlushDrainDemons"
    , "OrganizeSpellBooks"
    , "StudyHex1"
    , "StudyJinx1"
    , "StudyCurse1"
    , "StudyHex2"
    , "StudyJinx2"
    , "StudyCurse2"
    , "StudyHex3"
    , "StudyJinx3"
    , "StudyCurse3"
    , "ExploreSchoolGrounds"
    , "ExploreSecretGarden"
    , "FightPrefect"
    , "FightBookWyrm"
    , "FightWhisperingWind"
    , "StudyWind"
    , "StudyWater"
    , "StudySun"
    ]


spells : List String
spells =
    [ "Hex1"
    , "Hex2"
    , "Hex3"
    , "Jinx1"
    , "Jinx2"
    , "Jinx3"
    , "Curse1"
    , "Curse2"
    , "Curse3"
    , "Wind"
    , "Water"
    , "Sun"
    ]


locations : List String
locations =
    [ "SchoolGrounds"
    , "SecretGarden"
    ]


monsters : List String
monsters =
    [ "Prefect"
    , "BookWyrm"
    , "WhisperingWind"
    ]


shopUpgrades : List String
shopUpgrades =
    [ "Shovel"
    , "Book"
    , "Keyring"
    , "ReadingGlasses"
    , "OversizedBag"
    ]


quests : List String
quests =
    [ "MendCrackedBell"
    , "ChopFirewood"
    ]
