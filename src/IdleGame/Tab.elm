module IdleGame.Tab exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = Home
    | Backpack
    | Shop
    | SkillTab Skill


type alias TabConfig =
    { title : String
    , icon : Icon
    }


getConfig : Tab -> TabConfig
getConfig tab =
    case tab of
        Home ->
            { title = "Home"
            , icon = Icon.home
            }

        Backpack ->
            { title = "Backpack"
            , icon = Icon.bag
            }

        Shop ->
            { title = "Shop"
            , icon = Icon.shop
            }

        SkillTab skill ->
            let
                stats : SkillStats
                stats =
                    getSkillStats skill
            in
            { title = stats.title
            , icon = stats.icon
            }
