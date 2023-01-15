module IdleGame.Tabs exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type TabType
    = Placeholder -- A type given to tabs in the sidebar that have no content yet
    | Bag
    | Chores


type Tabs
    = Tabs (List Category)


type alias Category =
    { title : Maybe String
    , items : List Tab
    , forbidden : Bool
    }


type Selection
    = Selected
    | NotSelected
    | Disabled


type alias Tab =
    { type_ : TabType
    , title : String
    , icon : Icon
    , selection : Selection
    }


getCategories : Tabs -> List Category
getCategories (Tabs categories) =
    categories


map : (Tab -> Tab) -> Tabs -> Tabs
map fn tabs =
    tabs
        |> getCategories
        |> List.map (\category -> { category | items = List.map fn category.items })
        |> Tabs


selectTab : TabType -> Tabs -> Tabs
selectTab type_ =
    map
        (\tab ->
            if tab.selection == Disabled then
                tab

            else if tab.type_ == type_ then
                { tab | selection = Selected }

            else
                { tab | selection = NotSelected }
        )


initialTabs : Tabs
initialTabs =
    Tabs
        [ { title = Nothing
          , forbidden = False
          , items =
                [ { type_ = Bag
                  , title = "Bag"
                  , icon = Icon.bag
                  , selection = NotSelected
                  }
                , { type_ = Placeholder
                  , title = "Shop"
                  , icon = Icon.shop
                  , selection = NotSelected
                  }
                ]
          }
        , { title = Just "Extracurricular"
          , forbidden = False
          , items =
                [ { type_ = Chores
                  , title = "Chores"
                  , icon = Icon.chores
                  , selection = NotSelected
                  }
                , { type_ = Placeholder
                  , title = "Exploration"
                  , icon = Icon.exploration
                  , selection = NotSelected
                  }
                , { type_ = Placeholder
                  , title = "Mischief"
                  , icon = Icon.mischief
                  , selection = NotSelected
                  }
                , { type_ = Placeholder
                  , title = "Dueling"
                  , icon = Icon.dueling
                  , selection = NotSelected
                  }
                ]
          }
        , { title = Just "Classes"
          , forbidden = False
          , items =
                [ { type_ = Placeholder
                  , title = "Botany"
                  , icon = Icon.botany
                  , selection = Disabled
                  }
                , { type_ = Placeholder
                  , title = "Potionmaking"
                  , icon = Icon.potionmaking
                  , selection = Disabled
                  }
                , { type_ = Placeholder
                  , title = "Hexes"
                  , icon = Icon.hexes
                  , selection = Disabled
                  }
                , { type_ = Placeholder
                  , title = "Wards"
                  , icon = Icon.wards
                  , selection = Disabled
                  }
                ]
          }
        , { title = Just "Dark Arts"
          , forbidden = True
          , items =
                [ { type_ = Placeholder
                  , title = "Forbidden knowledge"
                  , icon = Icon.forbiddenKnowledge
                  , selection = Disabled
                  }
                , { type_ = Placeholder
                  , title = "Forbidden knowledge"
                  , icon = Icon.forbiddenKnowledge
                  , selection = Disabled
                  }
                ]
          }
        ]
