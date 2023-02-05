module IdleGame.Game exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Event exposing (..)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Timer as Timer exposing (Timer)
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
    , activeChore : Maybe ( Chore.Kind, Timer )
    , choresData : Chore.AllChoreStates
    , gold : Int
    , resources : Resource.Amounts
    , shopItems : ShopItems
    }


create : Random.Seed -> Game
create seed =
    { seed = seed

    -- , choresXp = 0
    -- , choresMxp = 0
    , choresXp = 14391160
    , choresMxp = 4500000 / 2
    , activeChore = Nothing
    , choresData =
        { cleanStables = { mxp = 0 }
        , cleanBigBubba = { mxp = 0 }
        , sweepChimneys = { mxp = 0 }
        , waterGreenhousePlants = { mxp = 0 }
        , washRobes = { mxp = 0 }
        , organizePotionIngredients = { mxp = 0 }
        , repairInstruments = { mxp = 0 }
        , flushDrainDemons = { mxp = 0 }
        , organizeSpellBooks = { mxp = 0 }
        }
    , gold = 0
    , resources = Resource.createResources
    , shopItems = ShopItems.create
    }


type ChoresListItem
    = LockedChore Int
    | ChoreItem Chore.Kind


choreUnlockRequirements =
    [ ( Chore.CleanStables, 1 )
    , ( Chore.CleanBigBubba, 10 )
    , ( Chore.SweepChimneys, 25 )
    , ( Chore.WaterGreenhousePlants, 35 )
    , ( Chore.WashAndIronRobes, 45 )
    , ( Chore.OrganizePotionIngredients, 55 )
    , ( Chore.RepairInstruments, 65 )
    , ( Chore.FlushDrainDemons, 75 )
    , ( Chore.OrganizeSpellBooks, 90 )
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


getEvent : Chore.Stats -> Event
getEvent { kind, outcome } =
    let
        { xp, extraResourceProbability, extraResource, gold } =
            outcome
    in
    Event
        { effects =
            [ gainXp xp ChoresSkill
            , gainChoreMxp kind
            , gainWithProbability extraResourceProbability [ gainResource 1 extraResource ]
            , gainGold gold
            ]
        , tags = [ Chores, ChoreTag kind ]
        }


type alias ActivityStatus =
    Maybe Timer


toggleActiveChore : Chore.Kind -> Game -> Game
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


setActiveChore : Maybe ( Chore.Kind, Timer.Timer ) -> Game -> Game
setActiveChore activeChore g =
    { g | activeChore = activeChore }


tick : Game -> ( Game, List Toast )
tick game =
    let
        ( newActiveChore, events ) =
            case game.activeChore of
                Nothing ->
                    ( game.activeChore, [] )

                Just ( choreKind, timer ) ->
                    let
                        choreStats =
                            Chore.getStats choreKind

                        choreDuration =
                            -- TODO: apply mods
                            choreStats.outcome.duration

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment choreDuration Timer.tickDuration

                        activeChore =
                            Just ( choreKind, newTimer )

                        newEvents =
                            []
                                ++ List.repeat completions (getEvent choreStats)
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
                |> (\g -> List.foldl effectReducer (Random.constant ( g, [] )) effects)

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


floatGenerator : { base : Float, multiplier : Float } -> Generator Float
floatGenerator { base, multiplier } =
    Random.constant <| base * multiplier


applyEffect : Effect -> Game -> Generator ( Game, List Toast )
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
                        List.foldl effectReducer (Random.constant ( game, [] )) chosenEffects
                    )

        GainResource quantity resource ->
            intGenerator quantity
                |> Random.map (\amount -> addResource resource amount game)

        GainXp quantity skill ->
            floatGenerator quantity
                |> Random.map (\amount -> ( addXp skill amount game, [] ))

        GainChoreMxp { multiplier } kind ->
            let
                { mxp } =
                    (Chore.getStats kind).getter game.choresData
            in
            game
                |> addMxp kind (mxp * multiplier)
                |> addMasteryPoolXp (mxp * multiplier / 2)
                |> (\newGame -> Random.constant ( newGame, [] ))

        GainGold quantity ->
            intGenerator quantity
                |> Random.map (\amount -> addGold amount game)


