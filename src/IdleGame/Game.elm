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



-- gainSomething : Reward -> Game -> RewardFinal
-- gainSomething rewardBase game =
--     Debug.todo "Implement gainSomething"
-- tick : Game -> Game
-- tick game =
--     Debug.todo "Implement tick"


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


getId : Tree -> Id
getId (Tree id _ _) =
    id


getWoodcuttingData : Tree -> TreeData
getWoodcuttingData (Tree _ treeData _) =
    treeData



-- handleAnimationFrameHelper : Posix -> Tree -> ( Tree, { xp : Int, mxp : Int } )
-- handleAnimationFrameHelper now (Tree id treeData maybeActivityTimer) =
--     case maybeActivityTimer of
--         Nothing ->
--             ( Tree id treeData maybeActivityTimer, { xp = 0, mxp = 0 } )
--         Just timer ->
--             let
--                 ( newTimer, timesCompleted ) =
--                     IdleGame.Timer.update now timer
--                 newTreeData =
--                     { treeData | mxp = treeData.mxp + timesCompleted * treeData.mxpGranted }
--                 xpGranted =
--                     treeData.xpGranted * timesCompleted
--                 mxpGranted =
--                     treeData.mxpGranted * timesCompleted
--             in
--             ( Tree id newTreeData (Just newTimer), { xp = xpGranted, mxp = mxpGranted } )
-- handleAnimationFrame : Int -> List Tree -> ( List Tree, { skillXpGained : Int, masteryXpGained : Int } )
-- handleAnimationFrame now woodcuttings =
--     List.foldr
--         (\woodcutting accum ->
--             let
--                 ( newWoodcutting, { skillXp, masteryXp } ) =
--                     handleAnimationFrameHelper now woodcutting
--                 ( accumWoodcuttings, accumXps ) =
--                     accum
--             in
--             ( newWoodcutting :: accumWoodcuttings, { skillXpGained = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
--         )
--         ( [], { skillXpGained = 0, masteryXpGained = 0 } )
--         woodcuttings
-- tick : Game -> Game
-- tick game =
--     let
--         ( newTrees, { xp, mxp } ) =
--             List.foldr
--                 (\woodcutting accum ->
--                     let
--                         ( newWoodcutting, { xp, mxp } ) =
--                             handleAnimationFrameHelper game.currentTime woodcutting
--                         ( accumWoodcuttings, accumXps ) =
--                             accum
--                     in
--                     ( newWoodcutting :: accumWoodcuttings, { xp = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
--                 )
--                 ( [], { skillXpGained = 0, masteryXpGained = 0 } )
--                 game.trees
--     in
--     { game | woodcuttingXp = game.woodcuttingXp + xp, woodcuttingMxp = game.woodcuttingMxp + mxp }
-- GameObject stuff
-- getTimeOfNextTick : Game -> Posix
-- getTimeOfNextTick game =
--     game.currentTime
--         |> Time.Extra.add Time.Extra.Millisecond 20 Time.utc
-- tick : Game -> Game
-- tick gameObject =
--     gameObject
--         |> IdleGame.Woodcuttings.tick
-- updateGameObject : Posix -> GameObject -> GameObject
-- updateGameObject now gameObject =
--     if getTimeOfNextTick gameObject <= now then
--         gameObject
--             |> tick
--             |> updateGameObject now
--     else
--         gameObject
