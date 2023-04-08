module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import IdleGame.Adventuring as Adventuring exposing (Adventuring)
import IdleGame.Chore as Chore
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.GameTypes exposing (..)
import IdleGame.Multiplicable as Multiplicable
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.XpFormulas
import List.Extra
import Maybe.Extra
import Quantity
import Random exposing (Generator)
import Tuple



-- Public


type alias Game =
    { seed : Random.Seed
    , choresXp : Counter
    , choresMxp : Counter
    , activeChore : Maybe ( ChoreKind, Timer )
    , choresData : Chore.AllChoreStates
    , coin : Counter
    , resources : Resource.Amounts
    , shopItems : ShopItems
    , adventuring : Adventuring
    , combatsWon : Int
    , combatsLost : Int
    }


create : Random.Seed -> Game
create seed =
    { seed = seed
    , choresXp = Counter.create 0
    , choresMxp = Counter.create 0
    , activeChore = Nothing
    , choresData =
        { cleanStables = { mxp = Counter.create 0 }
        , cleanBigBubba = { mxp = Counter.create 0 }
        , sweepChimneys = { mxp = Counter.create 0 }
        , waterGreenhousePlants = { mxp = Counter.create 0 }
        , washRobes = { mxp = Counter.create 0 }
        , organizePotionIngredients = { mxp = Counter.create 0 }
        , repairInstruments = { mxp = Counter.create 0 }
        , flushDrainDemons = { mxp = Counter.create 0 }
        , organizeSpellBooks = { mxp = Counter.create 0 }
        }
    , coin = Counter.create 0
    , resources = Resource.createResources
    , shopItems = ShopItems.create
    , adventuring = Adventuring.create
    , combatsWon = 0
    , combatsLost = 0
    }


type ChoresListItem
    = LockedChore Int
    | ChoreItem ChoreKind


choreUnlockRequirements =
    [ ( CleanStables, 1 )
    , ( CleanBigBubba, 10 )
    , ( SweepChimneys, 25 )
    , ( WaterGreenhousePlants, 35 )
    , ( WashAndIronRobes, 45 )
    , ( OrganizePotionIngredients, 55 )
    , ( RepairInstruments, 65 )
    , ( FlushDrainDemons, 75 )
    , ( OrganizeSpellBooks, 90 )
    ]


getChoreListItems : Game -> List ChoresListItem
getChoreListItems { choresXp } =
    let
        skillLevel =
            choresXp
                |> Counter.getValue
                |> IdleGame.XpFormulas.skillLevel

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


getEvent : ChoreKind -> Event
getEvent kind =
    let
        outcome =
            (Chore.getStats kind).outcome

        { xp, extraResourceProbability, extraResource, coin } =
            outcome
    in
    Event
        { effects =
            [ gainXp xp ChoresSkill
                |> withTags [ Chores, ChoreTag kind ]
            , gainChoreMxp kind
                |> withTags [ Chores, ChoreTag kind ]
            , gainWithProbability extraResourceProbability
                [ gainResource 1 extraResource |> withTags [ Chores ]
                ]
                |> withTags [ Chores, ChoreTag kind ]
            , gainCoin coin
                |> withTags [ Chores, ChoreTag kind ]
            ]
        }


type alias ActivityStatus =
    Maybe Timer


toggleActiveChore : ChoreKind -> Game -> Game
toggleActiveChore toggleType game =
    let
        newActiveChore =
            case game.activeChore of
                Just ( type_, _ ) ->
                    if type_ == toggleType then
                        Nothing

                    else
                        Just ( toggleType, Timer.create )

                Nothing ->
                    Just ( toggleType, Timer.create )
    in
    { game | activeChore = newActiveChore }


setActiveChore : Maybe ( ChoreKind, Timer.Timer ) -> Game -> Game
setActiveChore activeChore g =
    { g | activeChore = activeChore }


setMonster : Combat.MonsterKind -> Game -> Game
setMonster newMonster game =
    { game | adventuring = Adventuring.setMonster newMonster game.adventuring }


startFight : Game -> Game
startFight game =
    { game | adventuring = Adventuring.startFight game.adventuring }


stopFight : Game -> Game
stopFight game =
    { game | adventuring = Adventuring.stopFight game.adventuring }


