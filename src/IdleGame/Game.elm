module IdleGame.Game exposing (..)

import IdleGame.Event3 exposing (..)
import IdleGame.Event3_test exposing (eventWithTags)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource exposing (Resource)
import IdleGame.Timer
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.XpFormulas
import Random exposing (Generator)
import Set exposing (Set)
import Svg.Attributes exposing (in_)
import Tuple



-- Public


type alias Game =
    { seed : Random.Seed
    , choresXp : Float
    , choresMxp : Float
    , activeChore : Maybe ( ChoreType, IdleGame.Timer.Timer )
    , choresData : ChoresData
    , gold : Int
    , manure : Int
    , sticks : Int
    }


type alias ChoresData =
    { cleanStables : ChoreData
    , cleanBigBubba : ChoreData
    , gatherFirewood : ChoreData
    }


type alias ChoreData =
    { mxp : Float }


create : Random.Seed -> Game
create seed =
    { seed = seed
    , choresXp = 0

    -- , choresMxp = 0
    , choresMxp = 4500000 / 2
    , activeChore = Nothing
    , choresData =
        { cleanStables = { mxp = 4500000 / 2 }
        , cleanBigBubba = { mxp = 0 }
        , gatherFirewood = { mxp = 0 }
        }
    , gold = 0
    , manure = 0
    , sticks = 0
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
    -- TODO: the type_ should not be here, otherwise it's possible in the model to store a chore of the wrong type under a key
    { type_ : ChoreType
    , title : String
    , outcome : ChoreOutcome
    }


type alias ChoreOutcome =
    { xp : Float
    , extraResourceProbability : Float
    , extraResource : Resource
    , gold : Int
    }


getEvent : Chore -> Event
getEvent { type_, outcome } =
    let
        { xp, extraResourceProbability, extraResource, gold } =
            outcome
    in
    Event
        { effects =
            [ gainXp xp ChoresSkill
            , gainChoreMxp type_
            , gainWithProbability extraResourceProbability [ gainResource 1 extraResource ]
            , gainGold gold
            ]
        , tags = [ Chores, ChoreTag type_ ]
        }


getChore : ChoreType -> Chore
getChore type_ =
    case type_ of
        CleanStables ->
            { type_ = CleanStables
            , title = "Clean Stables"
            , outcome =
                { xp = 5.0
                , extraResourceProbability = 0.25
                , extraResource = Resource.Manure
                , gold = 5
                }
            }

        CleanBigBubba ->
            { type_ = CleanBigBubba
            , title = "Clean Big Bubba's Stall"
            , outcome =
                { xp = 10.0
                , extraResourceProbability = 1
                , extraResource = Resource.Manure
                , gold = 50
                }
            }

        GatherFirewood ->
            { type_ = GatherFirewood
            , title = "Gather Firewood"
            , outcome =
                { xp = 15.0
                , extraResourceProbability = 0.65
                , extraResource = Resource.Stick
                , gold = 500
                }
            }


updateChoreData : (ChoreData -> ChoreData) -> ChoreType -> ChoresData -> ChoresData
updateChoreData fn type_ choresData =
    case type_ of
        CleanStables ->
            { choresData
                | cleanStables = fn choresData.cleanStables
            }

        CleanBigBubba ->
            { choresData
                | cleanBigBubba = fn choresData.cleanBigBubba
            }

        GatherFirewood ->
            { choresData
                | gatherFirewood = fn choresData.gatherFirewood
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

                        activeChore =
                            Just ( choreType, newTimer )

                        newEvents =
                            []
                                ++ List.repeat completions (getEvent chore)
                    in
                    ( activeChore
                    , newEvents
                    )

        modifiedEvents =
            case events of
                [] ->
                    []

                _ ->
                    let
                        mods =
                            getAllMods game
                    in
                    List.map (applyModsToEvent mods) events

        effects : List Effect
        effects =
            modifiedEvents
                |> List.concatMap (\(ModdedEvent eventData) -> eventData.effects)

        gameGenerator =
            game
                |> setActiveChore newActiveChore
                |> (\g -> List.foldl effectReducer (Random.constant g) effects)

        ( newGame, newSeed ) =
            Random.step gameGenerator game.seed
    in
    { newGame | seed = newSeed }


effectReducer : Effect -> Generator Game -> Generator Game
effectReducer effect =
    Random.andThen (applyEffect effect)


successGenerator : Float -> Generator Bool
successGenerator probability =
    Random.float 0 1
        |> Random.map
            (\num ->
                num < probability
            )


intGenerator : { base : Int, doublingChance : Float } -> Generator Int
intGenerator { base, doublingChance } =
    successGenerator doublingChance
        |> Random.map
            (\doubled ->
                if doubled then
                    base * 2

                else
                    base
            )


floatGenerator : { base : Float, multiplier : Float } -> Generator Float
floatGenerator { base, multiplier } =
    Random.constant <| base * multiplier


applyEffect : Effect -> Game -> Generator Game
applyEffect effect game =
    case getType effect of
        VariableSuccess { successProbability, successEffects, failureEffects } ->
            successGenerator successProbability
                |> Random.andThen
                    (\succeeded ->
                        let
                            chosenEffects =
                                if succeeded then
                                    successEffects

                                else
                                    failureEffects
                        in
                        List.foldl effectReducer (Random.constant game) chosenEffects
                    )

        GainResource quantity resource ->
            intGenerator quantity
                |> Random.map (\amount -> addResource resource amount game)

        GainXp quantity skill ->
            floatGenerator quantity
                |> Random.map (\amount -> addXp skill amount game)

        GainChoreMxp { multiplier } choreType ->
            let
                base =
                    getMxp choreType game.choresData
            in
            game
                |> addMxp choreType (base * multiplier)
                |> addMasteryPoolXp (base * multiplier / 2)
                |> Random.constant

        GainGold quantity ->
            intGenerator quantity
                |> Random.map (\amount -> addGold amount game)


addResource : Resource -> Int -> Game -> Game
addResource resource amount game =
    case resource of
        Resource.Manure ->
            { game | manure = game.manure + amount }

        Resource.Ingot ->
            game

        Resource.Ore ->
            game

        Resource.Ruby ->
            game

        Resource.Stick ->
            { game | sticks = game.sticks + amount }


addXp : Skill -> Float -> Game -> Game
addXp resource amount game =
    case resource of
        ChoresSkill ->
            { game | choresXp = game.choresXp + amount }


addMxp : ChoreType -> Float -> Game -> Game
addMxp choreType amount game =
    let
        fn : ChoreData -> ChoreData
        fn { mxp } =
            { mxp = mxp + amount }
    in
    { game | choresData = updateChoreData fn choreType game.choresData }


addMasteryPoolXp : Float -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = game.choresMxp + amount }


addGold : Int -> Game -> Game
addGold amount game =
    { game | gold = game.gold + amount }


applyEvent : ModdedEvent -> Game -> Random.Generator Game
applyEvent (ModdedEvent eventData) game =
    List.foldl
        (applyEffect >> Random.andThen)
        (Random.constant game)
        eventData.effects


gainResource : Int -> Resource -> Effect
gainResource amount resource =
    Effect { type_ = GainResource { base = amount, doublingChance = 0 } resource, tags = [] }


gainXp : Float -> Skill -> Effect
gainXp amount skill =
    Effect { type_ = GainXp { base = amount, multiplier = 1 } skill, tags = [ Xp ] }


gainChoreMxp : ChoreType -> Effect
gainChoreMxp chore =
    Effect { type_ = GainChoreMxp { multiplier = 1 } chore, tags = [ Mxp ] }


gainGold : Int -> Effect
gainGold amount =
    Effect { type_ = GainGold { base = amount, doublingChance = 1 }, tags = [] }


gainWithProbability : Float -> List Effect -> Effect
gainWithProbability probability successEffects =
    Effect { type_ = VariableSuccess { successProbability = probability, successEffects = successEffects, failureEffects = [] }, tags = [] }


withTags : List Tag -> Effect -> Effect
withTags newTags (Effect { type_, tags }) =
    Effect
        { type_ = type_

        -- TODO: dedupe tags?
        , tags = tags ++ newTags
        }



-- type alias ChoreReward =
--     { xp : Float, mxp : Float,  }
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


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData oldGame newGame =
    let
        choresXpAmount =
            floor newGame.choresXp - floor oldGame.choresXp

        hasNewData =
            choresXpAmount > 0
    in
    if hasNewData then
        Just
            { xpGains =
                [ { title = "Chores XP"
                  , amount = choresXpAmount
                  }
                ]
            , itemGains = []
            , itemLosses = []
            }

    else
        Nothing



-- Events


type alias MasteryPoolCheckpoints =
    { ten : Mod
    , twentyFive : Mod
    , fifty : Mod
    , ninetyFive : Mod
    }


type MasteryUnlocks
    = EveryTenLevels Mod


choreMasteryPoolCheckpoints : MasteryPoolCheckpoints
choreMasteryPoolCheckpoints =
    { ten = choresXpBuff 0.25
    , twentyFive = choresMxpBuff 0.1
    , fifty = choresXpBuff 0.25
    , ninetyFive = choresMxpBuff 0.1
    }


choreMasteryUnlocks : MasteryUnlocks
choreMasteryUnlocks =
    EveryTenLevels (choresMxpBuff 1.0)


getChoreMasteryPoolMods : Game -> List Mod
getChoreMasteryPoolMods game =
    let
        mxpPercent =
            IdleGame.XpFormulas.masteryPoolPercent game.choresMxp

        checkpoints =
            choreMasteryPoolCheckpoints
    in
    if mxpPercent >= 95 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        , checkpoints.fifty
        , checkpoints.ninetyFive
        ]

    else if mxpPercent >= 50 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        , checkpoints.fifty
        ]

    else if mxpPercent >= 25 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        ]

    else if mxpPercent >= 10 then
        [ checkpoints.ten ]

    else
        []


