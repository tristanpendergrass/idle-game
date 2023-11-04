module IdleGame.Tab exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = ForbiddenKnowledge
    | Bag
    | Shop
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
      -- Locations
    | Location1
    | Location2


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

        Location1 ->
            { title = "Location 1"
            , icon = Icon.enchantment
            }

        Location2 ->
            { title = "Location 2"
            , icon = Icon.enchantment
            }
