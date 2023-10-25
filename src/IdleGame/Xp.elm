module IdleGame.Xp exposing (..)

import Array exposing (Array)
import Percent exposing (Percent)
import Quantity exposing (Quantity(..))


type Level_
    = Level_


type alias Level =
    Quantity Int Level_


type Point
    = Point


type alias Xp =
    Quantity Float Point


type alias LevelingSchedule =
    Array Xp


int : Int -> Xp
int amount =
    Quantity (toFloat amount)


toInt : Xp -> Int
toInt (Quantity amount) =
    floor amount


level : LevelingSchedule -> Xp -> Int
level schedule xp =
    levelHelp schedule xp 1


levelHelp : LevelingSchedule -> Xp -> Int -> Int
levelHelp schedule xp prevLevel =
    case Array.get prevLevel schedule of
        Just xpRequired ->
            if Quantity.greaterThan xp xpRequired then
                prevLevel

            else
                levelHelp schedule xp (prevLevel + 1)

        Nothing ->
            prevLevel


levelPercent : LevelingSchedule -> Xp -> Percent
levelPercent schedule xp =
    levelPercentHelp schedule xp 0
        |> Percent.float


levelPercentHelp : LevelingSchedule -> Xp -> Int -> Float
levelPercentHelp schedule xp i =
    let
        ( maybeCurrent, maybeNext ) =
            ( Array.get i schedule, Array.get (i + 1) schedule )
    in
    case ( maybeCurrent, maybeNext ) of
        ( Just current, Just next ) ->
            if Quantity.lessThan next xp then
                let
                    progressInCurrentLevel : Xp
                    progressInCurrentLevel =
                        Quantity.difference xp current

                    distanceToNextLevel : Xp
                    distanceToNextLevel =
                        Quantity.difference next current
                in
                toFloat (toInt progressInCurrentLevel) / toFloat (toInt distanceToNextLevel)

            else
                levelPercentHelp schedule xp (i + 1)

        _ ->
            1.0


defaultSchedule : LevelingSchedule
defaultSchedule =
    Array.map int <|
        Array.fromList
            -- [ 0, 83, 174, 276, 388, 512, 650, 801, 969, 1154, 1358, 1584, 1833, 2107, 2411, 2746, 3115, 3523, 3973, 4470, 5018, 5624, 6291, 7028, 7842, 8740, 9730, 10824, 12031, 13363, 14833, 16456, 18247, 20224, 22406, 24815, 27473, 30408, 33648, 37224, 41171, 45529, 50339, 55649, 61512, 67983, 75127, 83014, 91721, 101333, 111945, 123660, 136594, 150872, 166636, 184040, 203254, 224466, 247886, 273742, 302288, 333804, 368599, 407015, 449428, 496254, 547953, 605032, 668051, 737627, 814445, 899257, 992895, 1096278, 1210421, 1336443, 1475581, 1629200, 1798808, 1986068, 2192818, 2421087, 2673114, 2951373, 3258594, 3597792, 3972294, 4385776, 4842295, 5346332, 5902831, 6517253, 7195629, 7944614, 8771558, 9684577, 10692629, 11805606, 13034431, 14391160, 15889109, 17542976, 19368992, 21385073, 23611006, 26068632, 28782069, 31777943, 35085654, 38737661, 42769801, 47221641, 52136869, 57563718, 63555443, 70170840, 77474828, 85539082, 94442737, 104273167 ]
            [ 0, 83, 174, 276, 388, 512, 650, 801, 969, 1154, 1358, 1584, 1833, 2107, 2411, 2746, 3115, 3523, 3973, 4470, 5018, 5624, 6291, 7028, 7842, 8740, 9730, 10824, 12031, 13363, 14833, 16456, 18247, 20224, 22406, 24815, 27473, 30408, 33648, 37224, 41171, 45529, 50339, 55649, 61512, 67983, 75127, 83014, 91721, 101333, 111945, 123660, 136594, 150872, 166636, 184040, 203254, 224466, 247886, 273742, 302288, 333804, 368599, 407015, 449428, 496254, 547953, 605032, 668051, 737627, 814445, 899257, 992895, 1096278, 1210421, 1336443, 1475581, 1629200, 1798808, 1986068, 2192818, 2421087, 2673114, 2951373, 3258594, 3597792, 3972294, 4385776, 4842295, 5346332, 5902831, 6517253, 7195629, 7944614, 8771558, 9684577, 10692629, 11805606, 13034431 ]
