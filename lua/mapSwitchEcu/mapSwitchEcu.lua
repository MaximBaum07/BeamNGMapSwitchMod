local modName = "mapSwitchEcu"
local M = {}

M.numberOfMaps = 3
M.currentMapIndex = 1

function M.applyMap(vehicle, mapIndex)
  print("LINE 8")
  if not vehicle then return end

  if mapIndex < 1 or mapIndex > M.numberOfMaps then
    mapIndex = 1
  end

  local boostVarName = string.format("map%d_boost", mapIndex)
  local boost = vehicle:getVariableFloat(boostVarName, 10)

  vehicle:setParameterFloat("turbocharger", "wastegateStart", boost)
  print("LINE 19")

  M.currentMapIndex = mapIndex
  print(string.format("mapSwitchEcu: Applied map %d with boost %.1f psi, rpm %.0f RPM", mapIndex, boost))
end

local function onMapChange(eventName, mapIndex)
  print("LINE 26")
  local vehicle = be:getPlayerVehicle(0)
  if vehicle then
    M.applyMap(vehicle, mapIndex)
  end
  print("LINE 31")
end

function mapswitch_changeMap(mapIndex)
  local vehicle = be:getPlayerVehicle(0)
  if vehicle then
    -- Do exactly what your change logic needs
    local mod = vehicle.mods.mapSwitchEcu
    if mod then
      mod.applyMap(vehicle, mapIndex)
    end
  end
end

_G.mapswitch_changeMap = mapswitch_changeMap


print("LINE 34")

be:addListener("mapswitch/changeMap", onMapChange)

print("LINE 38")

return M
