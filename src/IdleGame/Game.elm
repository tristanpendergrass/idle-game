module IdleGame.Game exposing (..)

import FeatherIcons
import IdleGame.Timer
import Set exposing (Set)
import Time exposing (Posix)
import Time.Extra



-- Public


type alias Game =
    { currentTime : Posix
    , woodcuttingXp : Float
    , woodcuttingMxp : Float
    , activeTree : Maybe ( TreeType, IdleGame.Timer.Timer )
    , treeData : TreeData
    }


create : Posix -> Game
create now =
    { currentTime = now
    , woodcuttingXp = 0
    , woodcuttingMxp = 0
    , activeTree = Nothing
    , treeData =
        { elm = { mxp = 0 }
        , oak = { mxp = 0 }
        , willow = { mxp = 0 }
        }
    }


type WoodcuttingListItem
    = WoodcuttingLockedItem Int
    | WoodcuttingTree TreeType


getWoodcuttingListItems : Game -> List WoodcuttingListItem
getWoodcuttingListItems _ =
    [ WoodcuttingTree Elm
    , WoodcuttingTree Oak
    , WoodcuttingLockedItem 50
    ]



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


type alias Tree =
    { type_ : TreeType
    , title : String
    , rewardText : String
    , xpGranted : Float
    }


getTree : TreeType -> Tree
getTree type_ =
    case type_ of
        Elm ->
            { type_ = Elm
            , title = "Elm"
            , rewardText = "N/A"
            , xpGranted = 5.0
            }

        Oak ->
            { type_ = Oak
            , title = "Oak"
            , rewardText = "N/A"
            , xpGranted = 10.0
            }

        Willow ->
            { type_ = Willow
            , title = "Elm"
            , rewardText = "N/A"
            , xpGranted = 5.0
            }


type alias TreeData =
    { elm : { mxp : Float }
    , oak : { mxp : Float }
    , willow : { mxp : Float }
    }


getMxp : TreeType -> TreeData -> Float
getMxp type_ treeData =
    case type_ of
        Elm ->
            treeData.elm.mxp

        Oak ->
            treeData.oak.mxp

        Willow ->
            treeData.willow.mxp


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


type TreeType
    = Elm
    | Oak
    | Willow


toggleActiveTree : TreeType -> Game -> Game
toggleActiveTree toggleType game =
    let
        newActiveTree =
            case game.activeTree of
                Just ( type_, _ ) ->
                    if type_ == toggleType then
                        Nothing

                    else
                        Just ( toggleType, IdleGame.Timer.create 2000 )

                Nothing ->
                    Just ( toggleType, IdleGame.Timer.create 2000 )
    in
    { game | activeTree = newActiveTree }



-- skillLevelFromXp : Float -> Int
-- skillLevelFromXp xp =
-- Handle ticks


timeOfNextTick : Game -> Posix
timeOfNextTick game =
    game
        |> .currentTime
        |> Time.Extra.add Time.Extra.Millisecond IdleGame.Timer.tickDuration Time.utc


tick : Game -> Game
tick game =
    let
        ( newActiveTree, { xp, mxp } ) =
            case game.activeTree of
                Nothing ->
                    ( game.activeTree, { xp = 0.0, mxp = 0.0 } )

                Just ( treeType, timer ) ->
                    let
                        ( newTimer, completions ) =
                            IdleGame.Timer.tick timer

                        tree =
                            getTree treeType
                    in
                    ( Just ( treeType, newTimer ), { xp = tree.xpGranted * toFloat completions, mxp = 1.0 * toFloat completions } )
    in
    { game
        | currentTime = timeOfNextTick game
        , activeTree = newActiveTree
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
        -- Note: be careful with the next line causing stack overflows. It is written in a particular way to allow Tail-call elimination and should stay that way.
        -- Additional reading: https://jfmengels.net/tail-call-optimization/
        updateGameToTime now (tick game)

    else
        game


updateCurrentTime : Posix -> Game -> Game
updateCurrentTime now game =
    { game | currentTime = now }



-- Time passes logic


type alias TimePassesItemGain =
    { amount : Int
    , title : String
    , icon : FeatherIcons.Icon
    }


type alias TimePassesItemLoss =
    { amount : Int
    , title : String
    , icon : FeatherIcons.Icon
    }


type alias TimePassesXpGain =
    { amount : Int
    , title : String
    }


type alias TimePassesData =
    { timePassed : Int
    , xpGains : List TimePassesXpGain
    , itemGains : List TimePassesItemGain
    , itemLosses : List TimePassesItemLoss
    }


getTimePassesData : Game -> Game -> TimePassesData
getTimePassesData oldGame newGame =
    { timePassed = Time.posixToMillis newGame.currentTime - Time.posixToMillis oldGame.currentTime
    , xpGains =
        [ { title = "Woodchopping XP"
          , amount = floor newGame.woodcuttingXp - floor oldGame.woodcuttingXp
          }
        ]
    , itemGains = []
    , itemLosses = []
    }
