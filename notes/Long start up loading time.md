In Melvor it's very annoying the the UI freezes as the game runs all the ticks since you've been away. It gets worse as your game progresses, presumably because of the number of different bonuses and things to check becomes greater for every tick.

To minimize the frustration we should at least show a progress bar/animation while it's calculating that, and not freeze up the UI. Here's some thoughts on the technical side of doing that in Elm:

## Problem with naive implementation
The naive implementation I already have in place is to do a recursive function that updates the game model and moves it to the next tick and it runs until the current time of the game is up to the current time according to the browser. But if calculating a tick takes too long or the wait time was too long (up to 24 hrs, in Melvor's case; we would like to have it go even longer!) that will cause a noticeable freeze on start up. In my Melvor game on my PC that can take upwards of 20 seconds, with the UI frozen and the browser claiming the tab is dead and asking me if I want to close it.

## Background worker
The first solution that comes to my mind is one JS environments often use for large calculations: a background worker (and for an Elm app, that means ports too to communicate with it).

The Elm slack person helping me says they think that version would be a lot of work and instead proposed:

## Spread work over multiple update calls
>Another thing that you could try and that would probably be a lot easier, is to cut up the computations over several `update` functions. Do the first say hundred ticks, update your model, then trigger a Msg (using Process.sleep for instance) that will cause the next batch to be computed at the next iteration.

This sounds workable, but I think we would want some complicated support code that probably justify its own module:
* We should accommodate different computation speeds of browsers. This might mean we have to intelligently adjust the number of ticks per update. We could start with doing one hundred ticks and then sleeping, as that person suggested, then if that leaves a lot of time to sleep in, ramp it up or slow it down as necessary.