module IdleGame.Tab exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Tab
    = BagTab
    | ShopTab
    | ChoresTab
    | ExploreTab
    | MischiefTab
    | BotanyTab
    | PotionmakingTab
    | ConjurationTab
    | TransmogrificationTab
    | HexesTab
    | WardsTab


type alias TabConfig =
    { label : String
    , icon : Icon
    }


getConfig : Tab -> TabConfig
getConfig tab =
    Debug.todo ""
