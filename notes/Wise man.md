
Many games show valuable tips from their loading screen. This may seem relatively inconsequential but I think it's actually an extremely under recognized method of educating the player on game systems. Tutorials that tell the player things obviously suck. But the curse of human tendency to say "good enough" if something is mostly working means that it's hard to teach players a better way of doing something any other way. They won't necessarily seek out the quality of life or cool features you add if they're not completely in the way and necessary.

One instance I'm thinking of is how to teach players that they can long-press an activity to preview it. I definitely want them to find out about this since the inability to preview things in Melvor without starting the activity was a big complaint. But it's also not worth putting a blocking notice in front of the player to tell them how to preview something (essentially nothing is). So how to enable?

Mobile games do  this thing where at some time they do a little animation (often of a finger or hand making a gesture) and when the player clicks it it launches into a tutorial. This is better than the dreaded forced tutorial that comes before you can play the game but still not ideal.

I really like games that dispense the tips organically. Some Nintendo games like the Legend of Zelda games do this by having totally optional dialogue with random NPCs where the NPC will say "I heard you can hit A near a plant to pick it" or something like that. We'll try to do something like that in the following way:

Wise man (final name TBD) will be an NPC activity in some skill that is available from early on and you will be coming back to periodically (Chores?).
* If wise man is ready to talk they will have a "!" icon on them and the Speak action available. Then the tip will be dispensed when you click this.
* If wise man isn't ready to talk they will have no special icon but you can still click some button that shows a list of all the hints they have ever given you.
The schedule for when the NPC is ready to speak should be somewhat random. We don't normally
To make it fun and less of an obvious tutorial we could have the NPC randomly dispense coins or rare items instead of tips.

# Implementation notes
* We don't want the fact that the wise man sometimes dispenses coins or items to the make the player feel pressured to "check back" every day. There needs to be some abstraction (sort of like a pity timer) that keeps track of the rewards given over the game's lifetime and adjusts the likelihood of getting one to keep the player "on track" more or less despite the randomness. See tip idea number 1 below.
* The time remaining before the next activation of the wiseman is randomly determined after each activation. It should be a normal distribution with a mean around 1 day. Or should the mean increase over time?
* There should be a reward pool from which tips or rewards are pulled when the wiseman is ready. 
    * Example pool: tip 1, tip 2, tip 3, reward, reward
        * Example config shape?
            * `[ tip1 ]`
            * `[ tip2 ]`
            * `[ tip3, tip4, tip5, reward, reward, customReward ]`
            * `defaultReward: reward`
            * In this case we ensure the first two tips are dispensed in a set order while the rest will be random, but all tips will be dispensed at least before 9 activations. After that it will just dispense rewards.
    * Once the pool is exhausted the next pool is activated. In this way we ensure they don't receive too many tips or rewards in a row.
    * A reward is randomly determined to be small/medium/large and there's a random pool of outcomes for each of these. Size given should be influenced by lifetime of game vs total rewards ever given. If these are out of ratio then remove small items from the pool.
* Need to consider: how to add new early tips to the game in later versions and ensure veterans and new players both see them?
* Alternative system: each tip gets tagged with a priority, and lower priorities are shown before higher always. So new tips can be added with low priorities and will definitely be shown to verteran players as they won't register as viewed

# Tip ideas
Should the tips be given in the second person?
* The great wiseman does not desire to speak with you every day! In fact, know that the rewards he bestows upon depend not on how often you speak with him, but on the tides of time...
    * Note this should be programmed to come after a couple of rewards have been given
* Long press an activity to preview it