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

# Deployment
[ ] Run unit tests (see above)
[ ] Run `$ npx elm-review --fix`
[ ] Edit README.md
  [ ] Move current version from Todos to Changelog
  [ ] Create new section header for next version
[ ] Update current version in `Config.elm`
[ ] Commit changes in git
[ ] Run `$ lamdera check` and `$ lamdera deploy`
[ ] Run `$ git tag {version}` and `$ git push --tags`

# Todos

## Version 0.2.1
- [ ] Stuff

## Future
### Tech stuff
- [ ] Load pictures in sprite sheet at init and dont show app until loaded
- [ ] Refactor getAllMods and getAllIntervalMods so they're not two separate functions. Also it should not be possible that the mods for e.g. chore thresholds are commented out but still appear in UI, UI and effect should be drawn from same place
- [ ] Refactor success probability so mods can make it go over 100% but only displays capped at 100%
- [ ] Find a way to unit test performance of tick
- [ ] Refactor ShopItems. Why are there getters and setters on Stats there? Also the descriptions are hardcoded instead of derived from their effects
- [ ] When tab is viewed again the focus is on the Adventuring/Skilling button instead of the Time passes modal's button

### Fundamentals
- [ ] Fix bug with displaying e.g. combat rewards and variable rewards in chores that have been modded. Right now they show the base but not the modded value because of how applyEffects work (only applying mod to successEffects when generator returns a success). Another possible solution: make use of includeVariableEffects, if only in the view layer.
- [ ] Make resource preservation mod work. How to transform an effect from costing to maybe costing? Also can effects be tagged with "show me"? With most effects created by mods having showMe = False, but this one = True?
- [ ] Allow mods to affect other mods. E.g. I want a spell mastery that boosts the effects of that spell. This should simply be a new type of transformer that gets run from getAllMods
- [ ] Allow shop items to have requirements besides coin. Resources and level requirements
- [ ] Show what mods there are on an effect/interval and where they came from
- [ ] Show Time Passes during Fast Forward with real time change
- [ ] Add change log section
  - [ ] Add notification that shows that update happened
- [ ] Address long fast forward times somehow (with a cap?)
- [ ] Better communication on required materials for skill
  - [ ] UI should show how many of mat you have in detail view
  - [ ] UI should show if you cannot start the activity in detail and content view
  - [ ] Prevent activity starting when clicked if it will fail and show error message

### Features
#### Skills
- [ ] Skill 3
- [ ] Skill 4
#### Combat
- [ ] Regen period after loss

### Glitz
- [ ] Progress bar animations
- [ ] Format numbers correctly with commas etc. in Time Passes modal
- [ ] Close modals on space/escape
- [ ] Design audit following https://anthonyhobday.com/sideprojects/saferules/
- [ ] Money amount in Bag tab looks like a button -- remove background entirely?
- [ ] Make right rail not have slide animation when going from empty to active
- [ ] Show Skill XP as "X / Y" rather than just "X"; where X is current XP and Y is the XP required for the next level.
- [ ] Remove animation on right rail
- [ ] Add a way of giving hints to the player. Old wise man?
- [ ] Change mastery display on activities so it doesn't show mastery xp but rather a mastery progress bar and level. Maybe show which mastery thresholds achieved with dots or something.

# Changelog

## Version 0.2
- [x] Add second "mode": Adventuring
  - [x] Show different tabs in each mode
  - [x] Button to switch between them in left nav
  - [x] Separate preview and activity state for each mode
- [x] Add hexes
  - [x] Craft them for free
  - [x] Require parchment
- [x] Add parchment to shop
- [x] Activity detail sidebar
	- [x] desktop
	- [x] mobile
- [x] Activity status bar at bottom for mobile
- [x] Move Item Mastery (M) info to detail sidebar
- [x] Remove mastery pool logic from game
- [x] Add monster fighting proof of concept
  - [x] Add monster strength
  - [x] Add combat resolution logic
  - [x] Add spell selector
  - [x] Check spell mods from getAllMods
- [x] Add notification when no more resource
- [x] Fix monsters showing player power on activity card
- [x] Show spell effects in preview somehow -- optional
- [x] Show preview of outcome of combat. Victory: "Doubtful" up to "Certain"
- [x] Remove Skill level section from combat tab
- [x] Show rewards from combat
- [x] Finalize gameplay values
  - [x] Chores -- add rest of chores, adjust item and coin values, finalize mastery rewards
  - [x] Hexes -- add rest of hexes, adjust costs of hexes, finalize mastery rewards
  - [x] Combat -- add more monsters and pictures, adjust difficulty, finalize item/coin rewards
  - [x] Shop items -- redesign. Only need a few of these
  - [x] Rename "Combat Tab 1"

## Version 0.1.2
- [x] Fix bug with notification container preventing clicking anything underneath
- [x] Dev Panel
	- [x] Add time
	- [x] Toggle off Time Passes showing
- [x] Set up elm-review
  - [x] Fix all errors
  - [x] Add line item to Deploy checklist
- [x] Refactor values that are floats to be Counters in most places
- [x] Refactor GainChoreMxp logic in Game.elm and Chores.elm to a common spot so it's not duplicated
  - [x] Same with Modded duration in Chores.elm
- [x] Refactor to remove unsafe functions Snapshot.setTime and Snapshot.setValue
- [x] Remove tags from Event, should only come from effects
- [x] Refactor to use elm-units for duration. Fixes bug for saving 1000 times per second instead of 1 time per second.

## Version 0.1.1
- [x] Fix some icons not showing in prod for items (soot2?)
- [x] Fix performance by ensuring no calls to intToString in game tick
- [x] Prevent skill level from exceeding 99
- [x] Make release checklist. - change dev flags to prod flags, update version number in sidebar

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
- [x] Final polish