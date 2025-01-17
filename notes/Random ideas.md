## Trials
A trial sequence would be a self-contained set of trials which the player could set themselves as "trying". Once trying a trial sequence, a timer would tick for each trail in the sequence and success would be determined; if the player fails then they are sent back to the start and if they succeed they progress. Similar to how Agility works in Melvor Idle except for some key enhancements:
* Each trial would be personalized to the zone it's found in. E.g. in the jungle biome a trial where you use vine rope swings to get somewhere.
* Each trial would pose a different challenge from the others, not just be a fixed time to complete. For instance, we might have stats like Strength, Dex, Wis, etc. that are rolled against like in an RPG?
* One could assign a single spell to aid you on each step. These spells could aid you by e.g.
    * Increase success chance on this step
    * Increase success chance on *next* step
    * Give you a small reward on completion
    * Cause you to gain more xp
More ideas for trials
* A trial that has a fixed unadjustable % chance to be passed
* The final trial rewards you with a big reward
* Each trial has a mastery reward system
* Each trial has a series of tags, with each tag being associated with mastery. 
## Crafting ala New World
I really like crafting in New World, where you craft an item multiple times seeking the best combination of perks, the numerical value of the perk, and the numerical value of the stats on the item. 

## Enhancements
There's no profession in Melvor for enhancing your gear; you can enhance some gear pieces (give armor more damage reduction) but most pieces, even weapons, you can't. And it would be cool to be it's own tree with mastery and unlocks and so on.

## Rubies (wildcard resource)
In Caverna there is the resource rubies. They are an inefficient but flexible resource to be expended to fill in gaps in planning and liquidity. Should there be a resource or a whole profession that exists to fill the same role?

Proposal: accumlate slowly a resource that you can expend to gain small-medium amounts of other resources in a hurry. If you are a good planner or just care the most about efficiency you won't expend this resource, you'll directly farm all resources you need. And then the rubies can be sold off for money or something.

In this way we can make some upgrades require little dinky amounts of lots of different resources.

Note this might be a bad idea...commoditizing game systems and making them feel like a market with arbitrage is sometimes a quick way to siphon all the fun out of a game and make it feel like the real world you're trying to escape from. Perhaps this could be limited and only able to buy certain items?

## Mining
As noted elsewhere I don't like the unqiue mechanic of mining in melvor where nodes have to respawn. Instead ask ourselves what makes mining unqiue IRL? Well there are mine carts that have to take ore to the surface; maybe some resources are deeper (and as you mine they require longer times to bring the ore to the surface?) and you could upgrade your mine track/mine carts? Similar effect to the node respawn mechanic but better theming.