addResource : Resource.Kind -> Int -> Game -> ( Game, List Toast )
addResource resource amount game =
    ( { game
        | resources =
            game.resources
                |> Resource.addResource resource amount
      }
    , [ GainedResource amount resource ]
    )


addXp : Skill -> Float -> Game -> Game
addXp resource amount game =
    case resource of
        ChoresSkill ->
            { game | choresXp = game.choresXp + amount }


addMxp : Chore.Kind -> Float -> Game -> Game
addMxp kind amount game =
    let
        fn { mxp } =
            { mxp = mxp + amount }

        stats =
            Chore.getStats kind
    in
    { game | choresData = stats.setter fn game.choresData }


addMasteryPoolXp : Float -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = game.choresMxp + amount }


addGold : Int -> Game -> ( Game, List Toast )
addGold amount game =
    ( { game | gold = game.gold + amount }, [ GainedGold amount ] )


applyEvent : ModdedEvent -> Game -> Random.Generator ( Game, List Toast )
applyEvent (ModdedEvent eventData) game =
    let
        reducer : Effect -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
        reducer effect gen =
            gen
                |> Random.andThen
                    (\( accumGame, notifications ) ->
                        applyEffect effect accumGame
                            |> Random.map
                                (\( newGame, newToasts ) ->
                                    ( newGame, notifications ++ newToasts )
                                )
                    )
    in
    List.foldl
        reducer
        (Random.constant ( game, [] ))
        eventData.effects


gainResource : Int -> Resource.Kind -> Effect
gainResource amount resource =
    Effect { type_ = GainResource { base = amount, doublingChance = 0 } resource, tags = [] }


gainXp : Float -> Skill -> Effect
gainXp amount skill =
    let
        skillTag =
            case skill of
                ChoresSkill ->
                    Chores
    in
    Effect { type_ = GainXp { base = amount, multiplier = 1 } skill, tags = [ Xp, skillTag ] }


gainChoreMxp : Chore.Kind -> Effect
gainChoreMxp chore =
    Effect { type_ = GainChoreMxp { multiplier = 1 } chore, tags = [ Mxp, Chores ] }


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


type alias TimePassesResourceGain =
    { amount : Int
    , title : String
    }


type alias TimePassesResourceLoss =
    { amount : Int
    , title : String
    }


type alias TimePassesXpGain =
    { originalXp : Float
    , currentXp : Float
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , goldGains : Maybe Int
    , resourcesDiff : Resource.Diff
    }


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGains =
            if originalGame.choresXp == currentGame.choresXp then
                []

            else
                [ { title = "Chores", originalXp = originalGame.choresXp, currentXp = currentGame.choresXp } ]

        goldGains =
            if currentGame.gold > originalGame.gold then
                Just <| currentGame.gold - originalGame.gold

            else
                Nothing

        resourcesDiff =
            Resource.getDiff { original = originalGame.resources, current = currentGame.resources }

        hasNewData =
            not <| (List.isEmpty xpGains && Resource.isEmptyDiff resourcesDiff)
    in
    if hasNewData then
        Just
            { xpGains = xpGains
            , goldGains = goldGains
            , resourcesDiff = resourcesDiff
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

        choreUnlocksFor : (Chore.AllChoreStates -> Chore.State) -> Tag -> Mod
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
    [ choreUnlocksFor .cleanStables (ChoreTag Chore.CleanStables)
    , choreUnlocksFor .cleanBigBubba (ChoreTag Chore.CleanBigBubba)
    ]


getShopItemMods : Game -> List Mod
getShopItemMods game =
    game.shopItems
        |> ShopItems.toOwnedItems
        |> List.map ShopItems.getMod


getAllMods : Game -> List Mod
getAllMods game =
    []
        -- ++ [ devGlobalXpBuff ]
        -- ++ getChoreMasteryPoolMods game
        -- ++ getChoreUnlocksMods game
        ++ getShopItemMods game
