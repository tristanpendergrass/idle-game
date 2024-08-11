The TimePasses module is needed to fast forward the game to the current time. The `Game` object containing all the game data associated with a player's game doesn't contain the "current time", that is tracked separately. The frontend and backend both store rather a GameState like so:
```
type alias GameState = (Posix, Game)
```

If we didn't care about UX at all we could simply do all updates of this in the browser's onAnimationFrame handler. We would take the current time Posix value and compare to the gameState of the frontend and recursively tick the game until it was caught up.

But we actually want to show a "Time Passes" modal in two situations:
* The app just regained visibility
* The app is being initialized
In both of these cases, relying on the onAnimationFrame handler to bring the game up to speed would work but it might take a long time (if the time elapsed was long) and we wouldn't show any sort of progress report to the player which they definitely want to see.

The solution is for the frontend to store a FrontendGameState:
```
type FrontendGameState
	= Initializing
	| Playing GameState
	| FastForward { originalGameState : GameState, currentGameState : GameState }
```

* Initializing means we're waiting for our initial payload from the backend. If animationFrame or visibility events happen while the frontend is still initializing they should be ignored.
* Playing means the game is "up to date" and any new animation frames should update it without triggering the Time Passes modal. If the app goes from not visible to visible while Playing we should see how much time has elapsed and probably put the app in FastForward mode.
* The app gets put in FastForward mode either because of frontend init or because it regained visibility. Int FastForward we probably shouldn't show the standard game to the player or allow input. Instead we should show a modal or interstitial of some kind indicating they need to wait.
	* What happens when another init or visibility event happens while the app is in fast forward?
	* Upon completion of the FastForward calculation we should put the app to Playing and show the TimePasses modal
	* For a long FastForward we don't want the player to have an unresponsive UI. Suggestions from the Elm slack are either put the calculation in a web worker to let it happen on another thread or work out a system where the work is done piecemeal and a Cmd Task is generated at the end of a piece to do the next piece.

# GameState
We should find a way to use the type system to "make impossible" a certain class of bug: where a user finds that beacuse of weirdness in our time tracking system they've not gotten progress they were due. No off by one bug with animation frames, visibility, or network shenanigans should ever be able to get the Game and the time we think the game is at to be out of sync. As a result we should make a module around this type:
```
type GameState =
	GameState (Posix, Game)
```
This module will have methods to advance from one game state to the next, get the number of ticks between game states, etc. But it should never allow an operation which would cause the time to update without the game updating in sync or vice versa.

In this way we can be sure that class of bug mentioned above will never happen. At worst a client and server might have different GameStates stored, but this can be reconciled by which one has the Posix closer to the real time according to that system.