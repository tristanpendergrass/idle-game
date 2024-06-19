module IdleGame.Tab exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = Backpack
    | Shop
      -- | TestingCenter
    | SkillTab Skill


type alias TabConfig =
    { title : String
    , icon : Icon
    }


getConfig : Tab -> TabConfig
getConfig tab =
    case tab of
        Backpack ->
            { title = "Backpack"
            , icon = Icon.bag
            }

        Shop ->
            { title = "Shop"
            , icon = Icon.fromString "S"
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
