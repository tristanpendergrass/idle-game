module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import Html.Attributes exposing (download)
import IdleGame.Activity as Activity exposing (ActivityImage)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Monster as Monster
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Maybe.Extra
import Percent exposing (Percent)
import Quantity
import Random exposing (Generator)
import Tuple



-- Public


type alias Game =
    { seed : Random.Seed
    , xp : Skill.Record Xp
    , mxp : Activity.Record Xp
    , choresMxp : Xp
    , activitySkilling : Maybe ( Activity, Timer )
    , activityAdventuring : Maybe ( Activity, Timer )
    , monster : Maybe Monster
    , coin : Coin
    , resources : Resource.Record Int
    , shopItems : ShopItems
    , combatsWon : Int
    , combatsLost : Int
    , spellSelectors : Activity.Record (Maybe Spell)
    }


createProd : Random.Seed -> Game
createProd seed =
    let
        xp : Skill.Record Xp
        xp =
            { chores = Xp.int 0
            , hexes = Xp.int 0
            , adventuring = Xp.int 0
            }
    in
    { seed = seed
    , xp = xp
    , mxp = Activity.createRecord (Xp.int 0)
    , choresMxp = Xp.int 0
    , activitySkilling = Nothing
    , activityAdventuring = Nothing
    , monster = Nothing
    , coin = Coin.int 0
    , resources = Resource.emptyResourceRecord
    , shopItems = ShopItems.create
    , combatsWon = 0
    , combatsLost = 0
    , spellSelectors = Activity.createRecord Nothing
    }


createDev : Random.Seed -> Game
createDev seed =
    let
        xp : Skill.Record Xp
        xp =
            { chores = Xp.int 8000000
            , hexes = Xp.int 8000000
            , adventuring = Xp.int 0
            }
    in
    { seed = seed
    , xp = xp
    , mxp = Activity.createRecord (Xp.int 0)
    , choresMxp = Xp.int 0
    , activitySkilling = Nothing
    , activityAdventuring = Nothing
    , monster = Nothing
    , coin = Coin.int 100000
    , resources = Resource.emptyResourceRecord
    , shopItems = ShopItems.create
    , combatsWon = 0
    , combatsLost = 0
    , spellSelectors = Activity.createRecord Nothing
    }


selectSpell : { activity : Activity, maybeSpell : Maybe Spell } -> Game -> Game
selectSpell { activity, maybeSpell } game =
    { game | spellSelectors = Activity.updateByKind activity (\_ -> maybeSpell) game.spellSelectors }


type ActivityListItem
    = LockedActivity ( Skill.Kind, Int )
    | ActivityListItem Activity


getActivityListItems : Skill.Kind -> Game -> List ActivityListItem
getActivityListItems skill game =
    let
        xp : Xp
        xp =
            Skill.getByKind skill game.xp

        convertToListItem : Activity -> ActivityListItem
        convertToListItem kind =
            case (Activity.getStats kind).unlockRequirements of
                Just ( unlockSkill, unlockLevel ) ->
                    let
                        currentLevel : Int
                        currentLevel =
                            Skill.getByKind unlockSkill game.xp
                                |> Xp.level Xp.defaultSchedule
                    in
                    if currentLevel >= unlockLevel then
                        ActivityListItem kind

                    else
                        LockedActivity ( unlockSkill, unlockLevel )

                Nothing ->
                    ActivityListItem kind

        reducer : Activity -> { items : List ActivityListItem, lockedItem : Bool } -> { items : List ActivityListItem, lockedItem : Bool }
        reducer kind accum =
            if accum.lockedItem then
                -- If lockedItem flag is true we already added a locked item to list and should not add any more items
                accum

            else
                let
                    listItem : ActivityListItem
                    listItem =
                        convertToListItem kind

                    newItems : List ActivityListItem
                    newItems =
                        List.concat [ accum.items, [ listItem ] ]

                    newItemIsLocked : Bool
                    newItemIsLocked =
                        case listItem of
                            ActivityListItem _ ->
                                False

                            LockedActivity _ ->
                                True
                in
                { items = newItems, lockedItem = newItemIsLocked }

        result =
            List.foldl reducer { items = [], lockedItem = False } (Activity.getActivities skill)
    in
    result.items



-- Chores


type alias ActivityStatus =
    Maybe Timer


