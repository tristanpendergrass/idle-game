module IdleGame.Views.Icon exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)


type Size
    = Small
    | Large


type alias Params =
    { size : Size
    }


type Icon
    = IconFeather FeatherIcons.Icon Params
    | IconPublic String Params


defaultParams : Params
defaultParams =
    { size = Small
    }


mapParams : (Params -> Params) -> Icon -> Icon
mapParams fn icon =
    case icon of
        IconFeather f params ->
            IconFeather f (fn params)

        IconPublic p params ->
            IconPublic p (fn params)


withSize : Size -> Icon -> Icon
withSize size =
    mapParams (\params -> { params | size = size })


sizeToPx : Size -> Float
sizeToPx size =
    case size of
        Small ->
            12

        Large ->
            24

sizeToRem : Size -> Float
sizeToRem size =
    case size of
        Small ->
            0.75

        Large ->
            1.5

sizeToTailwindClass : Size -> String
sizeToTailwindClass size =
    case size of
        Small ->
            "w-3"

        Large ->
            "w-6"


toHtml : Icon -> Html msg
toHtml icon =
    case icon of
        IconFeather featherIcon params ->
            featherIcon
                |> FeatherIcons.withSize (sizeToRem params.size)
                |> FeatherIcons.withSizeUnit "rem"
                |> FeatherIcons.toHtml []

        IconPublic iconSrc params ->
            img
                [ src iconSrc
                , class (sizeToTailwindClass params.size)
                ]
                []



-- Icon creators


createIconFeather : FeatherIcons.Icon -> Icon
createIconFeather featherIcon =
    IconFeather featherIcon defaultParams


createIconPublic : String -> Icon
createIconPublic iconSrc =
    IconPublic iconSrc defaultParams


menu : Icon
menu =
    createIconFeather FeatherIcons.menu


bag : Icon
bag =
    createIconFeather FeatherIcons.box


shop : Icon
shop =
    createIconFeather FeatherIcons.dollarSign


chores : Icon
chores =
    createIconFeather FeatherIcons.clipboard


explore : Icon
explore =
    createIconFeather FeatherIcons.map


mischief : Icon
mischief =
    createIconFeather FeatherIcons.target


botany : Icon
botany =
    createIconFeather FeatherIcons.cloudDrizzle


potionmaking : Icon
potionmaking =
    createIconFeather FeatherIcons.droplet


hexes : Icon
hexes =
    createIconFeather FeatherIcons.zap


wards : Icon
wards =
    createIconFeather FeatherIcons.shield


enchantment : Icon
enchantment =
    createIconFeather FeatherIcons.star


conjuration : Icon
conjuration =
    createIconFeather FeatherIcons.aperture


transmogrification : Icon
transmogrification =
    createIconFeather FeatherIcons.package


forbiddenKnowledge : Icon
forbiddenKnowledge =
    createIconFeather FeatherIcons.alertTriangle


underConstruction : Icon
underConstruction =
    createIconFeather FeatherIcons.tool


gold : Icon
gold =
    createIconPublic "/coin.png"
