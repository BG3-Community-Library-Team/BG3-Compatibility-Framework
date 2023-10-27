local function DetectStringType(type)
  Utils.Info("Entering DetectStringType")
  return Utils.IsKeyInTable(Globals.StringTypes, type)
end

local function RemoveString(payload)
  Utils.Info("Entering RemoveString")
  local targetId = payload.Target or payload.TargetProgression
  local fileType = payload.FileType or "Progression"
  local target = Utils.CacheOrRetrieve(targetId, fileType)

  local separator = Globals.FieldSeparator[payload.Type]

  if DetectStringType(payload.Type) then
    local fieldStrings = Utils.createTableFromString(target[payload.Type], separator)
    local result = {}

    for _, value in pairs(fieldStrings) do
      if not Utils.IsInTable(payload.Strings, value) then
        table.insert(result, value)
      end
    end

    target[payload.Type] = table.concat(result, separator)
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

function RemoveSpellString(payload)
  Utils.Info("Entering RemoveSpellString")
  local target = Ext.Stats.Get(payload.Target)
  local separator = ";"
  if target == nil then
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
  local fieldStrings = Utils.createTableFromString(target[payload.Type], separator)
  local result = {}

  for _, value in pairs(fieldStrings) do
    if not Utils.IsInTable(payload.SubSpells, value) then
      table.insert(result, value)
    end
  end

  target[payload.Type] = table.concat(result, separator)
  Ext.Stats.Sync(payload.Target)
end

function HandleRemoveSpellString(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleRemoveSpellString")
    RemoveSpellString(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