toggleActivity : Activity -> Game -> Game
toggleActivity kind game =
    let
        stats : Activity.Stats
        stats =
            Activity.getStats kind

        canToggle : Bool
        canToggle =
            case stats.unlockRequirements of
                Just ( unlockSkill, unlockLevel ) ->
                    let
                        currentLevel : Int
                        currentLevel =
                            Skill.getByKind unlockSkill game.xp
                                |> Xp.level Xp.defaultSchedule
                    in
                    currentLevel >= unlockLevel

                Nothing ->
                    True
    in
    if canToggle then
        game

    else
        let
            newActivity : Maybe ( Activity, Timer )
            newActivity =
                case game.activitySkilling of
                    Just ( k, _ ) ->
                        if kind == k then
                            Nothing

                        else
                            Just ( kind, Timer.create )

                    Nothing ->
                        Just ( kind, Timer.create )
        in
        setActivitySkilling newActivity game


activityIsActive : Activity -> Game -> Bool
activityIsActive kind game =
    case game.activitySkilling of
        Just ( k, _ ) ->
            kind == k

        Nothing ->
            False


setActivitySkilling : Maybe ( Activity, Timer ) -> Game -> Game
setActivitySkilling activity g =
    { g | activitySkilling = activity }


setActivityAdventuring : Maybe ( Activity, Timer ) -> Game -> Game
setActivityAdventuring activity g =
    { g | activityAdventuring = activity }


applyIntervalMods : List IntervalMod -> Duration -> Duration
applyIntervalMods mods duration =
    let
        multiplier =
            (mods
                |> List.map .percentChange
                |> List.map Percent.toFloat
                |> List.sum
            )
                + 1
    in
    Quantity.divideBy multiplier duration


getModdedDuration : Game -> Activity -> Duration
getModdedDuration game kind =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        stats =
            Activity.getStats kind

        mods =
            getAllIntervalMods game
                |> List.filter
                    (\mod ->
                        mod.kind == kind
                    )
    in
    stats.duration
        |> applyIntervalMods mods


combatReward : List Effect.TaggedEffect
combatReward =
    [ Effect.gainCoin (Coin.int 25) ]


tick : Duration -> Game -> ( Game, List Toast )
tick delta game =
    let
        ( newActivitySkilling, effectsSkilling ) =
            case game.activitySkilling of
                Nothing ->
                    ( game.activitySkilling, [] )

                Just ( activityKind, timer ) ->
                    let
                        stats : Activity.Stats
                        stats =
                            Activity.getStats activityKind

                        activityDuration : Duration
                        activityDuration =
                            getModdedDuration game activityKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment activityDuration delta

                        newEffects : List (List Effect.TaggedEffect)
                        newEffects =
                            List.repeat completions stats.effects
                    in
                    ( Just ( activityKind, newTimer )
                    , newEffects
                    )

        ( newActivityAdventuring, effectsAdventuring ) =
            case game.activityAdventuring of
                Nothing ->
                    ( game.activityAdventuring, [] )

                Just ( activityKind, timer ) ->
                    let
                        stats : Activity.Stats
                        stats =
                            Activity.getStats activityKind

                        activityDuration : Duration
                        activityDuration =
                            getModdedDuration game activityKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment activityDuration delta

                        newEffects : List (List Effect.TaggedEffect)
                        newEffects =
                            List.repeat completions stats.effects
                    in
                    ( Just ( activityKind, newTimer )
                    , newEffects
                    )

        gameGenerator : Generator ( Game, List Toast )
        gameGenerator =
            game
                |> setActivitySkilling newActivitySkilling
                |> setActivityAdventuring newActivityAdventuring
                |> (\g -> List.foldl applyEvent (Random.constant ( g, [] )) (effectsSkilling ++ effectsAdventuring))

        ( ( newGame, notifications ), newSeed ) =
            Random.step gameGenerator game.seed
    in
    ( { newGame | seed = newSeed }, notifications )


getPurchaseEffects : Int -> Resource -> List Effect.TaggedEffect
getPurchaseEffects amount resource =
    case (Resource.getStats resource).purchasing of
        Resource.Purchasable price ->
            let
                cost : Coin.Coin
                cost =
                    Quantity.multiplyBy (toFloat amount) price
                        |> Quantity.multiplyBy -1
            in
            [ Effect.gainCoin cost, Effect.gainResource amount resource ]

        Resource.NotPurchasable ->
            []


