module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import Html.Attributes exposing (download)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
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
import Svg.Attributes exposing (preserveAlpha)
import Tuple
import Types exposing (..)



-- Public


createProd : Random.Seed -> Game
createProd seed =
    let
        xp : SkillRecord Xp
        xp =
            { chores = Xp.int 0
            , hexes = Xp.int 0
            , weathermancing = Xp.int 0
            }
    in
    { seed = seed
    , xp = xp
    , mxp = activityRecord (Xp.int 0)
    , locations = locationRecord Location.createState
    , quests = questRecord Quest.Incomplete
    , choresMxp = Xp.int 0
    , activitySkilling = Nothing
    , activityAdventuring = Nothing
    , monster = Nothing
    , coin = Coin.int 0
    , resources = resourceRecord 0
    , ownedShopUpgrades = shopUpgradeRecord False
    , combatsWon = 0
    , combatsLost = 0
    , spellSelectors = activityRecord Nothing
    , scrolls = spellRecord 0
    }


createDev : Random.Seed -> Game
createDev seed =
    let
        xp : SkillRecord Xp
        xp =
            { chores = Xp.int 9000000
            , hexes = Xp.int 9000000
            , weathermancing = Xp.int 9000000
            }
    in
    { seed = seed
    , xp = xp
    , mxp = activityRecord (Xp.int 0)
    , locations = locationRecord Location.createState
    , quests = questRecord Quest.Incomplete
    , choresMxp = Xp.int 0
    , activitySkilling = Nothing
    , activityAdventuring = Nothing
    , monster = Nothing
    , coin = Coin.int 100000
    , resources = resourceRecord 0
    , ownedShopUpgrades = shopUpgradeRecord False
    , combatsWon = 0
    , combatsLost = 0
    , spellSelectors = activityRecord Nothing
    , scrolls = spellRecord 100
    }


selectSpell : { activity : Activity, maybeSpell : Maybe Spell } -> Game -> Game
selectSpell { activity, maybeSpell } game =
    { game | spellSelectors = Activity.updateByKindActivity activity (\_ -> maybeSpell) game.spellSelectors }


type ActivityListItem
    = LockedActivity ( Skill, Int )
    | ActivityListItem Activity


getActivityListItems : Skill -> Game -> List ActivityListItem
getActivityListItems skill game =
    let
        xp : Xp
        xp =
            getBySkill skill game.xp

        convertToListItem : Activity -> ActivityListItem
        convertToListItem kind =
            case (Activity.getStats kind).unlockRequirements of
                Just ( unlockSkill, unlockLevel ) ->
                    let
                        currentLevel : Int
                        currentLevel =
                            getBySkill unlockSkill game.xp
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
            List.foldl reducer { items = [], lockedItem = False } (Activity.getBySkill skill)
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
                            getBySkill unlockSkill game.xp
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


updateLocations : (LocationRecord Location.State -> LocationRecord Location.State) -> Game -> Game
updateLocations fn game =
    { game | locations = fn game.locations }


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


combatReward : List Effect
combatReward =
    [ Effect.gainCoin (Coin.int 25) ]


type alias Event =
    { effects : List Effect, count : Int }


