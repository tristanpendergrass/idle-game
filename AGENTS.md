# Compiling
After making any changes to source code, check that it still compiles with:
`lamdera make src/Frontend.elm src/Backend.elm`

# Testing
To validate behavioral changes or ensure no regressions, run the e2e tests with:
`npx playwright test --reporter=line`