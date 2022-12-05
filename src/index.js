import { Elm } from "./Main.elm";

const LOCAL_STORAGE_KEY = "idle_game_data";

const app = Elm.Main.init({
  node: document.querySelector("main"),
  flags: [Date.now(), JSON.parse(localStorage.getItem(LOCAL_STORAGE_KEY))],
});

app.ports.sendToLocalStorage.subscribe(data => {
  localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(data));
});