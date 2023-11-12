local function RemoveSelector(payload)
  Utils.Info("Entering RemoveSelector")
  local target = payload.TargetUUID
  local type = payload.FileType or "Progression"
  if target ~= nil and Utils.CacheOrRetrieve(target, type) ~= nil then
    Utils.BuildQueueEntry(Queue[Globals.ModuleTypes[type]], target, "Selectors_Remove", payload.Function)
    table.insert(Queue[Globals.ModuleTypes[type]][target].Selectors_Remove[payload.Function], payload.ListUUID)
  else
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
end

function HandleSelectorRemoval(payload)
  Utils.Info("Entering HandleSelector")
  if payload ~= nil then
    if not Utils.IsInTable(Globals.CacheTypes, payload.FileType) then
      Utils.Error(Strings.ERROR_INVALID_TYPE)
    else
      RemoveSelector(payload)
    end
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
