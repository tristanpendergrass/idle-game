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

## Release 1
- [x] Mastery for items checkpoints
- [x] Bag tab
- [x] Grant items from chores
- [x] Add Notification of gained items
- [x] Improve Time passes modal
  - [x] Add all resources to list of things to show
  - [x] Show Levels gained not just XP
  - [x] Show Gold gained
- [x] Improve experience when calculating long amount of time
- [x] "Coming soon" for other skills
- [x] Shop
- [ ] Icons for things
- [ ] Develop Mod that speeds up interval
- [ ] Finalize values for all things
- [x] Visuals for chores

## Release 2
### Tech stuff
- [ ] Dev Panel
	- [ ] Add time
	- [ ] Toggle off Time Passes showing
- [ ] Refactor gold to be a non-negative type
- [ ] Set up elm-review
  - [ ] Add custom rule to replace String.fromInt with Utils.intToString
- [ ] Load pictures in sprite sheet at init and dont show app until loaded

### Fundamentals
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