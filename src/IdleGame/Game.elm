module IdleGame.Game exposing (..)

import IdleGame.Timer
import Set exposing (Set)
import Time exposing (Posix)
import Time.Extra



-- Public


type alias Game =
    { currentTime : Posix
    , woodcuttingXp : Float
    , woodcuttingMxp : Float
    , trees : List Tree
    }


create : Posix -> Game
create now =
    { currentTime = now
    , woodcuttingXp = 10
    , woodcuttingMxp = 10
    , trees =
        [ Tree 0
            { title = "Elm", rewardText = "+5 gold", xpGranted = 5, mxpGranted = 15, mxp = 235 }
            Nothing
        , Tree 1
            { title = "Maple", rewardText = "+15 gold", xpGranted = 10, mxpGranted = 1, mxp = 0 }
            Nothing
        ]
    }



-- updateGameObject : Posix -> Game -> Game
-- updateGameObject now gameObject =
--     if Time.posixToMillis (getTimeOfNextTick gameObject) <= Time.posixToMillis now then
--         gameObject
--             |> tick
--             |> updateGameObject now
--     else
--         gameObject
-- Private


type ModType
    = PercentMod Float
    | BaseRateMod Float
    | FlatMod Float


type alias Mod =
    { type_ : ModType
    , tags : Set Tag
    }


type Tag
    = Woodcutting
    | BoatBuilding
    | SkillXp
    | MasteryXp


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc



-- Woodcutting


type Tree
    = Tree Id TreeData ActivityStatus


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


type alias Id =
    Int


type alias TreeData =
    { title : String, rewardText : String, xpGranted : Float, mxpGranted : Float, mxp : Float }


isActive : Tree -> Bool
isActive (Tree _ _ activityStatus) =
    not (activityStatus == Nothing)


toggleActiveTree : Id -> Game -> Game
toggleActiveTree toggleId game =
    let
        newTrees =
            game.trees
                |> List.map
                    (\tree ->
                        let
                            (Tree id treeData activityStatus) =
                                tree
                        in
                        if id == toggleId && activityStatus == Nothing then
                            Tree id treeData (Just <| IdleGame.Timer.create 2000)

                        else
                            Tree id treeData Nothing
                    )
    in
    { game | trees = newTrees }


getId : Tree -> Id
getId (Tree id _ _) =
    id


getWoodcuttingData : Tree -> TreeData
getWoodcuttingData (Tree _ treeData _) =
    treeData


tickTree : Tree -> ( Tree, { xp : Float, mxp : Float } )
tickTree (Tree id treeData maybeActivityTimer) =
    case maybeActivityTimer of
        Nothing ->
            ( Tree id treeData maybeActivityTimer, { xp = 0, mxp = 0 } )

        Just timer ->
            let
                ( newTimer, timesCompleted ) =
                    IdleGame.Timer.tick timer

                newTreeData =
                    { treeData | mxp = treeData.mxp + toFloat timesCompleted * treeData.mxpGranted }

                xpGranted =
                    treeData.xpGranted * toFloat timesCompleted

                mxpGranted =
                    treeData.mxpGranted * toFloat timesCompleted
            in
            ( Tree id newTreeData (Just newTimer), { xp = xpGranted, mxp = mxpGranted } )


timeOfNextTick : Game -> Posix
timeOfNextTick game =
    game
        |> .currentTime
        |> Time.Extra.add Time.Extra.Millisecond IdleGame.Timer.tickDuration Time.utc


tick : Game -> Game
tick game =
    let
        ( newTrees, { xp, mxp } ) =
            game.trees
                |> List.foldr
                    (\tree accum ->
                        let
                            ( accumTrees, accumXps ) =
                                accum

                            ( newTree, gainedXps ) =
                                tickTree tree
                        in
                        ( newTree :: accumTrees, { xp = accumXps.xp + gainedXps.xp, mxp = accumXps.mxp + gainedXps.mxp } )
                    )
                    ( [], { xp = 0, mxp = 0 } )
    in
    { game
        | currentTime = timeOfNextTick game
        , trees = newTrees
        , woodcuttingXp = game.woodcuttingXp + xp
        , woodcuttingMxp = game.woodcuttingMxp + mxp
    }


updateGameToTime : Posix -> Game -> Game
updateGameToTime now game =
    let
        shouldTick =
            Time.posixToMillis now >= Time.posixToMillis (timeOfNextTick game)
    in
    if shouldTick then
        game
            |> tick
            |> updateGameToTime now

    else
        game


updateCurrentTime : Posix -> Game -> Game
updateCurrentTime now game =
    { game | currentTime = now }
