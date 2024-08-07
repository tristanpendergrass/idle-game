import axios from "axios";
import * as CodeGen from "elm-codegen";

async function fetchGoogleSheetData() {
  const url =
    "https://script.google.com/macros/s/AKfycbwycXmFk8AJKcQQ1p73jJEq2ZzQbWcIJi49pqkYETOmk62BY_qegwsmQr-IkGIfHdK2hg/exec";

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
    academicTests: academicTestConfig,
  } = data;
  CodeGen.run("Generate.elm", {
    debug: true,
    output: "src",
    flags: {
      skillConfig,
      activityConfig,
      resourceConfig,
      academicTestConfig: academicTestConfig,
    },
    cwd: "./codegen",
  });
});
