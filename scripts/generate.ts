import axios from "axios";
import * as CodeGen from "elm-codegen";

async function fetchGoogleSheetData() {
  const url =
    "https://script.google.com/macros/s/AKfycbxtYsr5UPnWImRzcgLhMPtokBLneUjSJp5mEK4LPjnQlkzQVRRjPXJr1nWS_qjvYZqghQ/exec";

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
    subjects: subjectConfig,
    activities: activityConfig,
    resources: resourceConfig,
  } = data;
  CodeGen.run("Generate.elm", {
    debug: true,
    output: "src",
    flags: { subjectConfig, activityConfig, resourceConfig },
    cwd: "./codegen",
  });
});
