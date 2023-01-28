module IdleGame.Views.Icon exposing (..)

import FeatherIcons


type Icon
    = Bag
    | Shop
    | Chores
    | Explore
    | Mischief
    | Botany
    | Potionmaking
    | Conjuration
    | Transmogrification
    | Hexes
    | Wards
    | ForbiddenKnowledge


toFeatherIcon : Icon -> FeatherIcons.Icon
toFeatherIcon icon =
    case icon of
        Bag ->
            FeatherIcons.box

        Shop ->
            FeatherIcons.dollarSign

        Chores ->
            FeatherIcons.tool

        Explore ->
            FeatherIcons.map

        Mischief ->
            FeatherIcons.target

        Botany ->
            FeatherIcons.cloudDrizzle

        Potionmaking ->
            FeatherIcons.droplet

        Conjuration ->
            Debug.todo ""

        Transmogrification ->
            Debug.todo ""

        Hexes ->
            FeatherIcons.zap

        Wards ->
            FeatherIcons.zapOff

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
