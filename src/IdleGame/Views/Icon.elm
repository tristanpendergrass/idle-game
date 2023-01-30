module IdleGame.Views.Icon exposing (..)

import FeatherIcons


type Icon
    = UnderConstruction
    | Bag
    | Shop
    | Chores
    | Explore
    | Mischief
    | Hexes
    | Wards
    | Enchantment
    | Botany
    | Potionmaking
    | Conjuration
    | Transmogrification
    | ForbiddenKnowledge


toFeatherIcon : Icon -> FeatherIcons.Icon
toFeatherIcon icon =
    case icon of
        UnderConstruction ->
            FeatherIcons.tool
                |> FeatherIcons.withClass "text-info"

        Bag ->
            FeatherIcons.box

        Shop ->
            FeatherIcons.dollarSign

        Chores ->
            FeatherIcons.clipboard

        Explore ->
            FeatherIcons.map

        Mischief ->
            FeatherIcons.target

        Hexes ->
            FeatherIcons.zap

        Wards ->
            FeatherIcons.shield

        Enchantment ->
            FeatherIcons.star

        Botany ->
            FeatherIcons.cloudDrizzle

        Potionmaking ->
            FeatherIcons.droplet

        Conjuration ->
            FeatherIcons.aperture

        Transmogrification ->
            FeatherIcons.package

        ForbiddenKnowledge ->
            FeatherIcons.alertTriangle


bag : Icon
bag =
    Bag


shop : Icon
shop =
    Shop


chores : Icon
chores =
    Chores


exploration : Icon
exploration =
    Explore


mischief : Icon
mischief =
    Mischief


botany : Icon
botany =
    Botany


potionmaking : Icon
potionmaking =
    Potionmaking


hexes : Icon
hexes =
    Hexes


wards : Icon
wards =
    Wards


forbiddenKnowledge : Icon
forbiddenKnowledge =
    ForbiddenKnowledge
