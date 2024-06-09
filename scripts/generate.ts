import axios from "axios";
import * as CodeGen from "elm-codegen";

async function fetchGoogleSheetData() {
  const url =
    "https://script.google.com/macros/s/AKfycbwEpJyYPddBYZZXnP1zhkUMJ0ILlTGiE4HzHtlfdcppOm8wjLr7Ij8CoiN2WsdNieBuDw/exec";

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
  const { subjects: subjectConfig, activities: activityConfig } = data;
  CodeGen.run("Generate.elm", {
    debug: true,
    output: "src",
    flags: { subjectConfig, activityConfig },
    cwd: "./codegen",
  });
});
