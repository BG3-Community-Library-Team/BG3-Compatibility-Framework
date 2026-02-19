
local function SetField(payload)

  if CLUtils.IsInTable(CLGlobals.FieldTypes, payload.Key) then
    CLUtils.Info(Strings.PREFIX .. "Key is in table: " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
    local fleshedObject = CLUtils.CacheOrRetrieve(payload.Target, payload.FileType)
    local queueType = Globals.ModuleTypes[payload.FileType]

    if fleshedObject ~= nil then
      Utils.BuildQueueEntry(queueType, payload.Target, "Fields")
      Queue[queueType][payload.Target].Fields[payload.Key] = payload.Value
    end
  else
    CLUtils.Warn(Strings.PREFIX .. "Field type not validated: " .. payload.Key)
  end
end

function HandleField(payload)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleField")
    SetField(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
