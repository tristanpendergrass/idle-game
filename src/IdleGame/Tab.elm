module IdleGame.Tab exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = Backpack
    | Shop
      -- | TestingCenter
    | SubjectTab Skill


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

        SubjectTab skill ->
            { title = (Skill.getStats skill).title
            , icon = (Skill.getStats skill).icon
            }
