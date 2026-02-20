
local function SetField(payload)

  local fleshedObject = CLUtils.CacheOrRetrieve(payload.Target, payload.FileType)
  local queueType = Globals.ModuleTypes[payload.FileType]

  if fleshedObject ~= nil then
    Utils.BuildQueueEntry(queueType, payload.Target, "Fields")
    Queue[queueType][payload.Target].Fields[payload.Key] = payload.Value
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