## Points of interest in combat
Dungeons in melvor are a little uninteresting. It's not exactly clear why you would do dungeons vs regular combat. One would assume since there are unique items from dungeons they must be worse exp/hour or something but it's not clear (and I haven't verified that personally). Also in combat I think you can get unique items from certain monsters too so is that really a big difference?

Alternative proposal: discover dungeons (call them Points of Interest) while doing combat, maybe one per hour or something.

## Taming
Invest time to tame pets. They have multiple uses but also specialties and have their own level ups and can be customized in that way. Also items like saddles, etc. They can die in ark, not sure if a good idea in our idle game!

# Pollution
In Eco it was very satisfying to clean up pollution and I think a similar mechanic could work in this idle game.

# Weather
# Nutrition
In Eco your effectiveness was decided by the contents of your stomach-- food would stay in there a certain amount of time and contribute to your overall nutritional health which translated to better running, hitting, etc.

* You were rewarded for having a good balance between fat, protein, and vitamins. If you were deficient in one of these areas it weakened your overall health, such that a lesser food that served a need you were missing could be better for you than a greater food.
* That said, given the same ratios more was always better-- more fat or more protein all else equal never hurt your overall health score. 
* If your stomach was (10, 10, 10) then eating a good that was +(20, 0, 0) was better than a food that gave +(10, 0, 0). But a different food that gave +(5, 5, 5) might be better than the first despite being "lower" overall numbers because of the bonus from a balanced diet.

## Implementation
Note that this was very confusing in Eco and we would want to improve on that aspect of the system!

* Three foods in stomach at all times. (Upgrade as a capstone: four foods?)
* Each food has a nutritional profile of three ints: (Protein, Fat, Vitamins)
* Your nutritional score is the sum of all numbers, with a multiplier between (say) 1.0 and 2.0 for the numbers being close to each other. Have to check the math on this to ensure it meets the criteria about never punishing you for upgrading to a strictly better food.
* Perhaps calculate and make available automatically an interface showing the player what the optimal mix of food is to be having at any one time. They'll still need to understand it to know what they should focus on gathering but at least the optimal mix *right now* will always be one click away.

## Interactions with other systems
* Forces you to diversify your food production. Foods can be better not just in terms of value but in terms of balance. Lends a natural dynamism to your food gathering: if you find a new food source rich in Fat that can make foods that were previously optimal no longer optimal.
* Other professions could have bonuses for a balanced or imbalanced stomach
* Spells or potions could amerliorate an imbalanced stomach or enhance a well balanced one

# Stocks vs flows
A very satisfying thing in management sims is to establish a flow of a resource, where previously you only had a stock. That is, you start out gathering e.g. ore and have an ever-fluctuating stock, but eventually graduate to having a flow as you create a mine that constantly delivers (and is consumed automatically as well). 

Melvor Idle clearly avoids this practice, everything is a stock that has to be actively gathered. The pace is rather that you gather so much of a resource (by idling on it for a long period) that in practice you have an everlasting supply and don't have to think about it for awhile. I don't want to discount the idea that this could be a really good idea and contributes to the [[Magic]]. 

# Stats
What if we had stats like Str, Dex, Int, etc. Rather than or in addition to +% speed at certain activities. Then boosting Str would boost your e.g. woodchopping but also your combat.

# Sports
What if an alternative to agility is a profession where you have to play against progressively harder opponents. The baseline chance to win a match of the sport (tennis, wrestling..?) is something insanely small like 1%, meaning you end up grinding for a highly variable amount of time, but with the same average grind as other skills. You can rank up against various opponents and there might be some subtle optimization you can do against each.

# Community center
Everyone loved Stardew Valley's community center, forcing you to contribute a certain small amount of everything to unlock stuff. We could do the same here. Is there a branch of magic that involves collecting/documenting things?

# Schools and branches of magic
There should be schools of magic corresponding to the skills in Melvor Idle. But what if instead of each activity corresponding to a specific spell it corresponded to study in a specific branch of magic. I.e. "Hex magic". Or should these branches be referred to as schools and the overall category something else? Anyways the way I picture it is that each activity would unlock more spells as you went up in mastery. E.g.
**Lightning magic**
* 10: Learn "Lightning bolt"
* 25: Learn "Lightning storm"
* 50: Lightning magic is 50% more effective
* 75: Learn "Thunder"
* 100: Lightning magic has 25% chance to double-cast.
Lightning magic would be just one activity out of many in e.g. Nature Magic tab.
* 

# Resources partially used in recipes
I like that in farmside you create feed for different animals using any of your farm products. From wheat to coconuts any food can be used to create e.g. chicken feed. But some food has more value in creating a unit of food--
* You need 100 value to create a unit of food
* Wheat lends e.g. 10 value but a coconut a full 100. If something is added to the feeder that causes it to exceed 100 it "rolls over" value to the next produced feed.
* There are multiple different kinds of feed to produce-- chicken, cow, and sheep. If an animal likes a certain type of food it counts for more in its recipe-- e.g. maybe wheat counts for 15 in the chicken feed but only 10 in cow.
* This idea could be implemented for any number of resource consuming skills but feels especially good for animal feed for some reason. Could be human food too. Or potions.
# Helping people out
For the exploration portion of the game I have some ideas
* Each region has people with problems. Solving the problems of the region is one of your main goals in the game, and it can be restored to peace or whatever if you solve enough of them. What that means differs from region to region.
* Solving a problem boils down to having enough "power" in a given domain, represented by icons on your spells and gear.
* Examples of domains: livestock, cultivation, healing, repairing machines, managing ghosts
* Examples of problems: cows have been sick -> needs 2 livestock + 1 healing, broken farm equipment -> needs 3 repairing machines
* Knowledge of the region or something could reduce these thresholds, e.g. -1 power of any kind needed.
* Spells are consumable and grant you the 

# Only Zones
* I like this zone idea so much I'm starting to wonder if there's any reason to have the school involved at all.
* What if spells were discovered in the lands you wander (I like this on its own merits, but it works gameplay wise too!). They could be tagged by their type as well as their origin
* The spells would be crafted in those regions, typically from reagents from that region but possibly adding others
* The first thing a player would do would be start exploring an area-- very simple and obvious loop can be established right off the bat-- spend some time gathering, craft some spells, get rewarded, go back to gathering now more quickly.
## Zone progression
* Starter zone that's really simple
* Zone that introduces combat
* Zone that introduces armor crafting
* Zone that introduces wands
These zones would be memorable and notable for being associated with given gameplay elements-- you mainly return to Wand-landia for wand materials and crafting better ones-- but that is:
a) not the only identity of these places (don't call it Wand-landia, call it something of its own and flavorful
b) not the only game in town for that gameplay element. Different areas mix and match gameplay elements as they would in real life. Depending on proximity or trade routes the elements seep into each other

# Gear investment
What if gear worked this way:
* No crafting gear with predetermined stats, or getting it as rewards. That's fun, but it's been done to death. Instead you craft e.g. base cloaks, that all have slots in them. 
* For instance, you might craft a basic robe for ten hours and get 100 common, 10 rare, 1 quality result. The quality result has more slots available than the others so you'd invest that.
* The quality you would invest with a bunch of spells of a certain type to give that robe a lingering association with the spell. Depending on the circumstance this would mean that wearing that clothes would give a discount on that icon (for quests), boost the icon (for fighting monsters), etc.

