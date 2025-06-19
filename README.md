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
I created some quick performance tests in IdleGame/PerfTesting/. They were created to demonstrate how long calculating Time Passes would take after the player returned after various lengths of time. Each test varies the length of time and the "tick duration" to see what can be satisfactory. The tests all pass automatically, the true test is how long the test takes to run. Of course, this isn't necessarily reproducible across different machines, or representative of user hardware and results, but it's close enough to make some rough comparisons.

```
$ npx elm-test src/IdleGame/PerfTesting/Test60Days.elm
```

## E2E testing
Playwright tests are in `/e2e` directory, run them like so:

```
npx playwright install -- Only have to run once
npx playwright test
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

## Bugs
[ ] Pausing activity the image goes away
[ ] Way too many toasts potentially shown when coming back to activity lacking resources
[x] Background is all black on modal

## v0.1

### Features
[x] Replace skills with Herb Gathering and Wild Magic
[ ] Add herb gathering with progressively more xp
[ ] Design mastery for herbs
[ ] Design spells
[ ] Add activities for those
[ ] Add correct shop items
[ ] Add inventory limits for herbs gathered
[ ] Sell excess gathered herbs

### Tech stuff
[ ] Get rid of "createDev" in favor of specialized flags
[ ] Rethink the top level organization and naming of files, maybe IdleGame -> IG or Game or something.
[x] Migrate away from @apply blocks per tailwind creator's recommendation
[x] Fix reload causing animation to pause.
[x] Hide authentication logic for now
[x] Migrate to latest version of DaisyUI and Tailwind