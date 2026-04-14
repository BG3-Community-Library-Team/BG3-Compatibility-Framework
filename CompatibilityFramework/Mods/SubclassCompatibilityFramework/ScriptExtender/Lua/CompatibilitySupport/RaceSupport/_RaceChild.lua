local function AddRaceChildren(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering AddRaceChildren")

  if payload.raceGuid == "ALL" then
    CLUtils.Info(Strings.PREFIX .. "ApplyToAllRaces: queuing children for all races")
    for _, child in pairs(payload.children) do
      Utils.BuildQueueEntry(Globals.ModuleTypes["Race"], "ALL", child.Type)
      CLUtils.AddToTable(Queue[Globals.ModuleTypes["Race"]]["ALL"][child.Type], child.Value)
    end
  else
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
end

function RaceChildHandler(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceChildHandler")

  AddRaceChildren(payload)
end

local function RemoveRaceChildren(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RemoveRaceChildren")
  CLUtils.Warn(payload.raceGuid)
  if payload.raceGuid == "ALL" then
    CLUtils.Info(Strings.PREFIX .. "ApplyToAllRaces: queuing removal for all races")
    Queue.Races_Remove["ALL"] = Queue.Races_Remove["ALL"] or {}
    for _, entry in pairs(payload.children) do
      Queue.Races_Remove["ALL"][entry.Type] = Queue.Races_Remove["ALL"][entry.Type] or {}
      CLUtils.AddToTable(Queue.Races_Remove["ALL"][entry.Type], entry.Value)
    end
  else
    if payload.raceGuid == nil then
      CLUtils.Warn(Strings.PREFIX .. "RemoveRaceChildren: payload has no raceGuid, skipping")
      return
    end
    Queue.Races_Remove[payload.raceGuid] = Queue.Races_Remove[payload.raceGuid] or {}
    for _, entry in pairs(payload.children) do
      Queue.Races_Remove[payload.raceGuid][entry.Type] = Queue.Races_Remove[payload.raceGuid][entry.Type] or {}
      CLUtils.AddToTable(Queue.Races_Remove[payload.raceGuid][entry.Type], entry.Value)
    end
  end
end

function RaceChildRemovalHandler(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceChildHandler")
  RemoveRaceChildren(payload)
end
