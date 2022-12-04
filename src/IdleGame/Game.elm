module IdleGame.Game exposing (..)

import FeatherIcons
import IdleGame.Event exposing (Event, Mod)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer
import IdleGame.XpFormulas
import Set exposing (Set)
import Time exposing (Posix)
import Time.Extra



-- Public


type alias Game =
    { currentTime : Posix
    , choresXp : Float
    , choresMxp : Float
    , activeTree : Maybe ( ChoreType, IdleGame.Timer.Timer )
    , treeData : TreeData
    }


create : Posix -> Game
create now =
    { currentTime = now
    , choresXp = 0
    , choresMxp = 0
    , activeTree = Nothing
    , treeData =
        { elm = { mxp = 0 }
        , oak = { mxp = 0 }
        , willow = { mxp = 0 }
        }
    }


type ChoresListItem
    = LockedChore Int
    | ChoreItem ChoreType


treeUnlockRequirements =
    [ ( CleanStables, 1 )
    , ( CleanBigBubba, 2 )
    , ( GatherFirewood, 3 )
    ]


getChoreListItems : Game -> List ChoresListItem
getChoreListItems { choresXp } =
    let
        skillLevel =
            IdleGame.XpFormulas.skillLevel choresXp

        unlockedTreeTypes =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel <= skillLevel)
                |> List.map (\( type_, _ ) -> ChoreItem type_)

        maybeNextUnlock =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel > skillLevel)
                |> List.sortBy Tuple.second
                |> List.head
                |> Maybe.map (\( _, level ) -> LockedChore level)
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    unlockedTreeTypes ++ maybeNextUnlock



-- Private


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc



-- Chores


type alias Chore =
    { type_ : ChoreType
    , title : String
    , rewardText : String
    , xp : Float
    }


getChore : ChoreType -> Chore
getChore type_ =
    case type_ of
        CleanStables ->
            { type_ = CleanStables
            , title = "Clean Stables"
            , rewardText = "N/A"
            , xp = 5.0
            }

        CleanBigBubba ->
            { type_ = CleanBigBubba
            , title = "Clean Big Bubba's Stall"
            , rewardText = "N/A"
            , xp = 10.0
            }

        GatherFirewood ->
            { type_ = GatherFirewood
            , title = "Gather Firewood"
            , rewardText = "N/A"
            , xp = 15.0
            }


incrementTreeMxp : Float -> ChoreType -> TreeData -> TreeData
incrementTreeMxp amount type_ treeData =
    case type_ of
        CleanStables ->
            { treeData | elm = { mxp = treeData.elm.mxp + amount } }

        CleanBigBubba ->
            { treeData | oak = { mxp = treeData.oak.mxp + amount } }

        GatherFirewood ->
            { treeData | willow = { mxp = treeData.willow.mxp + amount } }


type alias TreeData =
    { elm : { mxp : Float }
    , oak : { mxp : Float }
    , willow : { mxp : Float }
    }


getMxp : ChoreType -> TreeData -> Float
getMxp type_ treeData =
    getMastery type_ treeData
        |> IdleGame.XpFormulas.skillLevel
        |> toFloat


getMastery : ChoreType -> TreeData -> Float
getMastery type_ treeData =
    case type_ of
        CleanStables ->
            treeData.elm.mxp

        CleanBigBubba ->
            treeData.oak.mxp

        GatherFirewood ->
            treeData.willow.mxp


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


toggleActiveTree : ChoreType -> Game -> Game
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


setCurrentTime : Time.Posix -> Game -> Game
setCurrentTime time g =
    { g | currentTime = time }


setActiveTree : Maybe ( ChoreType, IdleGame.Timer.Timer ) -> Game -> Game
setActiveTree activeTree g =
    { g | activeTree = activeTree }


tick : Game -> Game
tick game =
    let
        ( newActiveTree, events ) =
            case game.activeTree of
                Nothing ->
                    ( game.activeTree, [] )

                Just ( treeType, timer ) ->
                    let
                        ( newTimer, completions ) =
                            IdleGame.Timer.tick timer

                        tree =
                            getChore treeType

                        mxpGained =
                            getMxp tree.type_ game.treeData
                    in
                    ( Just ( treeType, newTimer ), List.repeat completions (IdleGame.Event.gainChoresXp tree.xp) ++ List.repeat completions (IdleGame.Event.gainChoresMxp mxpGained tree.type_) )

        mods =
            getAllMods game

        modifiedEvents =
            List.map (IdleGame.Event.modifyEvent mods) events
    in
    game
        |> setActiveTree newActiveTree
        |> (\g -> List.foldl applyEvent g modifiedEvents)
        |> setCurrentTime (timeOfNextTick game)


applyEvent : Event -> Game -> Game
applyEvent event game =
    case event.type_ of
        IdleGame.Event.ChoresXp amount ->
            { game | choresXp = game.choresXp + amount }

        IdleGame.Event.ChoresMxp amount treeType ->
            { game
                | choresMxp = game.choresMxp + (amount / 2)
                , treeData = incrementTreeMxp amount treeType game.treeData
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
          , amount = floor newGame.choresXp - floor oldGame.choresXp
          }
        ]
    , itemGains = []
    , itemLosses = []
    }



-- Events


getAllMods : Game -> List Mod
getAllMods game =
    []
        ++ [ IdleGame.Event.devGlobalXpBuff ]
        ++ (if game.choresMxp > 10 then
                [ IdleGame.Event.masteryXpBuff ]

            else
                [ IdleGame.Event.bigMasteryXpBuff ]
           )
