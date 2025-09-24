local modName = "mapSwitchEcu"

local M = {}

M.numberOfMaps = 3
M.currentMapIndex = 1

function M.applyMap(vehicle, mapIndex)
  if not vehicle then return end

  if mapIndex < 1 or mapIndex > M.numberOfMaps then
    mapIndex = 1
  end

  local boostVarName = string.format("map%d_boost", mapIndex)
  local boost = vehicle:getVariableFloat(boostVarName, 10)

  local parts = vehicle:getInstalledParts()
  for _, part in ipairs(parts) do
    if part:getName() == "map_switch_component" then
      part:setFloatVariable("boost", boost)
      break
    end
  end

  M.currentMapIndex = mapIndex
  print(string.format("mapSwitchEcu: Applied map %d with boost %.1f psi", mapIndex, boost))
end

local function onMapChange(eventName, mapIndex)
  local vehicle = be:getPlayerVehicle(0)
  if vehicle then
    M.applyMap(vehicle, mapIndex)
  end
end

be:addListener("mapswitch/changeMap", onMapChange)

return M
