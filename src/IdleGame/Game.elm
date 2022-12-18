module IdleGame.Game exposing (..)

import IdleGame.Event exposing (Event, Mod)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.XpFormulas
import Set exposing (Set)
import Tuple



-- Public


type alias Game =
    { choresXp : Float
    , choresMxp : Float
    , activeChore : Maybe ( ChoreType, IdleGame.Timer.Timer )
    , choresData : ChoresData
    }


type alias ChoresData =
    { cleanStables : ChoreData
    , cleanBigBubba : ChoreData
    , gatherFirewood : ChoreData
    }


type alias ChoreData =
    { mxp : Float }


create : Game
create =
    { choresXp = 0
    , choresMxp = 0
    , activeChore = Nothing
    , choresData =
        { cleanStables = { mxp = 0 }
        , cleanBigBubba = { mxp = 0 }
        , gatherFirewood = { mxp = 0 }
        }
    }


type ChoresListItem
    = LockedChore Int
    | ChoreItem ChoreType


choreUnlockRequirements =
    [ ( CleanStables, 1 )
    , ( CleanBigBubba, 2 )
    , ( GatherFirewood, 3 )
    ]


getChoreListItems : Game -> List ChoresListItem
getChoreListItems { choresXp } =
    let
        skillLevel =
            IdleGame.XpFormulas.skillLevel choresXp

        unlockedChoreTypes =
            choreUnlockRequirements
                |> List.filter (\( _, choreLevel ) -> choreLevel <= skillLevel)
                |> List.map (\( type_, _ ) -> ChoreItem type_)

        maybeNextUnlock =
            choreUnlockRequirements
                |> List.filter (\( _, choreLevel ) -> choreLevel > skillLevel)
                |> List.sortBy Tuple.second
                |> List.head
                |> Maybe.map (\( _, level ) -> LockedChore level)
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    unlockedChoreTypes ++ maybeNextUnlock



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


incrementChoreMxp : Float -> ChoreType -> ChoresData -> ChoresData
incrementChoreMxp amount type_ choreData =
    case type_ of
        CleanStables ->
            { choreData | cleanStables = { mxp = choreData.cleanStables.mxp + amount } }

        CleanBigBubba ->
            { choreData | cleanBigBubba = { mxp = choreData.cleanBigBubba.mxp + amount } }

        GatherFirewood ->
            { choreData | gatherFirewood = { mxp = choreData.gatherFirewood.mxp + amount } }


getMxp : ChoreType -> ChoresData -> Float
getMxp type_ choreData =
    getMastery type_ choreData
        |> IdleGame.XpFormulas.skillLevel
        |> toFloat


getMastery : ChoreType -> ChoresData -> Float
getMastery type_ choreData =
    case type_ of
        CleanStables ->
            choreData.cleanStables.mxp

        CleanBigBubba ->
            choreData.cleanBigBubba.mxp

        GatherFirewood ->
            choreData.gatherFirewood.mxp


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


toggleActiveChore : ChoreType -> Game -> Game
toggleActiveChore toggleType game =
    let
        newActiveChore =
            case game.activeChore of
                Just ( type_, _ ) ->
                    if type_ == toggleType then
                        Nothing

                    else
                        Just ( toggleType, IdleGame.Timer.create 2000 )

                Nothing ->
                    Just ( toggleType, IdleGame.Timer.create 2000 )
    in
    { game | activeChore = newActiveChore }



-- skillLevelFromXp : Float -> Int
-- skillLevelFromXp xp =
-- Handle ticks


setActiveChore : Maybe ( ChoreType, IdleGame.Timer.Timer ) -> Game -> Game
setActiveChore activeChore g =
    { g | activeChore = activeChore }


tick : Game -> Game
tick game =
    let
        ( newActiveChore, events ) =
            case game.activeChore of
                Nothing ->
                    ( game.activeChore, [] )

                Just ( choreType, timer ) ->
                    let
                        ( newTimer, completions ) =
                            IdleGame.Timer.tick timer

                        chore =
                            getChore choreType

                        mxpGained =
                            getMxp chore.type_ game.choresData
                    in
                    ( Just ( choreType, newTimer ), List.repeat completions (IdleGame.Event.gainChoresXp chore.xp) ++ List.repeat completions (IdleGame.Event.gainChoresMxp mxpGained chore.type_) )

        mods =
            getAllMods game

        modifiedEvents =
            List.map (IdleGame.Event.modifyEvent mods) events
    in
    game
        |> setActiveChore newActiveChore
        |> (\g -> List.foldl applyEvent g modifiedEvents)


applyEvent : Event -> Game -> Game
applyEvent event game =
    case event.type_ of
        IdleGame.Event.ChoresXp amount ->
            { game | choresXp = game.choresXp + amount }

        IdleGame.Event.ChoresMxp amount choreType ->
            { game
                | choresMxp = game.choresMxp + (amount / 2)
                , choresData = incrementChoreMxp amount choreType game.choresData
            }



-- Time passes logic


type alias TimePassesItemGain =
    { amount : Int
    , title : String
    , icon : Icon
    }


type alias TimePassesItemLoss =
    { amount : Int
    , title : String
    , icon : Icon
    }


type alias TimePassesXpGain =
    { amount : Int
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , itemGains : List TimePassesItemGain
    , itemLosses : List TimePassesItemLoss
    }


getTimePassesData : Game -> Game -> TimePassesData
getTimePassesData oldGame newGame =
    { xpGains =
        [ { title = "Chores XP"
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
