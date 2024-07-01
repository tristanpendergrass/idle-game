import axios from "axios";
import * as CodeGen from "elm-codegen";

async function fetchGoogleSheetData() {
  const url =
    "https://script.google.com/macros/s/AKfycbyYR2bZUxA-g55mdoTn8pQzRYDCXAWNv9ETegVrsduNrd7I_eSmHsS613X057dVRYNbeA/exec";

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      throw new Error("Network response was not ok");
    }

    const jsonData = response.data;
    return jsonData;
  } catch (error) {
    console.error("There has been a problem with your fetch operation:", error);
  }
}

fetchGoogleSheetData().then((data) => {
  const {
    skills: skillConfig,
    activities: activityConfig,
    resources: resourceConfig,
    tests: testConfig,
  } = data;
  CodeGen.run("Generate.elm", {
    debug: true,
    output: "src",
    flags: { skillConfig, activityConfig, resourceConfig, testConfig },
    cwd: "./codegen",
  });
});
