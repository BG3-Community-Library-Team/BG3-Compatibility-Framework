local function RemoveSelector(payload)
  Utils.Info("Entering RemoveSelector")
  local target = payload.TargetUUID
  local type = payload.FileType or "Progression"
  if target ~= nil and Utils.CacheOrRetrieve(target, type) ~= nil then
    Utils.BuildQueueEntry(Globals.ModuleTypes[type], target, "Selectors_Remove", payload.Function)
    table.insert(Queue[Globals.ModuleTypes[type]][target].Selectors_Remove[payload.Function], payload.ListUUID)
    if Queue[Globals.ModuleTypes[type]][target] ~= nil then
      for key, val in pairs(Queue[Globals.ModuleTypes[type]][target].Selectors[payload.Function]) do
        local uuid = val.UUID or val.SpellUUID
        if uuid == payload.ListUUID then
          Queue[Globals.ModuleTypes[type]][target].Selectors[payload.Function][key] = nil
        end
      end
    end
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
