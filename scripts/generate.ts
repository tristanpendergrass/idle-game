import axios from "axios";
import path from "path";
import * as CodeGen from "elm-codegen";
import { writeFile } from "fs/promises";
import subjectConfig from "./subjectConfig.json";
import activityConfig from "./activityConfig.json";

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

async function saveJSONToFile() {
  const data = await fetchGoogleSheetData();

  if (data) {
    const jsonContent = JSON.stringify(data, null, 2);

    const filePath = "./activityConfig.json"; // Change to your desired path

    try {
      await writeFile(filePath, jsonContent);
      console.log("JSON file has been saved");
    } catch (err) {
      console.error("Error writing to file", err);
    }
  }
}

// saveJSONToFile();

fetchGoogleSheetData().then((data) => {
  const { subjects: subjectConfig, activities: activityConfig } = data;
  CodeGen.run("Generate.elm", {
    debug: true,
    output: "src",
    flags: { subjectConfig, activityConfig },
    cwd: "./codegen",
  });
});
