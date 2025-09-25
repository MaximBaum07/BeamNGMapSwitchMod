"use strict";

angular.module("beamng.apps").directive("mapSwitch", [
  function () {
    return {
      template:
        '<div style="width:100%; height:100%; display:flex; justify-content:center; align-items:center; cursor:pointer; background:#222; color:#fff; font-size:16px; user-select:none;">' +
        'Map: <span id="mapName">1</span>' +
        "</div>",
      restrict: "E",
      link: function (scope, element, attrs) {
        const maps = [
          { name: "Map 1", boost: 10 },
          { name: "Map 2", boost: 15 },
          { name: "Map 3", boost: 20 },
        ];
        let currentIndex = 0;
        const mapNameElem = element[0].querySelector("#mapName");

        function applyMap(map) {
          if (mapNameElem) {
            mapNameElem.textContent = map.name;
          }
          console.log("Switched to", map.name, "with boost", map.boost);
        }

        function switchMap() {
          currentIndex = (currentIndex + 1) % maps.length;
          applyMap(maps[currentIndex]);

          if (bngApi && typeof bngApi.engineLua === "function") {
            bngApi.engineLua(`mapswitch_changeMap(${currentIndex + 1})`);
          } else {
            console.log("bngApi.engineLua not available");
          }
        }

        element.on("click", switchMap);

        // Initialize with first map
        applyMap(maps[currentIndex]);

        scope.$on("$destroy", function () {
          element.off("click", switchMap);
        });
      },
    };
  },
]);