attemptPurchaseResource : Int -> Resource -> Game -> Result EffectErr ApplyEffectsValue
attemptPurchaseResource amount resource game =
    let
        effects : List Effect.TaggedEffect
        effects =
            getPurchaseEffects amount resource

        gen : ApplyEffectsResultGenerator
        gen =
            applyEffects effects game

        ( result, newSeed ) =
            Random.step gen game.seed
    in
    Result.map
        (\applyEffectsResult ->
            { applyEffectsResult
                | game = setSeed newSeed applyEffectsResult.game
            }
        )
        result


setSeed : Random.Seed -> Game -> Game
setSeed seed game =
    { game | seed = seed }


priceToPurchaseResource : Int -> ( Resource, Coin ) -> Game -> Coin
priceToPurchaseResource amount ( resource, price ) game =
    -- TODO: incorporate mods that might alter price
    Quantity.multiplyBy (toFloat amount) price


applyEvent : List Effect.TaggedEffect -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
applyEvent effects =
    -- TODO: revisit this function's name. Why we need this and applyEffects?
    Random.andThen
        (\( game, toasts ) ->
            applyEffects effects game
                |> Random.andThen
                    (\res ->
                        case res of
                            Err err ->
                                let
                                    toast : Toast
                                    toast =
                                        getToastForErr err
                                in
                                Random.constant ( game, toast :: toasts )

                            Ok val ->
                                Random.constant ( val.game, toasts ++ val.toasts )
                    )
        )


getToastForErr : EffectErr -> Toast
getToastForErr err =
    case err of
        EffectErr.NegativeAmount ->
            NegativeAmountErr


type alias ApplyEffectsValue =
    { game : Game, toasts : List Toast }


type alias ApplyEffectsResultGenerator =
    Generator (Result EffectErr ApplyEffectsValue)


applyEffects : List Effect.TaggedEffect -> Game -> ApplyEffectsResultGenerator
applyEffects effects game =
    case effects of
        [] ->
            Random.constant (Ok { game = game, toasts = [] })

        effect :: rest ->
            let
                ( moddedEffect, additionalEffectsFromMod ) =
                    Mod.applyModsToEffect (getAllMods game) effect
            in
            applyEffect moddedEffect game
                |> Random.andThen
                    (\applyEffectResult ->
                        case applyEffectResult of
                            Err e ->
                                Random.constant (Err e)

                            Ok applyEffectVal ->
                                let
                                    g : Game
                                    g =
                                        applyEffectVal.game

                                    toasts : List Toast
                                    toasts =
                                        applyEffectVal.toasts

                                    additionalEffects : List Effect.TaggedEffect
                                    additionalEffects =
                                        applyEffectVal.additionalEffects
                                in
                                applyEffects (rest ++ additionalEffectsFromMod ++ additionalEffects) g
                                    |> Random.andThen
                                        (\res2 ->
                                            case res2 of
                                                Err e2 ->
                                                    Random.constant (Err e2)

                                                Ok val ->
                                                    Random.constant (Ok { game = val.game, toasts = val.toasts ++ toasts })
                                        )
                    )


mapGeneratorResult : (a -> Generator (Result e a)) -> Generator (Result e a) -> Generator (Result e a)
mapGeneratorResult fn =
    Random.andThen
        (\res ->
            case res of
                Ok a ->
                    fn a

                Err err ->
                    Random.constant (Err err)
        )



-- effectReducer : Effect -> GameUpdateGen -> GameUpdateGen
-- effectReducer effect =
--     let
--         fn : ( Game, List Toast ) -> GameUpdateGen
--         fn ( game, notifications ) =
--             applyEffect effect game
--                 |> Random.map
--                     (\res ->
--                         res
--                             |> Result.map (\( newGame, newToasts, newEffects ) -> ( newGame, notifications ++ newToasts, newEffects ))
--                     )
--     in
--     mapGeneratorResult fn


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


calculateActivityMxp : Activity -> Game -> Xp
calculateActivityMxp kind game =
    let
        stats =
            Activity.getStats kind

        mxp : Xp
        mxp =
            game.mxp
                |> Activity.getByKind kind

        currentMasteryLevel : Int
        currentMasteryLevel =
            Xp.level Xp.defaultSchedule mxp
    in
    toFloat currentMasteryLevel
        * Duration.inSeconds stats.duration
        |> floor
        |> Xp.int


type alias ApplyEffectValue =
    -- When applying an effect a toast is generated to inform the player what happened
    { game : Game, toasts : List Toast, additionalEffects : List Effect.TaggedEffect }


