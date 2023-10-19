local function AddRaceChildren(payload)
  Utils.Info("Entering AddRaceChildren")
  local raceData = Utils.CacheOrRetrieve(payload.raceGuid, "Race")

  for _, entry in pairs(payload.children) do
    if raceData[entry.Type] == nil then
      raceData[entry.Type] = { entry.Value }
    else
      if not Utils.IsInTable(raceData[entry.Type], entry.Value) then
        Utils.AddToTable(raceData[entry.Type], entry.Value)
      end
    end
  end
end

function RaceChildHandler(payload)
  Utils.Info("Entering RaceChildHandler")

  AddRaceChildren(payload)
end

local function RemoveRaceChildren(payload)
  Utils.Info("Entering RemoveRaceChildren")
  local raceData = Utils.CacheOrRetrieve(payload.raceGuid, "Race")

  for _, entry in pairs(payload.children) do
    if raceData[entry.Type] ~= nil then
      if Utils.IsInTable(raceData[entry.Type], entry.Value) then
        local idx = Utils.GetKeyFromvalue(raceData[entry.Type], entry.Value)
        raceData[entry.Type][idx] = nil
      end
    end
  end
end

function RaceChildRemovalHandler(payload)
  Utils.Info("Entering RaceChildHandler")

  RemoveRaceChildren(payload)
end
