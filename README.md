# Development

1. [Install Lamdera](https://lamdera.com/start)

2. Run css watcher in one terminal tab:
```
$ npm run build:css -- --watch
```

3. Run lamdera in a different terminal tab:
```
$ lamdera live
```

# Testing

```
$ npm test
```

or

```
$ npm test -- --watch
```

# Todos

## Version 0.1
- [x] Mastery for items checkpoints
- [x] Bag tab
- [x] Grant items from chores
- [x] Add Notification of gained items
- [x] Improve Time passes modal
  - [x] Add all resources to list of things to show
  - [x] Show Levels gained not just XP
  - [x] Show coin gained
- [x] Improve experience when calculating long amount of time
- [x] "Coming soon" for other skills
- [x] Shop
- [x] Icons for things
- [x] Develop Mod that speeds up interval
- [x] Show speed on chores
- [x] Finalize values for all things
- [x] Visuals for chores
- [ ] Final polish

## Version 0.1.1
- [ ] Build up foundation by picking items from Release 2's Tech stuff and Fundamentals

## Version 0.2
### Tech stuff
- [ ] Dev Panel
	- [ ] Add time
	- [ ] Toggle off Time Passes showing
- [ ] Refactor coin to be a non-negative type
- [ ] Set up elm-review
  - [ ] Add custom rule to replace String.fromInt with Utils.intToString
- [ ] Load pictures in sprite sheet at init and dont show app until loaded
- [ ] Refactor Chore event so we don't duplicate logic like `toFloat currentMasteryLevel * choreStats.outcome.duration` between Chores.elm and Game.elm
  - [ ] Same with Modded duration in Chores.elm
- [ ] Refactor getAllMods and getAllIntervalMods so they're not two separate functions. Also it should not be possible that the mods for e.g. chore thresholds are commented out but still appear in UI, UI and effect should be drawn from same place
- [ ] Remove tags from Event, should only come from effects

### Fundamentals
- [ ] Show what mods there are on an effect/interval and where they came from
- [ ] Allow shop items to have requirements besides coin. Resources and level requirements
- [ ] Activity detail sidebar
	- [ ] desktop
	- [ ] mobile
- [ ] Activity status bar at bottom for mobile
- [ ] Move Item Mastery (M) info to detail sidebar
- [ ] Show Time Passes during Fast Forward with real time change

### Features
- [ ] Skill 2
- [ ] Skill 3

### Glitz
- [ ] Progress bar animations
- [ ] Format numbers correctly with commas etc. in Time Passes modal
- [ ] Close modals on space/escape
- [ ] Design audit following https://anthonyhobday.com/sideprojects/saferules/