type alias ApplyEffectResultGenerator =
    Generator (Result EffectErr ApplyEffectValue)


applyEffect : Effect.TaggedEffect -> Game -> ApplyEffectResultGenerator
applyEffect effect game =
    case Effect.getEffect effect of
        Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
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
                        Random.constant (Ok (ApplyEffectValue game [] chosenEffects))
                    )

        Effect.ResolveCombat { combat, successEffects, failureEffects } ->
            Combat.resolve combat
                |> Random.andThen
                    (\{ playerWon } ->
                        let
                            ( chosenEffects, toasts ) =
                                if playerWon then
                                    ( successEffects, [] )

                                else
                                    ( failureEffects, [ LostCombat ] )
                        in
                        Random.constant (Ok (ApplyEffectValue game toasts chosenEffects))
                    )

        Effect.GainCoin { base, multiplier } ->
            let
                product : Coin
                product =
                    Quantity.multiplyBy multiplier base
            in
            addCoin product game
                |> Random.constant

        Effect.GainResource params ->
            intGenerator { base = params.base, doublingChance = params.doublingChance }
                |> Random.map (\amount -> addResource params.resource amount game)

        Effect.GainXp { base, multiplier, skill } ->
            { game = addXp skill (Quantity.multiplyBy multiplier base) game
            , toasts = []
            , additionalEffects = []
            }
                |> Random.constant
                |> Random.map Ok

        Effect.GainMxp params ->
            let
                base : Xp
                base =
                    calculateActivityMxp params.activity game

                mxp : Xp
                mxp =
                    Quantity.multiplyBy params.multiplier base

                masteryPoolXp : Xp
                masteryPoolXp =
                    Quantity.multiplyBy params.multiplier base
                        |> Quantity.multiplyBy 0.5
            in
            game
                |> addMxp params.activity mxp
                |> addMasteryPoolXp masteryPoolXp
                |> (\newGame -> Random.constant (ApplyEffectValue newGame [] []))
                |> Random.map Ok


addXp : Skill.Kind -> Xp -> Game -> Game
addXp skill amount game =
    case skill of
        Skill.Chores ->
            { game | xp = Skill.updateByKind Skill.Chores (Quantity.plus amount) game.xp }

        Skill.Hexes ->
            { game | xp = Skill.updateByKind Skill.Hexes (Quantity.plus amount) game.xp }

        Skill.Adventuring ->
            { game | xp = Skill.updateByKind Skill.Adventuring (Quantity.plus amount) game.xp }


addMxp : Activity -> Xp -> Game -> Game
addMxp kind amount game =
    let
        fn mxp =
            Quantity.plus mxp amount
    in
    { game
        | mxp =
            game.mxp
                |> Activity.updateByKind kind fn
    }


addMasteryPoolXp : Xp -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = Quantity.plus game.choresMxp amount }


addResource : Resource -> Int -> Game -> Result EffectErr ApplyEffectValue
addResource resource amount game =
    let
        newResources : Result EffectErr (Resource.Record Int)
        newResources =
            Resource.add resource amount game.resources
    in
    newResources
        |> Result.map
            (\val ->
                { game = { game | resources = val }
                , toasts = [ GainedResource amount resource ]
                , additionalEffects = []
                }
            )