getChoreUnlocksMods : Game -> List Mod
getChoreUnlocksMods game =
    let
        baseBonus =
            case choreMasteryUnlocks of
                EveryTenLevels bonus ->
                    bonus

        choreUnlocksFor : (ChoresData -> ChoreData) -> Tag -> Mod
        choreUnlocksFor getter tag =
            let
                masteryLevel =
                    IdleGame.XpFormulas.skillLevel (getter game.choresData).mxp

                repetitions =
                    masteryLevel // 10
            in
            baseBonus
                |> withMultiplier repetitions
                |> modWithTags [ tag ]
    in
    [ choreUnlocksFor .cleanStables (ChoreTag CleanStables)
    , choreUnlocksFor .cleanBigBubba (ChoreTag CleanBigBubba)
    , choreUnlocksFor .gatherFirewood (ChoreTag GatherFirewood)
    ]


xpTransformer : Float -> Transformer
xpTransformer buff effectMultiplier effect =
    case getType effect of
        GainXp { base, multiplier } skill ->
            effect
                |> setType (GainXp { base = base, multiplier = multiplier + (buff * toFloat effectMultiplier) } skill)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Float -> Transformer
mxpTransformer buff effectMultiplier effect =
    case getType effect of
        GainChoreMxp { multiplier } chore ->
            effect
                |> setType (GainChoreMxp { multiplier = multiplier + (buff * toFloat effectMultiplier) } chore)
                |> ChangeEffect

        _ ->
            NoChange


xpModLabel : Float -> String
xpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% XP"


mxpModLabel : Float -> String
mxpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% Mastery XP"


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { tags = [ Xp ]
    , label = xpModLabel 0.05
    , transformer = xpTransformer 0.05
    , source = AdminCrimes
    , multiplier = 1
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ Chores, Xp ]
    , label = xpModLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , multiplier = 1
    }


choresMxpBuff : Float -> Mod
choresMxpBuff buff =
    { tags = []
    , label = mxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , multiplier = 1
    }


getAllMods : Game -> List Mod
getAllMods game =
    []
        -- ++ [ devGlobalXpBuff ]
        ++ getChoreMasteryPoolMods game
        ++ getChoreUnlocksMods game
