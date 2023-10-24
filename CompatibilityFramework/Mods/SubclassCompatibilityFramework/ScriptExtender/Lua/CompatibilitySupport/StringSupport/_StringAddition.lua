local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.StringTypes, type)
end

local function stripDuplicates(field, strings)
  local strippedStrings = {}
  for _, value in pairs(strings) do
    if not Utils.IsInString(field, value) and not Utils.IsInTable(strippedStrings, value) then
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
    local target = Utils.CacheOrRetrieve(target, fileType)
    local stringsToInsert = stripDuplicates(target[payload.Type], payload.Strings)
    local separator = Globals.FieldSeparator[payload.Type]

    target[payload.Type] = target[payload.Type] .. separator .. table.concat(stringsToInsert, separator)
    _D(target[payload.Type])
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
