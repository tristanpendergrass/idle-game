# Compiling
After making any changes to source code, check that it still compiles with:
`lamdera make src/Frontend.elm src/Backend.elm`

# Testing
To validate behavioral changes or ensure no regressions, run the e2e tests with:
`npx playwright test --reporter=line`

## When to run tests
Running the e2e tests as described above takes time and the tests should only be run when it will provide some benefit.
- If the main task failed for some reason, there's no reason to also run the tests before reporting the result. For instance, if asked to make a change but another process like elm-review is glitching out, no need to run tests and note that they passed.
- If running in an iterative loop, no need to run the tests in between each iteration; wait until the code is in a state we're confident is final then run the tests to confirm no regressions.
- Make writing new tests and adjusting existing ones part of an iteration loop when the result being iterated towards is an observable change in behavior to the user. In that case running the tests between each iteration may be a good idea.