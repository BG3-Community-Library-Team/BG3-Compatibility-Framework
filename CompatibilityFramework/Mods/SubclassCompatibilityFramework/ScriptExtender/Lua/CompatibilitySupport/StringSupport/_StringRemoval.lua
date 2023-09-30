local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.ProgressionStringTypes, type)
end

local function RemoveString(payload)
  Utils.Info("Entering RemoveString")
  target = payload.Target or payload.TargetProgression
  fileType = payload.FileType or "Progression"

  if DetectStringType(payload.Type) then
    local field = Utils.CacheOrRetrieve(payload.TargetProgression, fileType)[payload.Type]
    local fieldStrings = Utils.createTableFromString(field)
    local result = {}

    for _, value in pairs(payload.Strings) do
      if not Utils.IsInTable(fieldStrings, value) then
        table.insert(result, value)
      end
    end

    field = table.concat(result)
  else
    Utils.Error(Strings.ERROR_INVALID_PROGRESSION_TYPE)
  end
end

function HandleRemoveString(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleRemoveString")
    RemoveString(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
