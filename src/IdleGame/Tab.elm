module IdleGame.Tab exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = Backpack
    | Shop
      -- | TestingCenter
    | Anatomy
      -- | Biochemistry
      -- | Physiology
      -- | Pharmacology
      -- | MicrobiologyAndImmunology
      -- | Pathology
    | MedicalEthics


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

        Anatomy ->
            { title = "Anatomy"
            , icon = Icon.fromString "A"
            }

        MedicalEthics ->
            { title = "Medical Ethics"
            , icon = Icon.fromString "ME"
            }
