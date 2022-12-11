module IdleGame.Tabs exposing (Category, Tab, Tabs, getCategories, initialTabs)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Tabs
    = Tabs (List Category)


type alias Category =
    { title : Maybe String
    , items : List Tab
    , forbidden : Bool
    }


type alias Tab =
    { title : String
    , icon : Icon
    , disabled : Bool
    }


getCategories : Tabs -> List Category
getCategories (Tabs categories) =
    categories


initialTabs : Tabs
initialTabs =
    Tabs
        [ { title = Nothing
          , forbidden = False
          , items =
                [ { title = "Bag"
                  , icon = Icon.bag
                  , disabled = False
                  }
                , { title = "Shop"
                  , icon = Icon.shop
                  , disabled = False
                  }
                ]
          }
        , { title = Just "Extracurricular"
          , forbidden = False
          , items =
                [ { title = "Chores"
                  , icon = Icon.chores
                  , disabled = False
                  }
                , { title = "Exploration"
                  , icon = Icon.exploration
                  , disabled = False
                  }
                , { title = "Mischief"
                  , icon = Icon.mischief
                  , disabled = False
                  }
                , { title = "Dueling"
                  , icon = Icon.dueling
                  , disabled = False
                  }
                ]
          }
        , { title = Just "Classes"
          , forbidden = False
          , items =
                [ { title = "Botany"
                  , icon = Icon.botany
                  , disabled = True
                  }
                , { title = "Potionmaking"
                  , icon = Icon.potionmaking
                  , disabled = True
                  }
                , { title = "Hexes"
                  , icon = Icon.hexes
                  , disabled = True
                  }
                , { title = "Wards"
                  , icon = Icon.wards
                  , disabled = True
                  }
                ]
          }
        , { title = Just "Dark Arts"
          , forbidden = True
          , items =
                [ { title = "Forbidden knowledge"
                  , icon = Icon.forbiddenKnowledge
                  , disabled = True
                  }
                , { title = "Forbidden knowledge"
                  , icon = Icon.forbiddenKnowledge
                  , disabled = True
                  }
                ]
          }
        ]
