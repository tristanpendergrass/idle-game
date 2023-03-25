module IdleGame.Tab exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = ForbiddenKnowledge
    | Bag
    | Shop
    | Adventuring
    | Chores
    | Explore
    | Mischief
      -- Classes
    | Hexes
    | Wards
    | Enchantment
    | Botany
    | Potionmaking
    | Conjuration
    | Transmogrification


type alias TabConfig =
    { title : String
    , icon : Icon
    }


getConfig : Tab -> TabConfig
getConfig tab =
    case tab of
        ForbiddenKnowledge ->
            { title = "Forbidden Knowledge"
            , icon = Icon.forbiddenKnowledge
            }

        Bag ->
            { title = "Bag"
            , icon = Icon.bag
            }

        Shop ->
            { title = "Shop"
            , icon = Icon.shop
            }

        Adventuring ->
            { title = "Adventuring"
            , icon = Icon.adventuring
            }

        Chores ->
            { title = "Chores"
            , icon = Icon.chores
            }

        Explore ->
            { title = "Explore"
            , icon = Icon.explore
            }

        Mischief ->
            { title = "Mischief"
            , icon = Icon.mischief
            }

        Hexes ->
            { title = "Hexes"
            , icon = Icon.hexes
            }

        Wards ->
            { title = "Wards"
            , icon = Icon.wards
            }

        Enchantment ->
            { title = "Enchantment"
            , icon = Icon.enchantment
            }

        Botany ->
            { title = "Botany"
            , icon = Icon.botany
            }

        Potionmaking ->
            { title = "Potionmaking"
            , icon = Icon.potionmaking
            }

        Conjuration ->
            { title = "Conjuration"
            , icon = Icon.conjuration
            }

        Transmogrification ->
            { title = "Transmogrification"
            , icon = Icon.transmogrification
            }
