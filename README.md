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

Using [node-test-runner](https://github.com/rtfeldman/node-test-runner)

```
$ npx elm-test path/to/my/test.elm --watch // runs one test file (in watch mode)
$ npx elm-test "src/**/*Tests.elm" // runs all tests in glob
```

## Perf testing
I created some quick performance tests in IdleGame/PerfTesting/. They were created to demonstrate how long calculating Time Passes would take after the player returned after various lengths of time. Each test varies the length of time and the "tick duration" to see what can be satisfactory. The tests all pass autoamtically, the true test is how long the test takes to run. Of course, this isn't necessarily reproducible across different machines, or representative of user hardware and results, but it's close enough to make some rough comparisons.

```
npx elm-test src/IdleGame/PerfTesting/Test60Days.elm
```

# Codegen

We use [elm-codegen](https://github.com/mdgriffith/elm-codegen) to generate some boilerplate for the game.
To make changes: edit `codegen/Generate.elm` then run `$ npm run generate-elm`. This will run elm-codegen and copy the results from `generated/` to `src/`.

# Deployment
[ ] Run unit tests (see above)
[ ] Run `$ npx elm-review --fix`
[ ] Edit README.md
  [ ] Move current version from Todos to Changelog
  [ ] Create new section header for next version
[ ] Update current version in `Config.elm`
[ ] Run `$ lamdera check`
  [ ] Optional: Run `$ lamdera check --destructive-migration` instead if willing to destroy all prod data
[ ] Commit changes in git. Don't forget to use `$ git add .` instead of `$ git commit -am`! There's new migration files at this point.
[ ] Run `$ lamdera deploy`
[ ] Run `$ git tag {version}` and `$ git push --tags`

# Todos

## Version 0.4
- [x] Greatly enhance perf by optimizing tick of long duration
- [ ] Redesign activity quick view with a focus on clarity over form
  - [ ] Add a green plus sign or something to each gained thing
  - [ ] Add name of thing you're getting in addition to the icon
  - [ ] Put gains in a row with comma between, wrapping to next line if needed. Xp/Mxp gains on their own row
- [ ] FIX: when assigning Wind scroll to Clean Big bubba I see 4 scroll usages in toasts
- [ ] Show assigned spell on activity card
- [x] Put duration back in detail view
- [x] Award spell resource on activity completion
- [x] Consume spell resource when assigned on slot
- [x] Feature: Syllabus for each class
- [x] Tech stuff: Make resource preservation mod work. Change gain resource to have a % chance to not happen that defaults to 0
  - [x] Modify definition of gain resource to have preservation chance
  - [x] Add shop upgrade for this or mastery or something

## Future
### Bugs
- [ ] Fix status bar extending over the sidebar at medium screen widths
- [ ] Fix bug with displaying e.g. combat rewards and variable rewards in chores that have been modded. Right now they show the base but not the modded value because of how applyEffects work (only applying mod to successEffects when generator returns a success). Another possible solution: make use of includeVariableEffects, if only in the view layer.
- [ ] Fix that on mobile you can view detail and keep scrolling and drag detail view up past bottom you'll see something like resource rewards behind.
- [ ] Potential bug: the purchasing of shop upgrades isn't done with an effect. And the view isn't set up with one either, so any future buff that e.g. decreases shop prices won't be priced in or applied.
- [ ] Resource doubling caps at 100%. We should make it so a chance of 100% + n% guarantees two items with a chance at even more. Need to edit applyEffect in Game, I think.

### Tech stuff
- [ ] Load pictures in sprite sheet at init and dont show app until loaded
- [ ] Refactor success probability so mods can make it go over 100% but only displays capped at 100%
- [ ] Find a way to unit test performance of tick
- [ ] When tab is viewed again the focus is on the Adventuring/Skilling button instead of the Time passes modal's button
- [ ] Refactor ShopItems. Why are there getters and setters on Stats there? Also the descriptions are hardcoded instead of derived from their effects

### Fundamentals
- [ ] Add correct source value for all Effects and use it to show source in Time Passes
- [ ] Also can effects be tagged with "show me"? With most effects created by mods having showMe = False, but this one = True? Actually maybe resource preservation should just be built into the GainResource effect.
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
- [ ] Skill: Wild Magic
- [ ] Skill 4
#### Combat
- [ ] Regen period after loss
- [ ] Redesign "danger meter" for combat. Visual inspiration: the power zone interface on peloton. Also wildfire danger signs you see on the road
#### Quests
- [ ] Multi-stage quests
- [ ] Quests that require you to do some more exploring (find something lost)
- [ ] Quests that require you to defeat a certain monster
#### Other
- [ ] Feature: Changelog
- [ ] Feature: Tutorial?
- [ ] Purchase Diploma & Certificate of Completion in shop when completing all classes and *everything*

### Glitz
- [ ] Show coin next to shop in left nav
- [ ] Make top of status bar match the one on ios where there's a horizontal line to signal it can be dragged/clicked.
- [ ] Progress bar animations
- [ ] Format numbers correctly with commas etc. in Time Passes modal
- [ ] Close modals on space/escape
- [ ] Design audit following https://anthonyhobday.com/sideprojects/saferules/
- [ ] Money amount in Bag tab looks like a button -- remove background entirely?
- [ ] Make right rail not have slide animation when going from empty to active
- [ ] Show Skill XP as "X / Y" rather than just "X"; where X is current XP and Y is the XP required for the next level.
- [ ] Remove animation on right rail
- [ ] Add a way of giving hints to the player. Old wise man?
- [ ] Add tags to activities (like scrollwriting, crafting, etc.)

# Changelog

## Version 0.3
- [x] Skill 3
- [x] Support spell selector on Chores and Hex studying
  - [x] Design system for what spells can be assigned on what activities
  - [x] Enable spell selector for Chores/Hexes/Exploring/Enchantment
- [x] Fix it so details view is expanded when page loads in browser width but not expanded when loaded in mobile
- [x] Update TimePasses
  - [x] Show XP from all skills not just chores
  - [x] Show new discoveries in locations
- [x] Show the resources you'll gather on Explore action
- [x] Remove duration from Explore action
- [x] Remove quest log
- [x] Move buttons for changing mode to under bag and shop
- [x] Finalize game config
### Locations
- [x] Convert combat tabs to "Location" tabs
- [x] Add Exploration activity to locations
- [x] Add Resources to locations
- [x] Add Quests to locations
- [x] Add filters for Location activities
- [x] Show discoveries of the four kinds of things (resources, monsters, quests, characters) in locations
- [x] Calculate and display "completion" of locations
### Other
- [x] Shop Improvements
- [x] Change mastery display on activities so it doesn't show mastery xp but rather a mastery progress bar and level. Maybe show which mastery thresholds achieved with dots or something.
### Tech debt
- [x] Refactor for consistent treatment of Kind amongst modules. All into one big module called Kind which can't import from anything and can be imported everywhere.
- [x] Refactor Activity stats so skill is a Maybe Skill. Remove skill from combat and exploring activities

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