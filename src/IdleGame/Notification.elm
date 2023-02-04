module IdleGame.Notification exposing (..)

import IdleGame.Resource as Resource
import IdleGame.Views.Utils


type alias Toast =
    String



-- We can enhance this later with a more full data type


type Notification
    = GainedGold Int
    | GainedResource Int Resource.Kind


toToast : Notification -> Toast
toToast notification =
    case notification of
        GainedGold amount ->
            "+" ++ IdleGame.Views.Utils.intToString amount ++ " Gold"

        GainedResource amount resource ->
            let
                label =
                    (Resource.getStats resource).title
            in
            "+" ++ IdleGame.Views.Utils.intToString amount ++ " " ++ label