tick : Duration -> Game -> ( Game, List Toast )
tick delta game =
    let
        ( newActivitySkilling, eventSkilling ) =
            case game.activitySkilling of
                Nothing ->
                    ( game.activitySkilling, Nothing )

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

                        maybeEvent : Maybe Event
                        maybeEvent =
                            if completions >= 1 then
                                Just { effects = stats.effects, count = completions }

                            else
                                Nothing
                    in
                    ( Just ( activityKind, newTimer )
                    , maybeEvent
                    )

        ( newActivityAdventuring, eventAdventuring ) =
            case game.activityAdventuring of
                Nothing ->
                    ( game.activityAdventuring, Nothing )

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

                        maybeEvent : Maybe Event
                        maybeEvent =
                            if completions >= 1 then
                                Just { effects = stats.effects, count = completions }

                            else
                                Nothing
                    in
                    ( Just ( activityKind, newTimer )
                    , maybeEvent
                    )

        mods : List Mod
        mods =
            getAllMods game

        gameGenerator : Generator ( Game, List Toast )
        gameGenerator =
            game
                |> setActivitySkilling newActivitySkilling
                |> setActivityAdventuring newActivityAdventuring
                |> (\g -> List.foldl (applyEvent mods) (Random.constant ( g, [] )) (List.filterMap identity [ eventSkilling, eventAdventuring ]))

        ( ( newGame, notifications ), newSeed ) =
            Random.step gameGenerator game.seed
    in
    ( { newGame | seed = newSeed }, notifications )


getPurchaseEffects : Int -> Resource -> List Effect
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
        effects : List Effect
        effects =
            getPurchaseEffects amount resource

        mods : List Mod
        mods =
            getAllMods game

        gen : ApplyEffectsResultGenerator
        gen =
            applyEffects mods effects 1 game

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


setQuestToComplete : Quest -> Game -> Game
setQuestToComplete quest game =
    { game | quests = setByQuest quest Quest.Complete game.quests }


