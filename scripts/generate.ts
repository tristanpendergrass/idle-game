import * as CodeGen from "elm-codegen";
import * as fs from "fs";
import * as path from "path";
import subjectConfig from "./subjectConfig.json";
import activityConfig from "./activityConfig.json";

CodeGen.run("Generate.elm", {
  debug: true,
  output: "src",
  flags: { subjectConfig, activityConfig },
  cwd: "./codegen",
});
