local function AddRaceChildren(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering AddRaceChildren")
  local fleshedObject = CLUtils.CacheOrRetrieve(payload.raceGuid, "Race")
  if fleshedObject ~= nil then
    for _, child in pairs(payload.children) do
      Utils.BuildQueueEntry(Globals.ModuleTypes["Race"], payload.raceGuid, child.Type)
      CLUtils.AddToTable(Queue[Globals.ModuleTypes["Race"]][payload.raceGuid][child.Type], child.Value)
    end
  -- else
  --   CLUtils.Error(Strings.PREFIX .. Strings.ERROR_RACE_DATA_NOT_FOUND)
  end
end

function RaceChildHandler(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceChildHandler")

  AddRaceChildren(payload)
end

local function RemoveRaceChildren(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RemoveRaceChildren")
  local raceData = CLUtils.CacheOrRetrieve(payload.raceGuid, "Race")

  for _, entry in pairs(payload.children) do
    if raceData[entry.Type] ~= nil then
      if CLUtils.IsInTable(raceData[entry.Type], entry.Value) then
        local idx = CLUtils.GetKeyFromvalue(raceData[entry.Type], entry.Value)
        raceData[entry.Type][idx] = nil
      end
    end
  end
end

function RaceChildRemovalHandler(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceChildHandler")
  RemoveRaceChildren(payload)
end