attemptCompleteQuest : Quest -> Game -> Result EffectErr ApplyEffectsValue
attemptCompleteQuest quest game =
    let
        questStats : Quest.Stats
        questStats =
            Quest.getStats quest

        questState : Quest.State
        questState =
            getByQuest quest game.quests

        effectsToComplete : List Effect
        effectsToComplete =
            Quest.getCompletionEffects quest

        effects : List Effect
        effects =
            List.concat
                [ effectsToComplete
                , questStats.reward
                ]

        mods : List Mod
        mods =
            getAllMods game

        gen : ApplyEffectsResultGenerator
        gen =
            applyEffects mods effects 1 game

        ( result, newSeed ) =
            Random.step gen game.seed
    in
    if questState == Quest.Complete then
        Err EffectErr.QuestAlreadyComplete

    else
        Result.map
            (\applyEffectsResult ->
                { applyEffectsResult
                    | game =
                        applyEffectsResult.game
                            |> setSeed newSeed
                            |> setQuestToComplete quest
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


applyEvent : List Mod -> Event -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
applyEvent mods { effects, count } =
    -- TODO: revisit this function's name. Why we need this and applyEffects?
    Random.andThen
        (\( game, toasts ) ->
            applyEffects mods effects count game
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

        EffectErr.QuestAlreadyComplete ->
            QuestAlreadyCompleteErr


type alias ApplyEffectsValue =
    { game : Game, toasts : List Toast }


type alias ApplyEffectsResultGenerator =
    Generator (Result EffectErr ApplyEffectsValue)


applyEffects : List Mod -> List Effect -> Int -> Game -> ApplyEffectsResultGenerator
applyEffects mods effects count game =
    case effects of
        [] ->
            Random.constant (Ok { game = game, toasts = [] })

        effect :: rest ->
            let
                ( moddedEffect, additionalEffectsFromMod ) =
                    Mod.applyModsToEffect mods effect
            in
            applyEffect moddedEffect count game
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

                                    additionalEffects : List Effect
                                    additionalEffects =
                                        applyEffectVal.additionalEffects
                                in
                                applyEffects mods (rest ++ additionalEffectsFromMod ++ additionalEffects) count g
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


probabilityGenerator : Percent -> Generator Bool
probabilityGenerator probability =
    Random.float 0 1
        |> Random.map
            (\num ->
                num < Percent.toFloat probability
            )


calculateActivityMxp : Activity -> Game -> Xp
calculateActivityMxp kind game =
    let
        stats =
            Activity.getStats kind

        mxp : Xp
        mxp =
            game.mxp
                |> getByActivity kind

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
    { game : Game, toasts : List Toast, additionalEffects : List Effect, additionalMods : List Mod }


type alias ApplyEffectResultGenerator =
    Generator (Result EffectErr ApplyEffectValue)


setScrolls : Spell -> Int -> Game -> Game
setScrolls spell amount game =
    { game | scrolls = setBySpell spell amount game.scrolls }


applyEffect : Effect -> Int -> Game -> ApplyEffectResultGenerator
applyEffect effect count game =
    case Effect.getEffect effect of
        Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
            probabilityGenerator successProbability
                |> Random.andThen
                    (\succeeded ->
                        let
                            chosenEffects =
                                if succeeded then
                                    successEffects

                                else
                                    failureEffects
                        in
                        Random.constant (Ok (ApplyEffectValue game [] chosenEffects []))
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
                        Random.constant (Ok (ApplyEffectValue game toasts chosenEffects []))
                    )

        Effect.GainCoin { base, percentIncrease } ->
            let
                product : Coin
                product =
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            addCoin product game
                |> Random.constant

        -- adjustScroll : Spell -> Int -> Game -> Result EffectErr ApplyEffectValue
        -- adjustScroll spell amount game =
        --     let
        --         newScrolls : Result EffectErr (SpellRecord Int)
        --         newScrolls =
        --             addScroll spell amount game.scrolls
        --     in
        --     newScrolls
        --         |> Result.map
        --             (\val ->
        --                 { game = { game | scrolls = val }
        --                 , toasts = [ GainedScroll amount spell ]
        --                 , additionalEffects = []
        --                 }
        --             )
        Effect.GainScroll { base, spell, doublingChance } ->
            probabilityGenerator doublingChance
                |> Random.map
                    (\doubled ->
                        let
                            amount : Int
                            amount =
                                if doubled then
                                    2 * base * count

                                else
                                    base * count
                        in
                        case addScroll spell amount game.scrolls of
                            Err e ->
                                Random.constant { game = game, toasts = [], addtionalEffects = [], additionalMods = [] }

                            Ok newScrolls ->
                                Random.constant { game = setScrolls spell newScrolls game, toasts = [ GainedScroll (base * count) spell ], additionalEffects = [], additionalMods = [] }
                    )

        Effect.SpendScroll { base, spell, preservationChance } ->
            probabilityGenerator preservationChance
                |> Random.map
                    (\preserved ->
                        if preserved then
                            Random.constant { game = game, toasts = [], additionalEffects = [], additionalMods = (Spell.getStats spell).mods }

                        else
                            case addScroll spell (-1 * base * count) game.scrolls of
                                Err e ->
                                    Random.constant { game = game, toasts = [], addtionalEffects = [], additionalMods = [] }

                                -- We don't propagate the error because this is considered optional
                                Ok newScrolls ->
                                    Random.constant { game = setScrolls spell newScrolls game, toasts = [], additionalEffects = [], additionalMods = (Spell.getStats spell).mods }
                    )

        Effect.GainResource { base, resource, doublingChance } ->
            probabilityGenerator doublingChance
                |> Random.map
                    (\doubled ->
                        let
                            result : Int
                            result =
                                if doubled then
                                    2 * base * count

                                else
                                    base * count
                        in
                        adjustResource resource result game
                    )

        Effect.SpendResource { base, resource, preservationChance } ->
            probabilityGenerator preservationChance
                |> Random.map
                    (\preserved ->
                        if preserved then
                            adjustResource resource 0 game

                        else
                            adjustResource resource (-1 * base * count) game
                    )

        Effect.GainXp { base, percentIncrease, skill } ->
            let
                xp : Xp
                xp =
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            { game = addXp skill xp game
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
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            game
                |> addMxp params.activity mxp
                |> (\newGame -> Random.constant (ApplyEffectValue newGame [] []))
                |> Random.map Ok

        Effect.Explore { location } ->
            let
                locationState : Location.State
                locationState =
                    getByLocation location game.locations
            in
            Location.explorationGenerator location locationState count
                |> Random.map
                    (\{ state, effects, toasts } ->
                        Ok
                            { game =
                                game
                                    |> updateLocations (setByLocation location state)
                            , toasts = toasts
                            , additionalEffects = effects
                            }
                    )


addXp : Skill -> Xp -> Game -> Game
addXp skill amount game =
    case skill of
        Chores ->
            { game | xp = Skill.updateBySkill Chores (Quantity.plus amount) game.xp }

        Hexes ->
            { game | xp = Skill.updateBySkill Hexes (Quantity.plus amount) game.xp }

        Weathermancing ->
            { game | xp = Skill.updateBySkill Weathermancing (Quantity.plus amount) game.xp }


addMxp : Activity -> Xp -> Game -> Game
addMxp kind amount game =
    let
        fn mxp =
            Quantity.plus mxp amount
    in
    { game
        | mxp =
            game.mxp
                |> Activity.updateByKindActivity kind fn
    }


addMasteryPoolXp : Xp -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = Quantity.plus game.choresMxp amount }


addScroll : Spell -> Int -> SpellRecord Int -> Result EffectErr (SpellRecord Int)
addScroll spell amount scrolls =
    let
        oldAmount : Int
        oldAmount =
            getBySpell spell scrolls

        newAmount : Int
        newAmount =
            oldAmount + amount
    in
    if newAmount >= 0 then
        Ok (setBySpell spell newAmount scrolls)

    else
        Err EffectErr.NegativeAmount



-- adjustScroll : Spell -> Int -> Game -> Result EffectErr ApplyEffectValue
-- adjustScroll spell amount game =
--     let
--         newScrolls : Result EffectErr (SpellRecord Int)
--         newScrolls =
--             addScroll spell amount game.scrolls
--     in
--     newScrolls
--         |> Result.map
--             (\val ->
--                 { game = { game | scrolls = val }
--                 , toasts = [ GainedScroll amount spell ]
--                 , additionalEffects = []
--                 }
--             )


adjustResource : Resource -> Int -> Game -> Result EffectErr ApplyEffectValue
adjustResource resource amount game =
    let
        newResources : Result EffectErr (ResourceRecord Int)
        newResources =
            Resource.add resource amount game.resources
    in
    newResources
        |> Result.map
            (\val ->
                { game = { game | resources = val }
                , toasts = [ GainedResource amount resource ]
                , additionalEffects = []
                , additionalMods = []
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
            , additionalMods = []
            }


diff : List a -> List a -> List a
diff list1 list2 =
    List.concat
        [ List.filter (\item -> not (List.member item list2)) list1
        , List.filter (\item -> not (List.member item list1)) list2
        ]


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGainOfSkill : Skill -> Maybe TimePassesXpGain
        xpGainOfSkill skill =
            let
                originalXp : Xp
                originalXp =
                    getBySkill skill originalGame.xp

                currentXp : Xp
                currentXp =
                    getBySkill skill currentGame.xp
            in
            if originalXp == currentXp then
                Nothing

            else
                Just { skill = skill, originalXp = originalXp, currentXp = currentXp }

        xpGains : List TimePassesXpGain
        xpGains =
            allSkills
                |> List.filterMap xpGainOfSkill

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

        discoveredMonsters : Location -> List Monster
        discoveredMonsters location =
            let
                originalMonsters : List Monster
                originalMonsters =
                    Location.foundMonsters location (getByLocation location originalGame.locations)

                currentMonsters : List Monster
                currentMonsters =
                    Location.foundMonsters location (getByLocation location currentGame.locations)
            in
            diff originalMonsters currentMonsters

        discoveredQuests : Location -> List Quest
        discoveredQuests location =
            let
                originalQuests : List Quest
                originalQuests =
                    Location.foundQuests location (getByLocation location originalGame.locations)

                currentQuests : List Quest
                currentQuests =
                    Location.foundQuests location (getByLocation location currentGame.locations)
            in
            diff originalQuests currentQuests

        discoveredResources : Location -> List Resource
        discoveredResources location =
            let
                originalResources : List Resource
                originalResources =
                    Location.foundResources location (getByLocation location originalGame.locations)

                currentResources : List Resource
                currentResources =
                    Location.foundResources location (getByLocation location currentGame.locations)
            in
            diff originalResources currentResources

        discoveriesAtLocation : Location -> List TimePassesDiscovery
        discoveriesAtLocation location =
            List.concat
                [ List.map MonsterDiscovery (discoveredMonsters location)
                , List.map QuestDiscovery (discoveredQuests location)
                , List.map ResourceDiscovery (discoveredResources location)
                ]

        discoveries : List TimePassesDiscovery
        discoveries =
            List.concatMap discoveriesAtLocation allLocations
    in
    if hasNewData then
        Just
            { xpGains = xpGains
            , discoveries = discoveries
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
    game.ownedShopUpgrades
        |> ShopUpgrade.toOwnedItems
        |> List.map (\shopItem -> (ShopUpgrade.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopUpgrade.ShopItemMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getShopItemIntervalMods : Game -> List IntervalMod
getShopItemIntervalMods game =
    game.ownedShopUpgrades
        |> ShopUpgrade.toOwnedItems
        |> List.map (\shopItem -> (ShopUpgrade.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopUpgrade.ShopItemIntervalMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getMasteryIntervalMods : Game -> List IntervalMod
getMasteryIntervalMods game =
    let
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
                                getByActivity activity game.mxp

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
            getByActivity activity game.mxp

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
    allActivities
        |> List.concatMap (getMasteryRewards game)
        |> List.filterMap getGameMod


getSelectedSpellMods : Game -> List Mod
getSelectedSpellMods game =
    [ game.activityAdventuring, game.activitySkilling ]
        |> List.filterMap (Maybe.map (\( activity, _ ) -> activity))
        |> List.filterMap
            (\activity ->
                getByActivity activity game.spellSelectors
                    |> Maybe.map (\spell -> ( activity, spell ))
            )
        |> List.filter (\( _, spell ) -> getBySpell spell game.scrolls > 0)
        |> List.map
            (\( activity, spell ) ->
                -- Where we attach the spell mods to the activity
                (Spell.getStats spell).mods
                    |> addActivityTagToMods activity
            )
        |> List.concat


addActivityTagToMods : Activity -> List Mod -> List Mod
addActivityTagToMods activity =
    List.map (Mod.withTags [ Effect.ActivityTag activity ])


getAllMods : Game -> List Mod
getAllMods game =
    []
        ++ getSelectedSpellMods game
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


getMaxPurchase : Coin -> Game -> Int
getMaxPurchase price game =
    let
        playerCoin : Coin
        playerCoin =
            game.coin
    in
    floor (Quantity.ratio playerCoin price)


spellSelectorOptions : Game -> Activity -> List Spell
spellSelectorOptions game activity =
    let
        spellIsIncluded : Spell -> Bool
        spellIsIncluded spell =
            List.any
                (\inclusionCriteria ->
                    case inclusionCriteria of
                        Spell.IfActivity includedActivity ->
                            includedActivity == activity

                        Spell.IfSkill includedSkill ->
                            case (Activity.getStats activity).belongsTo of
                                Activity.BelongsToSkill activitySkill ->
                                    includedSkill == activitySkill

                                _ ->
                                    False

                        Spell.IfCombat ->
                            Activity.isCombatActivity activity
                )
                (Spell.getStats spell).inclusions

        atLeastOne : Spell -> Bool
        atLeastOne spell =
            getBySpell spell game.scrolls > 0
    in
    List.filter (\spell -> atLeastOne spell && spellIsIncluded spell) allSpells
