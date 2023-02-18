module IdleGame.XpFormulas exposing (..)

import Array exposing (Array)



-- The nth member of this array is the amount of xp required to reach level n + 1


xpRequirements : Array Int
xpRequirements =
    Array.fromList
        -- [ 0, 83, 174, 276, 388, 512, 650, 801, 969, 1154, 1358, 1584, 1833, 2107, 2411, 2746, 3115, 3523, 3973, 4470, 5018, 5624, 6291, 7028, 7842, 8740, 9730, 10824, 12031, 13363, 14833, 16456, 18247, 20224, 22406, 24815, 27473, 30408, 33648, 37224, 41171, 45529, 50339, 55649, 61512, 67983, 75127, 83014, 91721, 101333, 111945, 123660, 136594, 150872, 166636, 184040, 203254, 224466, 247886, 273742, 302288, 333804, 368599, 407015, 449428, 496254, 547953, 605032, 668051, 737627, 814445, 899257, 992895, 1096278, 1210421, 1336443, 1475581, 1629200, 1798808, 1986068, 2192818, 2421087, 2673114, 2951373, 3258594, 3597792, 3972294, 4385776, 4842295, 5346332, 5902831, 6517253, 7195629, 7944614, 8771558, 9684577, 10692629, 11805606, 13034431, 14391160, 15889109, 17542976, 19368992, 21385073, 23611006, 26068632, 28782069, 31777943, 35085654, 38737661, 42769801, 47221641, 52136869, 57563718, 63555443, 70170840, 77474828, 85539082, 94442737, 104273167 ]
        [ 0, 83, 174, 276, 388, 512, 650, 801, 969, 1154, 1358, 1584, 1833, 2107, 2411, 2746, 3115, 3523, 3973, 4470, 5018, 5624, 6291, 7028, 7842, 8740, 9730, 10824, 12031, 13363, 14833, 16456, 18247, 20224, 22406, 24815, 27473, 30408, 33648, 37224, 41171, 45529, 50339, 55649, 61512, 67983, 75127, 83014, 91721, 101333, 111945, 123660, 136594, 150872, 166636, 184040, 203254, 224466, 247886, 273742, 302288, 333804, 368599, 407015, 449428, 496254, 547953, 605032, 668051, 737627, 814445, 899257, 992895, 1096278, 1210421, 1336443, 1475581, 1629200, 1798808, 1986068, 2192818, 2421087, 2673114, 2951373, 3258594, 3597792, 3972294, 4385776, 4842295, 5346332, 5902831, 6517253, 7195629, 7944614, 8771558, 9684577, 10692629, 11805606, 13034431 ]



-- 13,034,431 : level 99


skillLevel : Float -> Int
skillLevel xp =
    skillLevelHelp xp 1


skillLevelPercent : Float -> Float
skillLevelPercent xp =
    skillLevelPercentHelp xp 0


skillLevelHelp : Float -> Int -> Int
skillLevelHelp xp prevLevel =
    case Array.get prevLevel xpRequirements of
        Just xpRequired ->
            if toFloat xpRequired > xp then
                prevLevel

            else
                skillLevelHelp xp (prevLevel + 1)

        Nothing ->
            prevLevel


skillLevelPercentHelp : Float -> Int -> Float
skillLevelPercentHelp xp i =
    let
        ( maybeCurrent, maybeNext ) =
            ( Array.get i xpRequirements, Array.get (i + 1) xpRequirements )
    in
    case ( maybeCurrent, maybeNext ) of
        ( Just current, Just next ) ->
            if xp < toFloat next then
                (xp - toFloat current) / toFloat (next - current)

            else
                skillLevelPercentHelp xp (i + 1)

        _ ->
            1.0


masteryPoolPercent : Float -> Float
masteryPoolPercent amount =
    (amount / 4500000) * 100