addCoin : Coin -> Game -> Result EffectErr ApplyEffectValue
addCoin amount game =
    let
        newCoin : Coin
        newCoin =
            Quantity.plus game.coin amount

        isNegative : Bool
        isNegative =
            Quantity.lessThan (Coin.int 0) newCoin
    in
    if isNegative then
        Err EffectErr.NegativeAmount

    else
        Ok
            { game = { game | coin = newCoin }
            , toasts = [ GainedCoin amount ]
            , additionalEffects = []
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
    { originalXp : Xp
    , currentXp : Xp
    , skill : Skill.Kind
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Coin
    , resourcesDiff : Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGains =
            if originalGame.xp.chores == currentGame.xp.chores then
                []

            else
                [ { skill = Skill.Chores, originalXp = originalGame.xp.chores, currentXp = currentGame.xp.chores } ]

        resourcesDiff =
            Resource.getDiff { original = originalGame.resources, current = currentGame.resources }

        combatsWonDiff =
            currentGame.combatsWon - originalGame.combatsWon

        combatsLostDiff =
            currentGame.combatsLost - originalGame.combatsLost

        coinGains : Maybe Coin
        coinGains =
            if Coin.toInt currentGame.coin > Coin.toInt originalGame.coin then
                Just <| Quantity.difference currentGame.coin originalGame.coin

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


getMasteryIntervalMods : Game -> List IntervalMod
getMasteryIntervalMods game =
    let
        allActivities : List Activity
        allActivities =
            Activity.allActivities

        masteryRewards : List Activity.MasteryReward
        masteryRewards =
            allActivities
                |> List.concatMap
                    (\activity ->
                        let
                            stats : Activity.Stats
                            stats =
                                Activity.getStats activity

                            mxp : Xp
                            mxp =
                                Activity.getByKind activity game.mxp

                            masteryLevel : Int
                            masteryLevel =
                                Xp.level Xp.defaultSchedule mxp
                        in
                        case stats.mastery of
                            Just mastery ->
                                mastery
                                    |> List.filterMap
                                        (\( level, reward ) ->
                                            if masteryLevel >= level then
                                                Just reward

                                            else
                                                Nothing
                                        )

                            Nothing ->
                                []
                    )

        mods : List IntervalMod
        mods =
            masteryRewards
                |> List.filterMap
                    (\reward ->
                        case reward of
                            Activity.IntervalMod mod ->
                                Just mod

                            _ ->
                                Nothing
                    )
    in
    mods


getMasteryRewards : Game -> Activity -> List Activity.MasteryReward
getMasteryRewards game activity =
    let
        stats : Activity.Stats
        stats =
            Activity.getStats activity

        mxp : Xp
        mxp =
            Activity.getByKind activity game.mxp

        masteryLevel : Int
        masteryLevel =
            Xp.level Xp.defaultSchedule mxp
    in
    case stats.mastery of
        Just mastery ->
            mastery
                |> List.filterMap
                    (\( level, reward ) ->
                        if masteryLevel >= level then
                            Just reward

                        else
                            Nothing
                    )

        Nothing ->
            []


getActivityMods : Game -> List Mod
getActivityMods game =
    let
        getGameMod : Activity.MasteryReward -> Maybe Mod
        getGameMod reward =
            case reward of
                Activity.GameMod mod ->
                    Just mod

                _ ->
                    Nothing
    in
    Activity.allActivities
        |> List.concatMap (getMasteryRewards game)
        |> List.filterMap getGameMod


getSpellMods : Game -> List Mod
getSpellMods game =
    -- Get all activities, map to the selected spell (Just spell or Nothing), then filterMap to the mods from spell
    let
        allActivities : List Activity
        allActivities =
            Activity.allActivities
    in
    allActivities
        |> List.filterMap
            (\activity ->
                case Activity.getByKind activity game.spellSelectors of
                    Just spell ->
                        Just (addActivityTagToMods activity (Spell.getStats spell).mods)

                    Nothing ->
                        Nothing
            )
        |> List.concat


addActivityTagToMods : Activity -> List Mod -> List Mod
addActivityTagToMods activity =
    List.map (Mod.withTags [ Effect.ActivityTag activity ])


getAllMods : Game -> List Mod
getAllMods game =
    []
        ++ getSpellMods game
        ++ getActivityMods game
        ++ getShopItemMods game



-- |> List.map Mod.includeVariableEffects
-- Originally thought we might want only some mods to have this, now I think all should?
-- Interval Mods


getAllIntervalMods : Game -> List IntervalMod
getAllIntervalMods game =
    let
        shopItemIntervalMods =
            getShopItemIntervalMods game

        choreUnlockIntervalMods =
            getMasteryIntervalMods game
    in
    shopItemIntervalMods ++ choreUnlockIntervalMods



--


isSpellLearned : Game -> Spell -> Bool
isSpellLearned game spell =
    -- NOTE this is not the same as the Activity corresponding to the spell being unlocked.
    -- As of current writing all spells require Mastery level 25 to let the spell be "learned" enough to use
    -- which is what this function indicates
    let
        maybeActivity : Maybe Activity
        maybeActivity =
            Activity.getBySpell spell
    in
    case maybeActivity of
        Nothing ->
            False

        Just activity ->
            let
                masteryRewards : List Activity.MasteryReward
                masteryRewards =
                    getMasteryRewards game activity
            in
            List.member Activity.SpellAvailable masteryRewards


getMaxPurchase : Coin -> Game -> Int
getMaxPurchase price game =
    let
        playerCoin : Coin
        playerCoin =
            game.coin
    in
    floor (Quantity.ratio playerCoin price)
