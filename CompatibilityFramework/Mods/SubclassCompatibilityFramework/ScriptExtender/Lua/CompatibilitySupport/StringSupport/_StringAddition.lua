local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.StringTypes, type)
end

local function stripDuplicates(field, strings)
  local strippedStrings = {}
  for _, value in pairs(strings) do
    if string.find(field, value) then
    else
      if string.find(table.concat(strippedStrings, " "), value) then
      else
        table.insert(strippedStrings, value)
      end
    end
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
  if target == nil then
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
  if DetectStringType(payload.Type) then
    local target = Utils.CacheOrRetrieve(target, fileType)
    local stringsToInsert = stripDuplicates(target[payload.Type], payload.Strings)
    local separator = Globals.FieldSeparator[payload.Type]
    local newStringField = target[payload.Type] .. separator .. table.concat(stringsToInsert, separator)
    if string.sub(newStringField, -1) == ";" then
      newStringField = newStringField:sub(1, #newStringField - 1)
    end

    target[payload.Type] = newStringField
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

local function AddSpellString(payload)
  Utils.Info("Entering AddSpellString")
  local target = Ext.Stats.Get(payload.Target)
  local separator = ";"

  local baseSpells = Utils.createTableFromString(target[payload.Type], separator)
  for _, spell in pairs(payload.SubSpells) do
    table.insert(baseSpells, spell)
  end

  table.sort(baseSpells)

  target[payload.Type] = table.concat(baseSpells, separator)
  Ext.Stats.Sync(payload.Target)
end

function HandleSpellString(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleSpellString")
    AddSpellString(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
