local function RemoveSelector(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RemoveSelector")
  local target = payload.TargetUUID
  local type = payload.FileType or "Progression"
  if target ~= nil and CLUtils.CacheOrRetrieve(target, type) ~= nil then
    Utils.BuildQueueEntry(Globals.ModuleTypes[type], target, "Selectors_Remove", payload.Function)
    table.insert(Queue[Globals.ModuleTypes[type]][target].Selectors_Remove[payload.Function], payload.ListUUID)
    if Queue[Globals.ModuleTypes[type]][target] ~= nil and Queue[Globals.ModuleTypes[type]][target].Selectors ~= nil and Queue[Globals.ModuleTypes[type]][target].Selectors[payload.Function] then
      for key, val in pairs(Queue[Globals.ModuleTypes[type]][target].Selectors[payload.Function]) do
        local uuid = val.UUID or val.SpellUUID
        if uuid == payload.ListUUID then
          Queue[Globals.ModuleTypes[type]][target].Selectors[payload.Function][key] = nil
        end
      end
    end
  end
end

function HandleSelectorRemoval(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering HandleSelector")
  if payload ~= nil then
    if not CLUtils.IsInTable(CLGlobals.CacheTypes, payload.FileType) then
      CLUtils.Error(Strings.PREFIX .. Strings.ERROR_INVALID_TYPE)
    else
      RemoveSelector(payload)
    end
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
