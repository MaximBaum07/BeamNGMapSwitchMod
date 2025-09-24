"use strict";

(function () {
  let mapText = document.getElementById("mapText");
  let mapBox = document.getElementById("mapBox");

  const maps = [
    { name: "Map 1", boost: 10 },
    { name: "Map 2", boost: 15 },
    { name: "Map 3", boost: 20 },
  ];
  let currentIndex = 0;

  function applyMap(map) {
    // Send Lua command to BeamNG to set turbo boost - replace with actual Lua API call
    const luaCmd = `be:getObject(0):setTurboBoost(${map.boost})`;
    if (window.bngApi && bngApi.engine) {
      bngApi.engine.eval(luaCmd);
    }
    if (mapText) {
      mapText.textContent = map.name;
    }
    console.log(`Switched to ${map.name} with boost ${map.boost}psi`);
  }

  function switchMap() {
    currentIndex = (currentIndex + 1) % maps.length;
    applyMap(maps[currentIndex]);
  }

  if (mapBox) {
    mapBox.addEventListener("click", switchMap);
  }

  // Initialize on load
  applyMap(maps[currentIndex]);
})();
