## What is an event?
An event is what the player would recognize and conceptualize as a "single thing happening". We choose the level of abstraction at this subjective point because of requirements. One of the requirements is that we give the player some feedback, both before the Event happens (display it in the UI somewhere so they know what they're getting) and after (in the real time event log). So the schema should ergonomically fit these two big use cases.

Thus, even the simplest Event is really an encapsulation of multiple state changes. E.g.

### Event A: Chop a tree
* Gain wood
* Gain XP
* Gain MXP in certain tree
* Gain 50% MXP to woodcutting pool

### Event B: Smelt ore
* Check if have ore. If not then stop here.
* Roll X% chance of success
* If success, gain ingot
* If success, gain XP
* If success, gain MXP
* Regardless, lose 1 ore

## Requirements
* Can apply the Event to `game`, checking validity and resolving probabilities
* Can compute event summary with final values to display to user (**before** application)
* Can generate a line in the event log to display results to user (**after** application)

## Phases 
It seems the same Event goes through three phases:
* It starts as an unmodded **Event**. Validity and probabilities have not been resolved, nor have relevant mods been calculated. Call this an Event.
	* A player should rarely be exposed to this, they should instead see the next phase.
* It becomes a **ModdedEvent** when paired with the mods derived from a given `game`. It is still the case that validity and probabilities have not been determined.
	* This is what we show the player in the UI so they can see what they're going to get from an action
* After the event is applied to the `game` along with a seed, an **EventLogItem** is created. This has two purposes.
	* Can be applied to the `game` to give or remove items as needed.
	* Can be shown to the player in a real time or historical log of what happened.


# Naive implementation
The naive way would be to have a large union type with a member for each possible event. 
```
type Event =
	ChopTree Xp Mxp Wood

applyEvent : Event -> Game -> Game
applyEvent event game =
	case event of
		ChopTree xp mxp wood ->
			{ game
				| wood = game.wood + wood
				, woodcuttingXp = game.woodcuttingXp + xp
				, woodcuttingMxp = game.woodcuttingMxp + (mxp / 2)
			}
```

How to involve mods in this is where it gets tricky. We really want the tagging system so that we can have e.g. a mod that boosts xp globally, or one that boosts only woodcutting xp, etc. with minimumu complexity and repetition.

It seems like an event should look more like 
```
type alias Event =
	{ title : String
	, effects : List Effect
	, failEffects : Maybe (Float, List Effect)
	, tags : List Tag
	}


chopTree : Event
chopTree =
	{ title = "Chop a tree"
	, effects =
		[ gainWood 1
		, gainWoodcuttingXp 10.0
		, gainWoodcuttingMxp 5.0
		]
	, failEffects = Nothing
	, tags = [ Woodcutting ]
	}

smeltOre : Event
smeltOre =
	{ title = "Smelt Ore"
	, effects =
		[ loseOre 1
		, gainIngot 1
		, gainSmeltingXp 10.0
		, gainSmeltingMxp 5.0
		]
	, failEffect = Just (55.0, [ loseOre 1 ]
	, tags = [ Smelting ]
	}

type EffectType
	= GainResource Resource Int
	| GainXp Skill Float
	| GainWoodcuttingMxp Tree Float

type alias Effect =
	{ type_ : EffectType
	, tags : List Tag
	}

gainWood : Int -> Effect
gainWood amount =
	{ type_ = GainResource Wood amount
	, tags = []
	}

type alias Mod =
	{ tags : List Tag
	, label : String
	, transformer : (EffectType -> [EffectType]
	, source : ModSource
	}

globalXpMod =
	{ tags = []
	, label = "+5% to Global XP"
	, transformer = (\effectType ->
		case effectType of
			GainXp skill amount ->
				GainXp skill (amount * 1.05)
				
			_ ->
				effectType
	, source = AdminCrimes
	}

funnyMod1 =
	{ tags = []
	, label = "Turns all your ingots to mush"
	, transformer (\effectType ->
		case effectType of
			GainResource IronIngot amount ->
				GainResource Mush amount
			_ ->
				effectType
	, source = AdminCrimes
	}

xpJuicerMod =
	{ tags = [Woodcutting]
	, label = "Gain Xp for every woodcutting resource"
	, transformer (\effectType ->
		case effectType of
			GainResource _ amount ->
				
```
