Where should things like bonus xp modifier go? Locally in the code that generated the xp or higher up? Given that bonuses can occur from global realities like other skills giving bonus xp, events, etc. should happen at top level. 

Game Object:

{ gold : Int
, items : List Item
, woodcuttingXp : Int
, activeSkill : Skill
-- etc
}

Not included: ui settings like whether a modal is open or not. configuration like quick equip menu. History of game object for displaying Time Passes modal. 

The function that makes the game run is updateGameObject. It takes a (time, gameObject) and later (time) and outputs gameObject. The initial (time, gameObject)

What is issued at bottom level is base rewards.

base reward: SkillXp Skill Amount, MasteryXp Mastery Amount, Item ItemId Amount, etc.

should we also include source, etc?

modified reward: { baseReward : BaseReward, mods : List RewardMod }
these mods would be things like global bonuses.
RewardMod types would look like {mod : Mod, source : RewardSource}
Mod would be Percent | Flat | ChanceDoubled

Need a function which takes a base reward, the model, and outputs the mods. Use this to display the reward to user and to actually calculate it for ticks.


Base reward : (5 gold)

Final reward : (50 gold * 1.02) or (50 gold + 5) or (50 gold + )


=======

In Melvor the percent/flat rewards are simply factored in and displayed instead of the base. But doubling/preserve resources are shown separately (or not at all). Should preserve reasources.


Tick : an event that happens when something ticks-- every 5 sec when smelting ore for example.
When you tick you subtract resources (maybe) and gain others, including XP.

# Game loop -- runs every animationFrame, or many times after a long break.

* Check for woodcutting events. Modifies the model accordingly.
* Check for shipbuilding events. Modifies the model accordingly.
* etc. 
* Also returns a summary object of what changed. This should be optional,
