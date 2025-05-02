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
To make changes: edit `codegen/Generate.elm` then run

```
$ npm run generate-elm
```

This will run elm-codegen and copy the results from `generated/` to `src/`.

If updated types in main app that are needed by codegen, run:

```
$ cd codegen
$ npx elm-codegen install
```


# Deployment
[ ] Run unit tests (see above)
[ ] Run `$ npx elm-review --fix`
[ ] Edit README.md
  [ ] Move current version from Todos to Changelog
  [ ] Create new section header for next version
[ ] Update current version in `Config.elm`
[ ] Commit all changes in Git
[ ] Run `$ lamdera check`
  [ ] Optional: Run `$ lamdera check --destructive-migration` instead if willing to destroy all prod data
[ ] Commit changes in git. Don't forget to use `$ git add .` instead of `$ git commit -am`! There's new migration files at this point.
[ ] Run `$ lamdera deploy`
[ ] Run `$ git tag {version}` and `$ git push --tags`

# Todos

## Tech stuff
[ ] Hide authentication logic for now
[x] Migrate to latest version of DaisyUI and Tailwind
[ ] Migrate away from @apply blocks per tailwind creator's tweet

## Bugs
[ ] When doing lab with 50% success rate I see "+0 coin" when failure happens
[ ] Fix that bug where there's a bunch of toasts when you come back

## v0.2
[ ] Hard to figure out what each number means in the activity. Yang says add terminology like "Gain:" so it's clear.
[ ] Add a resource you can get for completing the Step 1
[ ] Remember tab you were on by storing in backend model
[ ] Testing Center 2/2: do some basic tests for all subjects plus basic shelf exam and Step 1
[ ] XP 2/2: customized xp schedule for all activities
[ ] Costs 2/2: customized effects for all activities
[ ] Add changelog
[ ] Add shop items
[ ] Add mail system
[ ] Listen to music for bonuses
[ ] Better test logic
[ ] Enable to close the debug menu
[ ] Left side nav has horizontal scroll bar
[ ] Refactor so that the Google sheets columns don't have format "resource:amount" but rather two columns, one for resource other for amount

# Done
[x] Remove code references to old version
[x] Use https://github.com/mdgriffith/elm-codegen/blob/main/guide/UsingElmCodeGenInTypeScript.md to codegen with json object string for config
[x] Add anatomy topics
[x] Add Biochemistry
[x] Add Microchemistry and Immunology (experiments)
[x] Add Pathology

## v0.1
[x] Testing Center 1/2: do some basic tests for all subjects plus basic shelf exam and Step 1
[x] Add a Welcome tab
[x] Activity doesn't show modified effect correctly in detail view
[x] Fix issue with probabilistic awards not being granted on large time step
[x] New icon for PK
[x] Disable the debug menu in prod
[x] The status bar at bottom on mobile has wrong text color
[x] XP 1/2: basic xp schedule for all activities
[x] Costs 1/2: basic cost effects for all activities
[x] Show resource name in tooltip
[x] Show resource name in sidebar
[x] Labs
  [x] XP
  [x] Create one art for all
  [x] Masteries
  [x] Costs
  [x] Rewards
[x] Support Testing Center tab
[x] Design Tests
[x] Support Labs skill
  [x] Grant K and PK and coin with some probability
[x] Reduce costs by 1 per PK
[x] Support Practical Knowledge and Labs in Anatomy
[x] Add masteries
  [x] Design
  [x] Implement