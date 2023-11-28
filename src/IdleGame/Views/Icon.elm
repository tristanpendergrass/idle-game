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
    , isVisible : Bool
    }


type Icon
    = IconFeather FeatherIcons.Icon Params -- Icons sourced from FeatherIcons library
    | IconPublic String Params -- Icons sourced from the /public folder e.g. pngs
    | IconString String Params -- Icons sourced from the alphabet. Should just be one or two characters


defaultParams : Params
defaultParams =
    { size = Medium
    , isVisible = True
    }


mapParams : (Params -> Params) -> Icon -> Icon
mapParams fn icon =
    case icon of
        IconFeather f params ->
            IconFeather f (fn params)

        IconPublic p params ->
            IconPublic p (fn params)

        IconString c params ->
            IconString c (fn params)


withSize : Size -> Icon -> Icon
withSize size =
    mapParams (\params -> { params | size = size })


withVisibility : Bool -> Icon -> Icon
withVisibility isVisible =
    mapParams (\params -> { params | isVisible = isVisible })


sizeToRem : Size -> Float
sizeToRem size =
    case size of
        Small ->
            0.75

        Medium ->
            1.2

        Large ->
            3.0

        ExtraLarge ->
            6.0


sizeToTailwindClass : Size -> String
sizeToTailwindClass size =
    case size of
        Small ->
            "w-3 h-3 text-[8px]"

        Medium ->
            "w-6 h-6 text-sm font-semibold"

        Large ->
            "w-12 h-12 text-2xl font-bold"

        ExtraLarge ->
            "w-24 h-24 text-4xl font-bold"


getParams : Icon -> Params
getParams icon =
    case icon of
        IconFeather _ p ->
            p

        IconPublic _ p ->
            p

        IconString _ p ->
            p


toHtml : Icon -> Html msg
toHtml icon =
    let
        visibilityClass : String
        visibilityClass =
            if (getParams icon).isVisible then
                ""

            else
                "invisible"
    in
    case icon of
        IconFeather featherIcon params ->
            featherIcon
                |> FeatherIcons.withSize (sizeToRem params.size)
                |> FeatherIcons.withSizeUnit "rem"
                |> FeatherIcons.withClass visibilityClass
                |> FeatherIcons.toHtml []

        IconPublic iconSrc params ->
            img
                [ src iconSrc
                , class (sizeToTailwindClass params.size)
                , class visibilityClass
                ]
                []

        IconString str params ->
            div [ class "avatar", class visibilityClass ]
                [ div
                    [ class (sizeToTailwindClass params.size)
                    , class "mask mask-hexagon bg-warning text-warning-content"
                    ]
                    [ div
                        [ class "w-full h-full flex items-center justify-center"
                        ]
                        [ text str ]
                    ]
                ]



-- Icon creators


fromString : String -> Icon
fromString str =
    IconString str defaultParams


createIconFeather : FeatherIcons.Icon -> Icon
createIconFeather featherIcon =
    IconFeather featherIcon defaultParams


createIconPublic : String -> Icon
createIconPublic iconSrc =
    IconPublic iconSrc defaultParams


close : Icon
close =
    createIconFeather FeatherIcons.x


switch : Icon
switch =
    createIconFeather FeatherIcons.book


damage : Icon
damage =
    createIconFeather FeatherIcons.droplet


shield : Icon
shield =
    createIconFeather FeatherIcons.shield


debug : Icon
debug =
    createIconFeather FeatherIcons.tool


menu : Icon
menu =
    createIconFeather FeatherIcons.menu


bag : Icon
bag =
    createIconFeather FeatherIcons.box


shop : Icon
shop =
    createIconFeather FeatherIcons.dollarSign


adventuring : Icon
adventuring =
    createIconFeather FeatherIcons.gitlab


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


weathermancing : Icon
weathermancing =
    createIconFeather FeatherIcons.cloudRain


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


charmstone : Icon
charmstone =
    createIconPublic "/adventuring/charmstone.png"


silkling : Icon
silkling =
    createIconPublic "/adventuring/silkling.png"


stalker : Icon
stalker =
    createIconPublic "/adventuring/stalker.png"


dropdown : Icon
dropdown =
    createIconFeather FeatherIcons.arrowDown


chevronDown : Icon
chevronDown =
    createIconFeather FeatherIcons.chevronDown


chevronLeft : Icon
chevronLeft =
    createIconFeather FeatherIcons.chevronLeft


chevronRight : Icon
chevronRight =
    createIconFeather FeatherIcons.chevronRight


play : Icon
play =
    createIconFeather FeatherIcons.play


pause : Icon
pause =
    createIconFeather FeatherIcons.pause


eye : Icon
eye =
    createIconFeather FeatherIcons.eye


go : Icon
go =
    createIconFeather FeatherIcons.logIn


insufficientFunds : Icon
insufficientFunds =
    createIconFeather FeatherIcons.xCircle


undiscoveredItem : Icon
undiscoveredItem =
    createIconFeather FeatherIcons.helpCircle


undiscoveredMonster : Icon
undiscoveredMonster =
    createIconFeather FeatherIcons.helpCircle


undiscoveredQuest : Icon
undiscoveredQuest =
    createIconFeather FeatherIcons.helpCircle


quest : Icon
quest =
    createIconFeather FeatherIcons.trello


checkboxMarked : Icon
checkboxMarked =
    createIconFeather FeatherIcons.checkSquare


checkboxEmpty : Icon
checkboxEmpty =
    createIconFeather FeatherIcons.square
