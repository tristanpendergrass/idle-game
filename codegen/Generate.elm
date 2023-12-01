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



-- allResources : List Resource
-- allResources =
--     -- Don't forget to add to `allSpells` when you add a spell here!
--     [ Manure
--     , Soot
--     , GreenhouseDirt
--     , WashWater
--     , EmptyBottle
--     , Scrap
--     , Ectoplasm
--     , Parchment
--     ]
-- -- Record
-- type alias Record a =
--     { manure : a
--     , soot : a
--     , greenhouseDirt : a
--     , washWater : a
--     , emptyBottles : a
--     , scrap : a
--     , ectoplasm : a
--     , parchment : a
--     }
-- createRecord : a -> Record a
-- createRecord a =
--     { manure = a
--     , soot = a
--     , greenhouseDirt = a
--     , washWater = a
--     , emptyBottles = a
--     , scrap = a
--     , ectoplasm = a
--     , parchment = a
--     }
-- getByKind : Resource -> Record a -> a
-- getByKind kind data =
--     case kind of
--         Manure ->
--             data.manure
--         Soot ->
--             data.soot
--         GreenhouseDirt ->
--             data.greenhouseDirt
--         WashWater ->
--             data.washWater
--         EmptyBottle ->
--             data.emptyBottles
--         Scrap ->
--             data.scrap
--         Ectoplasm ->
--             data.ectoplasm
--         Parchment ->
--             data.parchment


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


resourcesLowerCase : List String
resourcesLowerCase =
    List.map String.toLower resources


file : Elm.File
file =
    Elm.file [ "IdleGame.Kinds2" ]
        [ Elm.comment "!! Generated code, do not edit by hand !!"

        -- Resources
        , Elm.comment "Resources"
        , Elm.customType "Resource"
            (List.map Elm.variant resources)
        , Elm.declaration "allResources"
            (Elm.list (List.map Elm.val resources))
        , Elm.alias "ResourceRecord"
            (Type.record
                (List.map (\r -> ( r, Type.var "a" )) resourcesLowerCase)
            )
        , Elm.declaration "resourceRecord" <|
            Elm.withType (Type.function [ Type.var "a" ] (Type.namedWith [] "ResourceRecord" [ Type.var "a" ]))
                (Elm.fn ( "a", Nothing )
                    (\a -> Elm.record (List.map (\r -> ( r, a )) resourcesLowerCase))
                )
        , Elm.declaration "getByKindResource" <|
            Elm.withType (Type.function [ Type.named [] "Resource", Type.namedWith [] "ResourceRecord" [ Type.var "b" ] ] (Type.var "b"))
                (Elm.fn2 ( "kind", Nothing )
                    ( "data", Nothing )
                    (\kind data ->
                        Elm.Case.custom kind
                            (Type.named [] "Resource")
                            (List.map
                                (\r -> Elm.Case.branch0 r (Elm.get (String.toLower r) data))
                                resources
                            )
                    )
                )
        ]
