module IdleGame.Views.Icon exposing (..)

import FeatherIcons


type Icon
    = Bag
    | Shop
    | Chores
    | Exploration
    | Mischief
    | Dueling
    | Botany
    | Potionmaking
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

        Exploration ->
            FeatherIcons.map

        Mischief ->
            FeatherIcons.target

        Dueling ->
            FeatherIcons.gitlab

        Botany ->
            FeatherIcons.cloudDrizzle

        Potionmaking ->
            FeatherIcons.droplet

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
    Exploration


mischief : Icon
mischief =
    Mischief


dueling : Icon
dueling =
    Dueling


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