setPlayerMove : Int -> Combat.PlayerMove -> Game -> Game
setPlayerMove index move game =
    { game | adventuring = Adventuring.setPlayerMove index move game.adventuring }


applyIntervalMods : List IntervalMod -> Duration -> Duration
applyIntervalMods mods duration =
    let
        multiplier =
            (mods
                |> List.map .percentChange
                |> List.sum
            )
                + 1
    in
    Quantity.divideBy multiplier duration


getModdedDuration : Game -> ChoreKind -> Duration
getModdedDuration game choreKind =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        stats =
            Chore.getStats choreKind

        mods =
            getAllIntervalMods game
                |> List.filter (\{ kind } -> kind == choreKind)
    in
    stats.outcome.duration
        |> applyIntervalMods mods


combatReward : Event
combatReward =
    Event { effects = [ gainCoin 25 ] }


rewardPlayer : Game -> Generator ( Game, List Toast )
rewardPlayer game =
    let
        modifiedCombatReward =
            applyModsToEvent (getAllMods game) combatReward

        effects : List Effect
        effects =
            case modifiedCombatReward of
                ModdedEvent eventData ->
                    eventData.effects
    in
    List.foldl effectReducer (Random.constant ( game, [] )) effects


incrementCombatsWon : Game -> Game
incrementCombatsWon game =
    { game | combatsWon = game.combatsWon + 1 }


incrementCombatsLost : Game -> Game
incrementCombatsLost game =
    { game | combatsLost = game.combatsLost + 1 }


updateAdventuring : Duration -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
updateAdventuring delta generator =
    generator
        |> Random.andThen
            (\( game, toasts ) ->
                Adventuring.update delta game.adventuring
                    |> Random.andThen
                        (\updateResult ->
                            case updateResult of
                                Adventuring.PlayerWon timeRemaining newAdventuring ->
                                    let
                                        updatedGenerator : Generator ( Game, List Toast )
                                        updatedGenerator =
                                            game
                                                |> (\g -> { g | adventuring = newAdventuring })
                                                |> incrementCombatsWon
                                                |> rewardPlayer
                                                |> Random.map (\( g, t ) -> ( g, toasts ++ t ))
                                    in
                                    updateAdventuring timeRemaining updatedGenerator

                                Adventuring.MonsterWon timeRemaining newAdventuring ->
                                    let
                                        updatedGenerator : Generator ( Game, List Toast )
                                        updatedGenerator =
                                            game
                                                |> (\g -> { g | adventuring = newAdventuring })
                                                |> incrementCombatsLost
                                                |> (\g -> Random.constant ( g, toasts ))
                                    in
                                    updateAdventuring timeRemaining updatedGenerator

                                Adventuring.Continue newAdventuring ->
                                    let
                                        updatedGenerator : Generator ( Game, List Toast )
                                        updatedGenerator =
                                            game
                                                |> (\g -> { g | adventuring = newAdventuring })
                                                |> (\g -> Random.constant ( g, toasts ))
                                    in
                                    updatedGenerator
                        )
            )


tick : Duration -> Game -> ( Game, List Toast )
tick delta game =
    let
        ( newActiveChore, events ) =
            case game.activeChore of
                Nothing ->
                    ( game.activeChore, [] )

                Just ( choreKind, timer ) ->
                    let
                        choreDuration =
                            getModdedDuration game choreKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment choreDuration delta

                        activeChore =
                            Just ( choreKind, newTimer )

                        newEvents =
                            List.repeat completions (getEvent choreKind)
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

        gameGenerator : Generator ( Game, List Toast )
        gameGenerator =
            game
                |> setActiveChore newActiveChore
                |> (\g -> updateAdventuring delta (Random.constant ( g, [] )))
                |> (\g -> List.foldl effectReducer g effects)

        ( ( newGame, notifications ), newSeed ) =
            Random.step gameGenerator game.seed
    in
    ( { newGame | seed = newSeed }, notifications )


effectReducer : Effect -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
effectReducer effect gen =
    gen
        |> Random.andThen
            (\( game, notifications ) ->
                applyEffect effect game
                    |> Random.map
                        (\( newGame, newToasts ) ->
                            ( newGame, notifications ++ newToasts )
                        )
            )


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


