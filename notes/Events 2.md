Effects are how we give the players resources.

A basic effect type is GainCoin which specifies how much coin to grant the player.

Sometimes an Event is happening which has multiple effects like gain a coin and gain a resource. We group them up and execute them in whatever order. When they're all additive this is fine. 

Some Events have effects that subtract though, either coin, resources, or whatever. More generally, some effects can Err. What that means depends on the Effect-- and especially on its Requirement property:

type Requirement =
	| Required 
	| Optional (List Effect) -- extra effects are added to Event if this Effect is Err

- What happens when granted a resource that we already have max stacks of and we grant coin instead?
Idea: gaining the resource results in Err, but Effect is not marked Required so the alt effect GainCoin is created.

- What happens when an activity requires an input that we don't have?
This is modeled as the Event having an Effect that is required but the reducer returns Err when applying the effect to the model at this point in time.

- What happens when a mod gives an activity "resource preservation" chance?