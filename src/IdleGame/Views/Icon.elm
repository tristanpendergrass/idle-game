module IdleGame.Views.Icon exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)


type Size
    = Small
    | Medium
    | Large
    | ExtraLarge


type alias Params =
    { size : Size
    }


type Icon
    = IconFeather FeatherIcons.Icon Params
    | IconPublic String Params


defaultParams : Params
defaultParams =
    { size = Medium
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


sizeToRem : Size -> Float
sizeToRem size =
    case size of
        Small ->
            0.75

        Medium ->
            1.5

        Large ->
            3.0

        ExtraLarge ->
            6.0


sizeToTailwindClass : Size -> String
sizeToTailwindClass size =
    case size of
        Small ->
            "w-3 h-3"

        Medium ->
            "w-6 h-6"

        Large ->
            "w-12 h-12"

        ExtraLarge ->
            "w-24 h-24"


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


coin : Icon
coin =
    createIconPublic "/coin.png"


manure : Icon
manure =
    createIconPublic "/resources/manure.png"


soot : Icon
soot =
    createIconPublic "/resources/soot_2.png"


greenhouseDirt : Icon
greenhouseDirt =
    createIconPublic "/resources/greenhouseDirt_2.png"


washWater : Icon
washWater =
    createIconPublic "/resources/washWater.png"


emptyBottle : Icon
emptyBottle =
    createIconPublic "/resources/emptyBottle.png"


scrap : Icon
scrap =
    createIconPublic "/resources/scrap.png"


ectoplasm : Icon
ectoplasm =
    createIconPublic "/resources/ectoplasm_2.png"


parchment : Icon
parchment =
    createIconPublic "/resources/parchment.png"


shovel : Icon
shovel =
    createIconPublic "/shopItems/shovel.png"


book : Icon
book =
    createIconPublic "/shopItems/book.png"


keyring : Icon
keyring =
    createIconPublic "/shopItems/keyring.png"


readingGlasses : Icon
readingGlasses =
    createIconPublic "/shopItems/readingGlasses.png"


oversizedBag : Icon
oversizedBag =
    createIconPublic "/shopItems/oversizedBag.png"


unknownItem : Icon
unknownItem =
    createIconFeather FeatherIcons.lock
