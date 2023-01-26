module IdleGame.Tabs exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra
import Maybe.Extra


type TabType
    = Placeholder -- A type given to tabs in the sidebar that have no content yet
    | Bag
    | Chores



-- type Tabs
--     = Tabs (Maybe TabType) (List Category)
-- type alias Category =
--     { title : Maybe String
--     , items : List Tab
--     , forbidden : Bool
--     }
-- type Selection
--     = Selected
--     | NotSelected
--     | Disabled
-- type alias Tab =
--     { type_ : TabType
--     , title : String
--     , icon : Icon
--     , disabled : Bool
--     }
-- getCategories : Tabs -> List Category
-- getCategories (Tabs _ categories) =
--     categories
-- selectTab : TabType -> Tabs -> Tabs
-- selectTab type_ (Tabs _ categories) =
--     Tabs (Just type_) categories
-- getActiveTab : Tabs -> Maybe Tab
-- getActiveTab (Tabs type_ categories) =
--     categories
--         List.Extra.find
--         (findTypeInCategory >> Maybe.Extra.isJust)
-- initialTabs : Tabs
-- initialTabs =
--     Tabs
--         (Just Chores)
--         [ { title = Nothing
--           , forbidden = False
--           , items =
--                 [ { type_ = Bag
--                   , title = "Bag"
--                   , icon = Icon.bag
--                   , disabled = False
--                   }
--                 , { type_ = Placeholder
--                   , title = "Shop"
--                   , icon = Icon.shop
--                   , disabled = False
--                   }
--                 ]
--           }
--         , { title = Just "Extracurricular"
--           , forbidden = False
--           , items =
--                 [ { type_ = Chores
--                   , title = "Chores"
--                   , icon = Icon.chores
--                   , disabled = False
--                   }
--                 , { type_ = Placeholder
--                   , title = "Exploration"
--                   , icon = Icon.exploration
--                   , disabled = False
--                   }
--                 , { type_ = Placeholder
--                   , title = "Mischief"
--                   , icon = Icon.mischief
--                   , disabled = False
--                   }
--                 , { type_ = Placeholder
--                   , title = "Dueling"
--                   , icon = Icon.dueling
--                   , disabled = False
--                   }
--                 ]
--           }
--         , { title = Just "Classes"
--           , forbidden = False
--           , items =
--                 [ { type_ = Placeholder
--                   , title = "Botany"
--                   , icon = Icon.botany
--                   , disabled = True
--                   }
--                 , { type_ = Placeholder
--                   , title = "Potionmaking"
--                   , icon = Icon.potionmaking
--                   , disabled = True
--                   }
--                 , { type_ = Placeholder
--                   , title = "Hexes"
--                   , icon = Icon.hexes
--                   , disabled = True
--                   }
--                 , { type_ = Placeholder
--                   , title = "Wards"
--                   , icon = Icon.wards
--                   , disabled = True
--                   }
--                 ]
--           }
--         , { title = Just "Dark Arts"
--           , forbidden = True
--           , items =
--                 [ { type_ = Placeholder
--                   , title = "Forbidden knowledge"
--                   , icon = Icon.forbiddenKnowledge
--                   , disabled = True
--                   }
--                 , { type_ = Placeholder
--                   , title = "Forbidden knowledge"
--                   , icon = Icon.forbiddenKnowledge
--                   , disabled = True
--                   }
--                 ]
--           }
--         ]
