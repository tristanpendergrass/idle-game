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
[ ] Run `$ lamdera check`
  [ ] Optional: Run `$ lamdera check --destructive-migration` instead if willing to destroy all prod data
[ ] Commit changes in git. Don't forget to use `$ git add .` instead of `$ git commit -am`! There's new migration files at this point.
[ ] Run `$ lamdera deploy`
[ ] Run `$ git tag {version}` and `$ git push --tags`

# Todos

## v0.1
[ ] Support mail
[x] Support Testing Center tab
[ ] Design Tests
[ ] Support Labs skill
  [ ] Grant K and PK and coin with some probability
[x] Reduce costs by 1 per PK
[ ] Support Practical Knowledge and Labs in Anatomy
[ ] Change DaisyUI theme
[ ] Figure out how to show PK in a satisfying way

## v0.2
[ ] Listen to music
[ ] Better test completion UI with modal and animation

## Done
[x] Remove code references to old version
[x] Use https://github.com/mdgriffith/elm-codegen/blob/main/guide/UsingElmCodeGenInTypeScript.md to codegen with json object string for config
[x] Add anatomy topics
[x] Add Biochemistry
[x] Add Microchemistry and Immunology (experiments)
[x] Add Pathology