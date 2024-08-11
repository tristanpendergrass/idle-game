[[Melvor Idle]]'s bank has tall stacks, what if our idle game had wide stacks?

Tall stacks means the bank can contain a practically unlimited amount of a given resource, but the number of different resources it can contain is strictly limited.

Wide stacks is just the inverse: the bank can contain a practically unlimited number of different resources, but the amount of each that it can contain is strictly limited.

# Implementation of wide stacks
### Global Cap
The naive implementation is that there would be a global cap, X. If you get a resource but are already at X of that resource it will be automatically sold off for its gold value. In this fashion you will probably return from idling for awhile to find you have filled up to X on the resource you were gathering and gotten some gold besides. Upgrading your bank would mean increasing X.
* Disadvantage: this might be difficult to balance so that you can continuously upgrade X while still feeling like your late-game resources (which you'll have very few of compared to early game resources) are constrained in some way. Tall stacking system lends an inherent equality to all resources, from basic logs to the magic logs, in that each type takes up exactly one bank slot.
## Per-resource caps
Each resource, or perhaps each category of resource, would have its own upgradeable cap. 
* Advantage: we could make this upgrade path flavorful; it could require resources from within the profession to upgrade the storage of the profession. Or maybe it always requires stone or wood. Maybe storage building is its own profession!
* Disadvantage: this is a lot of micro management.
* Disadvantage: Lose the satisfying simplicity of saving up and buying more bank slots in Melvor Idle. It's an anchor point in a game with a lot of different ways to play. One can always size up one's bank slots against someone else to know roughly how far along they've come. No matter how you play this number will grow and it interacts with all systems in roughly  the same way.

# Advantage of Tall
* Naturally nudges player towards just a couple activities at the start, preventing analysis paralysis.
* Threat of losing unique items keeps players on their toes and adds an interesting fate worse than death: being given a rare item but your bank was full so it was lost. (*Is this really an advantage or just Stockholm Syndrome?*)
* Well-suited to a low-key idle game because you can idle on a given resource and accumulate it indefinitely. It really contributes to the feeling that you can play at your own pace, and not log on and micro manage and nothing will be lost.

# Advantage of Wide
* Players can be given one-off unique items and it is all gain no pain. With "Tall" a new unique item you find is sort of a white elephant gift-- you might want to sell it off immediately lest it clutter your poor limited bank!
* Hypothesis: it will be fun to fill up your "reserves" to full and keep them there
