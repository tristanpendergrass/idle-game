module IdleGame.Notification exposing (..)

import IdleGame.Resource as Resource exposing (..)


type alias Toast =
    String



-- We can enhance this later with a more full data type


type Notification
    = GainedGold Int
    | GainedResource Int Resource


toToast : Notification -> Toast
toToast notification =
    case notification of
        GainedGold amount ->
            "+" ++ String.fromInt amount ++ " Gold"

        GainedResource amount resource ->
            "+" ++ String.fromInt amount ++ " " ++ Resource.toString resource