calculateChoreMxp : { multiplier : Float, kind : ChoreKind } -> Game -> { mxp : Counter, masteryPoolXp : Counter }
calculateChoreMxp { multiplier, kind } game =
    -- Important! Keep the application here in sync with Views.Chores.elm
    let
        choreStats =
            Chore.getStats kind

        { mxp } =
            choreStats.getter game.choresData

        currentMasteryLevel =
            mxp
                |> Counter.getValue
                |> IdleGame.XpFormulas.skillLevel

        grantedMxp =
            toFloat currentMasteryLevel
                * Duration.inSeconds choreStats.outcome.duration
                * multiplier
                |> floor
                |> Counter.create

        grantedMasteryPoolXp =
            Counter.multiplyBy 0.5 grantedMxp
    in
    { mxp = grantedMxp, masteryPoolXp = grantedMasteryPoolXp }


applyEffect : Effect -> Game -> Generator ( Game, List Toast )
applyEffect effect game =
    case getType effect of
        VariableSuccess { successProbability, successEffects, failureEffects } ->
            -- Important! Keep the application here in sync with Views.Chores.elm
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
                        List.foldl effectReducer (Random.constant ( game, [] )) chosenEffects
                    )

        GainResource quantity resource ->
            -- Important! Keep the application here in sync with Views.Chores.elm
            intGenerator quantity
                |> Random.map (\amount -> addResource resource amount game)

        GainXp quantity skill ->
            -- Important! Keep the application here in sync with Views.Chores.elm
            Multiplicable.toCounter quantity
                |> (\amount -> ( addXp skill amount game, [] ))
                |> Random.constant

        GainChoreMxp { multiplier } kind ->
            -- Important! Keep the application here in sync with Views.Chores.elm
            let
                { mxp, masteryPoolXp } =
                    calculateChoreMxp { multiplier = multiplier, kind = kind } game
            in
            game
                |> addMxp kind mxp
                |> addMasteryPoolXp masteryPoolXp
                |> (\newGame -> Random.constant ( newGame, [] ))

        GainCoin quantity ->
            -- Important! Keep the application here in sync with Views.Chores.elm
            let
                newCounter =
                    Multiplicable.toCounter quantity
            in
            addCoin newCounter game
                |> Random.constant


addResource : Resource.Kind -> Int -> Game -> ( Game, List Toast )
addResource resource amount game =
    ( { game
        | resources =
            game.resources
                |> Resource.addResource resource amount
      }
    , [ GainedResource amount resource ]
    )


addXp : Skill -> Counter -> Game -> Game
addXp resource amount game =
    case resource of
        ChoresSkill ->
            { game | choresXp = Counter.add game.choresXp amount }


addMxp : ChoreKind -> Counter -> Game -> Game
addMxp kind amount game =
    let
        fn { mxp } =
            { mxp = Counter.add mxp amount }

        stats =
            Chore.getStats kind
    in
    { game | choresData = stats.setter fn game.choresData }


addMasteryPoolXp : Counter -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = Counter.add game.choresMxp amount }


addCoin : Counter -> Game -> ( Game, List Toast )
addCoin amount game =
    ( { game | coin = Counter.add game.coin amount }, [ GainedCoin amount ] )


gainResource : Int -> Resource.Kind -> Effect
gainResource amount resource =
    Effect { type_ = GainResource { base = amount, doublingChance = 0 } resource, tags = [] }


gainXp : Int -> Skill -> Effect
gainXp amount skill =
    let
        skillTag =
            case skill of
                ChoresSkill ->
                    Chores

        xp =
            Multiplicable.fromInt amount
    in
    Effect { type_ = GainXp xp skill, tags = [ Xp, skillTag ] }


gainChoreMxp : ChoreKind -> Effect
gainChoreMxp kind =
    Effect { type_ = GainChoreMxp { multiplier = 1 } kind, tags = [ Mxp, Chores, ChoreTag kind ] }


gainCoin : Int -> Effect
gainCoin amount =
    let
        coin =
            Multiplicable.fromInt amount
    in
    Effect { type_ = GainCoin coin, tags = [] }


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


type alias TimePassesResourceGain =
    { amount : Int
    , title : String
    }


type alias TimePassesResourceLoss =
    { amount : Int
    , title : String
    }


