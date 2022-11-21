module IdleGame.Game exposing (..)

import FeatherIcons
import IdleGame.Timer
import IdleGame.XpFormulas
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


treeUnlockRequirements =
    [ ( Elm, 1 )
    , ( Oak, 2 )
    , ( Willow, 3 )
    ]


getWoodcuttingListItems : Game -> List WoodcuttingListItem
getWoodcuttingListItems { woodcuttingXp } =
    let
        skillLevel =
            IdleGame.XpFormulas.skillLevel woodcuttingXp

        unlockedTreeTypes =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel <= skillLevel)
                |> List.map (\( type_, _ ) -> WoodcuttingTree type_)

        maybeNextUnlock =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel > skillLevel)
                |> List.sortBy Tuple.second
                |> List.head
                |> Maybe.map (\( _, level ) -> WoodcuttingLockedItem level)
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    unlockedTreeTypes ++ maybeNextUnlock



-- Private


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


setCurrentTime : Time.Posix -> Game -> Game
setCurrentTime time g =
    { g | currentTime = time }


setActiveTree : Maybe ( TreeType, IdleGame.Timer.Timer ) -> Game -> Game
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
                            getTree treeType
                    in
                    ( Just ( treeType, newTimer ), List.repeat completions (gainWoodcuttingXp tree.xpGranted) )

        modifiedEvents =
            applyMods (getMods game) events
    in
    game
        |> (\g -> List.foldl applyModifiedEvent g modifiedEvents)
        |> setCurrentTime (timeOfNextTick game)
        |> setActiveTree newActiveTree


applyModifiedEvent : ( Event, List Mod ) -> Game -> Game
applyModifiedEvent ( event, mods ) game =
    case event.type_ of
        WoodcuttingXp amount ->
            let
                applyMod mod a =
                    case mod.type_ of
                        Percent p ->
                            a * (p / 100 + 1)

                finalAmount =
                    List.foldl applyMod amount mods
            in
            { game | woodcuttingXp = game.woodcuttingXp + finalAmount }


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



-- Events


type Tag
    = Woodcutting
    | Xp


type EventType
    = WoodcuttingXp Float


type alias Event =
    { type_ : EventType
    , tags : List Tag
    }


gainWoodcuttingXp : Float -> Event
gainWoodcuttingXp amount =
    { type_ = WoodcuttingXp amount
    , tags = [ Woodcutting, Xp ]
    }


type ModType
    = Percent Float


type alias Mod =
    { type_ : ModType
    , tags : List Tag
    }


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { type_ = Percent 100.0
    , tags = [ Xp ]
    }


getMods : Game -> List Mod
getMods game =
    [ devGlobalXpBuff
    ]


listContains : List a -> List a -> Bool
listContains inner outer =
    List.all (\el -> List.member el outer) inner


applyMods : List Mod -> List Event -> List ( Event, List Mod )
applyMods mods events =
    events
        |> List.map
            (\event ->
                ( event
                , List.filter (\mod -> listContains mod.tags event.tags) mods
                )
            )
