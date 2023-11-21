local function AddRaceChildren(payload)
  Utils.Info("Entering AddRaceChildren")
  local fleshedObject = Utils.CacheOrRetrieve(payload.raceGuid, "Race")
  if fleshedObject ~= nil then
    Utils.BuildQueueEntry(Globals.ModuleTypes["Race"], payload.Target, payload.Type)
    _D(payload.Value)
    table.insert(Queue[Globals.ModuleTypes["Race"]][payload.Target][payload.Type], payload.Value)
  else
    Utils.Error(Strings.ERROR_RACE_DATA_NOT_FOUND)
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
