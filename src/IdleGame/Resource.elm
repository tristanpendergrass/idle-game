module IdleGame.Resource exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)
import Quantity exposing (Quantity(..))


type alias Diff =
    -- I don't know if it will always make sense for this type alias and Amounts to be the same shape but for now it is and saves us work
    ResourceRecord Int


add : Resource -> Int -> ResourceRecord Int -> Result EffectErr (ResourceRecord Int)
add resource amount resources =
    let
        oldAmount : Int
        oldAmount =
            getByResource resource resources

        newAmount : Int
        newAmount =
            oldAmount + amount
    in
    if newAmount >= 0 then
        Ok (setByResource resource newAmount resources)

    else
        Err EffectErr.NegativeAmount


getDiff : { original : ResourceRecord Int, current : ResourceRecord Int } -> Diff
getDiff { original, current } =
    -- TODO: improvements definitely possible here. Make Diff a List with only elements that were different present? Automate so we dont have to modify this function when adding new Kinds of resources?
    { anatomyK = getByResource AnatomyK current - getByResource AnatomyK original
    , biochemistryK = getByResource BiochemistryK current - getByResource BiochemistryK original
    , physiologyK = getByResource PhysiologyK current - getByResource PhysiologyK original
    , pharmacologyK = getByResource PharmacologyK current - getByResource PharmacologyK original
    , microbiologyK = getByResource MicrobiologyK current - getByResource MicrobiologyK original
    , pathologyK = getByResource PathologyK current - getByResource PathologyK original
    , medicalEthicsK = getByResource MedicalEthicsK current - getByResource MedicalEthicsK original
    }


mapDiff : (Int -> Resource -> a) -> ResourceRecord Int -> List a
mapDiff fn diff =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByResource resource diff
                in
                fn amount resource
            )


isEmptyDiff : Diff -> Bool
isEmptyDiff resourcesDiff =
    allResources
        |> List.map (\resource -> getByResource resource resourcesDiff)
        |> List.all ((==) 0)


mapResources : (Int -> Resource -> a) -> ResourceRecord Int -> List a
mapResources fn resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByResource resource resources
                in
                fn amount resource
            )


toList : ResourceRecord Int -> List ( Resource, Int )
toList resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByResource resource resources
                in
                ( resource, amount )
            )


getLabel : Resource -> String
getLabel resource =
    (getResourceStats resource).title
