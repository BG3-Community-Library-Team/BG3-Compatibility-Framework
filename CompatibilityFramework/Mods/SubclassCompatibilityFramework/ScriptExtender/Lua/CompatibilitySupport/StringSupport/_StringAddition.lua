local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.StringTypes, type)
end

local function stripDuplicates(field, strings)
  local strippedStrings = {}
  for _, value in pairs(strings) do
    if not Utils.IsInString(field, value) and not Utils.IsInTable(field, strippedStrings) then
      table.insert(strippedStrings, value)
    end
  end

  return strippedStrings
end

local function AddString(payload)
  Utils.Info("Entering AddString")
  local target = payload.Target or payload.TargetProgression
  local fileType = payload.FileType or "Progression"

  if DetectStringType(payload.Type) then
    local field = Utils.CacheOrRetrieve(target, fileType)[payload.Type]
    local stringsToInsert = stripDuplicates(field, payload.Strings)
    table.insert(field, table.concat(stringsToInsert, ';'))
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
