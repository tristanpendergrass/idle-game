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


type alias TabConfig =
    { title : String
    , icon : Icon
    }


getConfig : Tab -> TabConfig
getConfig tab =
    case tab of
        ForbiddenKnowledge ->
            { title = "Forbidden Knowledge"
            , icon = Icon.ForbiddenKnowledge
            }

        Bag ->
            { title = "Bag"
            , icon = Icon.Bag
            }

        Shop ->
            { title = "Shop"
            , icon = Icon.Shop
            }

        Chores ->
            { title = "Chores"
            , icon = Icon.Chores
            }

        Explore ->
            { title = "Explore"
            , icon = Icon.Explore
            }

        Mischief ->
            { title = "Mischief"
            , icon = Icon.Mischief
            }

        Hexes ->
            { title = "Hexes"
            , icon = Icon.Hexes
            }

        Wards ->
            { title = "Wards"
            , icon = Icon.Wards
            }

        Enchantment ->
            { title = "Enchantment"
            , icon = Icon.Enchantment
            }

        Botany ->
            { title = "Botany"
            , icon = Icon.Botany
            }

        Potionmaking ->
            { title = "Potionmaking"
            , icon = Icon.Potionmaking
            }

        Conjuration ->
            { title = "Conjuration"
            , icon = Icon.Conjuration
            }

        Transmogrification ->
            { title = "Transmogrification"
            , icon = Icon.Transmogrification
            }
