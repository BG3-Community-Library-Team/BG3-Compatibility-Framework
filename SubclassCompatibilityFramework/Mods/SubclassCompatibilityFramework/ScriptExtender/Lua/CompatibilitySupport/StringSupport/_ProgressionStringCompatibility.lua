local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.ProgressionStringTypes, type)
end

local function AddString(payload)
  Utils.Info("Entering AddString")
  if DetectStringType(payload.Type) then
    local field = Utils.CacheOrRetrieveProgression(payload.TargetProgression)[payload.Type]

    table.insert(field, table.concat(payload.Strings, ';'))
  else
    Utils.Error(Strings.ERROR_INVALID_PROGRESSION_TYPE)
  end
end

function HandleProgressionString(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleProgressionString")
    AddString(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end