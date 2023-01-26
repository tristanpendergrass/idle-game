module IdleGame.ZIndexes exposing (..)

import Html.Attributes exposing (..)


zIndexes =
    -- Note that tailwind z-indexes only allow 0 through 50, in increments of 10. See https://tailwindcss.com/docs/z-index
    { drawerContent = class "z-0"
    , cardBody = class "z-0"
    , activityProgressBar = class "z-10"
    , toast = class "z-20"
    , bottomRightMenu = class "z-30"
    , modalWrapper = class "z-40"
    }