type alias TimePassesXpGain =
    { originalXp : Counter
    , currentXp : Counter
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Counter
    , resourcesDiff : Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGains =
            if originalGame.choresXp == currentGame.choresXp then
                []

            else
                [ { title = "Chores", originalXp = originalGame.choresXp, currentXp = currentGame.choresXp } ]

        resourcesDiff =
            Resource.getDiff { original = originalGame.resources, current = currentGame.resources }

        combatsWonDiff =
            currentGame.combatsWon - originalGame.combatsWon

        combatsLostDiff =
            currentGame.combatsLost - originalGame.combatsLost

        coinGains : Maybe Counter
        coinGains =
            if Counter.getValue currentGame.coin > Counter.getValue originalGame.coin then
                Just <| Counter.subtract currentGame.coin originalGame.coin

            else
                Nothing

        hasNewData =
            not <|
                (List.isEmpty xpGains
                    && Resource.isEmptyDiff resourcesDiff
                    && Maybe.Extra.isNothing coinGains
                    && (combatsWonDiff == 0)
                    && (combatsLostDiff == 0)
                )
    in
    if hasNewData then
        Just
            { xpGains = xpGains
            , coinGains = coinGains
            , resourcesDiff = resourcesDiff
            , combatsWonDiff = combatsWonDiff
            , combatsLostDiff = combatsLostDiff
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


choreMasteryPoolCheckpoints : MasteryPoolCheckpoints
choreMasteryPoolCheckpoints =
    { ten = choresXpBuff 0.25
    , twentyFive = choresCoinBuff 0.15
    , fifty = choresMxpBuff 0.25
    , ninetyFive =
        choresResourceBuff 1.0
            |> includeVariableEffects
    }


getChoreMasteryPoolMods : Game -> List Mod
getChoreMasteryPoolMods game =
    let
        mxpPercent =
            game.choresMxp
                |> Counter.getValue
                |> IdleGame.XpFormulas.masteryPoolPercent

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



-- Mastery thresholds for specific chores


getChoreUnlocksMods : Game -> List Mod
getChoreUnlocksMods game =
    Chore.allKinds
        |> List.concatMap
            (\kind ->
                let
                    stats =
                        Chore.getStats kind

                    masteryLevel =
                        (stats.getter game.choresData).mxp
                            |> Counter.getValue
                            |> IdleGame.XpFormulas.skillLevel

                    everyTenLevelsMod =
                        successBuff 0.05
                            |> withHowManyTimesToApplyMod (masteryLevel // 10)
                            -- repeat once for each ten levels
                            |> modWithTags [ Chores, ChoreTag kind ]
                in
                [ everyTenLevelsMod
                ]
            )


getShopItemMods : Game -> List Mod
getShopItemMods game =
    game.shopItems
        |> ShopItems.toOwnedItems
        |> List.map (\shopItem -> (ShopItems.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopItems.ShopItemMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getShopItemIntervalMods : Game -> List IntervalMod
getShopItemIntervalMods game =
    game.shopItems
        -- |> (\x -> Debug.log "foobar inside getShopItemIntervalMods" x)
        |> ShopItems.toOwnedItems
        |> List.map (\shopItem -> (ShopItems.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopItems.ShopItemIntervalMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getChoreUnlocksIntervalMods : Game -> List IntervalMod
getChoreUnlocksIntervalMods game =
    Chore.allKinds
        |> List.map
            (\kind ->
                let
                    stats =
                        Chore.getStats kind

                    masteryLevel : Int
                    masteryLevel =
                        (stats.getter game.choresData).mxp
                            |> Counter.getValue
                            |> IdleGame.XpFormulas.skillLevel

                    timesToApplyMod =
                        if masteryLevel >= 99 then
                            2

                        else if masteryLevel >= 50 then
                            1

                        else
                            0
                in
                { kind = kind
                , percentChange = timesToApplyMod * 0.1
                }
            )


getAllMods : Game -> List Mod
getAllMods game =
    getChoreMasteryPoolMods game
        ++ getChoreUnlocksMods game
        ++ getShopItemMods game



-- Interval Mods


getAllIntervalMods : Game -> List IntervalMod
getAllIntervalMods game =
    let
        shopItemIntervalMods =
            getShopItemIntervalMods game

        choreUnlockIntervalMods =
            getChoreUnlocksIntervalMods game
    in
    shopItemIntervalMods ++ choreUnlockIntervalMods
