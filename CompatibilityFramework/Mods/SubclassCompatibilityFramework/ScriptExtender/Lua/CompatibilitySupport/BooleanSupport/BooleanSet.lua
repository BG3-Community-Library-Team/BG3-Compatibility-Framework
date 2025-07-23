local function SetBoolean(payload)
  if CLUtils.IsInTable(CLGlobals.BooleanTypes, payload.Key) then
    CLUtils.Info(Strings.PREFIX .. "Key is in table: " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
    local fleshedObject = CLUtils.CacheOrRetrieve(payload.Target, payload.FileType)
    local queueType = Globals.ModuleTypes[payload.FileType]

    if fleshedObject ~= nil then
      Utils.BuildQueueEntry(queueType, payload.Target, "Booleans")
      Queue[queueType][payload.Target].Booleans[payload.Key] = payload.Value
    end
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_INVALID_BOOLEAN_TYPE .. payload.Key)
  end
end

function HandleBoolean(payload)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleBoolean")
    SetBoolean(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
