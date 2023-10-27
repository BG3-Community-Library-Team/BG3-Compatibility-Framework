local function SetBoolean(payload)
  if Utils.IsInTable(Globals.BooleanTypes, payload.Key) then
    local target = Utils.CacheOrRetrieve(payload.Target, payload.FileType)
    if target == nil then
      Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
    end
    target[payload.Key] = payload.Value
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