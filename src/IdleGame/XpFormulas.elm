module IdleGame.XpFormulas exposing (..)

import Array exposing (Array)



-- The nth member of this array is the amount of xp required to reach level n + 1


xpRequirements : Array Int
xpRequirements =
    Array.fromList
        [ 0 -- level 1 requirement
        , 83 -- level 2 requirement
        , 174 -- etc.
        , 276
        , 388
        , 512
        , 650
        , 801
        , 969
        , 1154
        , 1358
        , 1584
        , 1833
        , 2107
        , 2411
        , 2746
        , 3115
        , 3523
        , 3973
        , 4470 -- level 20; more than this and you are still level 20.
        ]


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
