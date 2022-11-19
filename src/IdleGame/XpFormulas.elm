module IdleGame.XpFormulas exposing (..)

import Array exposing (Array)


xpRequirements : Array Int
xpRequirements =
    Array.fromList
        [ 0 -- level 1 requirement
        , 83 -- level 2
        , 174
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
        , 4470
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
