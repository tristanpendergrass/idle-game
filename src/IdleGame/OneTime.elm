module IdleGame.OneTime exposing (..)


type OneTimeStatus
    = NotOneTime
    | OneTime OneTimeId


type OneTimeId
    = Lab1
    | Lab2


type alias OneTimeRecord a =
    { lab1 : a
    , lab2 : a
    }


oneTimeRecord : a -> OneTimeRecord a
oneTimeRecord a =
    { lab1 = a
    , lab2 = a
    }


setByOneTimeId : OneTimeId -> a -> OneTimeRecord a -> OneTimeRecord a
setByOneTimeId id value record =
    case id of
        Lab1 ->
            { record | lab1 = value }

        Lab2 ->
            { record | lab2 = value }


getByOneTimeId : OneTimeId -> OneTimeRecord a -> a
getByOneTimeId id record =
    case id of
        Lab1 ->
            record.lab1

        Lab2 ->
            record.lab2


updateByOneTimeId : OneTimeId -> (a -> a) -> OneTimeRecord a -> OneTimeRecord a
updateByOneTimeId id f record =
    let
        value : a
        value =
            getByOneTimeId id record
    in
    setByOneTimeId id (f value) record


claimOneTime : OneTimeId -> OneTimeRecord Bool -> OneTimeRecord Bool
claimOneTime id record =
    setByOneTimeId id True record


isAvailable : OneTimeRecord Bool -> OneTimeStatus -> Bool
isAvailable record status =
    case status of
        NotOneTime ->
            True

        OneTime id ->
            not (getByOneTimeId id record)


isOneTime : OneTimeStatus -> Bool
isOneTime status =
    case status of
        NotOneTime ->
            False

        OneTime _ ->
            True
