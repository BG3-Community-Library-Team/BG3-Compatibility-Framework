local function SetBoolean(payload)
  if Utils.IsInTable(Globals.BooleanTypes, payload.Key) then
    Utils.Info("Key is in table: " .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
    local fleshedObject = Utils.CacheOrRetrieve(payload.Target, payload.FileType)
    local queueType = Globals.ModuleTypes[payload.FileType]

    if fleshedObject ~= nil then
      Utils.BuildQueueEntry(queueType, payload.Target, "Booleans")
      Queue[queueType][payload.Target].Booleans[payload.Key] = payload.Value
    end
  else
    Utils.Error(Strings.ERROR_INVALID_BOOLEAN_TYPE .. payload.Key)
  end
end

function HandleBoolean(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleBoolean")
    SetBoolean(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
