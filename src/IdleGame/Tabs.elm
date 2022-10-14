module IdleGame.Tabs exposing (Category, Tab, Tabs, getCategories, initialTabs)

import FeatherIcons


type Tabs
    = Tabs (List Category)


type alias Category =
    { title : Maybe String
    , items : List Tab
    , forbidden : Bool
    }


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
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
                  , icon = FeatherIcons.box
                  , disabled = False
                  }
                , { title = "Shop"
                  , icon = FeatherIcons.dollarSign
                  , disabled = False
                  }
                ]
          }
        , { title = Just "Extracurricular"
          , forbidden = False
          , items =
                [ { title = "Chores"
                  , icon = FeatherIcons.tool
                  , disabled = False
                  }
                , { title = "Exploration"
                  , icon = FeatherIcons.map
                  , disabled = False
                  }
                , { title = "Mischief"
                  , icon = FeatherIcons.target
                  , disabled = False
                  }
                , { title = "Dueling"
                  , icon = FeatherIcons.gitlab
                  , disabled = False
                  }
                ]
          }
        , { title = Just "Classes"
          , forbidden = False
          , items =
                [ { title = "Botany"
                  , icon = FeatherIcons.cloudDrizzle
                  , disabled = True
                  }
                , { title = "Potionmaking"
                  , icon = FeatherIcons.droplet
                  , disabled = True
                  }
                , { title = "Hexes"
                  , icon = FeatherIcons.zap
                  , disabled = True
                  }
                , { title = "Wards"
                  , icon = FeatherIcons.zapOff
                  , disabled = True
                  }
                ]
          }
        , { title = Just "Dark Arts"
          , forbidden = True
          , items =
                [ { title = "Forbidden knowledge"
                  , icon = FeatherIcons.alertTriangle
                  , disabled = True
                  }
                , { title = "Forbidden knowledge"
                  , icon = FeatherIcons.alertTriangle
                  , disabled = True
                  }
                ]
          }
        ]
