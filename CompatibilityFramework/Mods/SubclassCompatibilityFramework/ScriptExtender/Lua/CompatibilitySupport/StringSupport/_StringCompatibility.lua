local function StringHandler(payload, type)
  Utils.Info("Entering StringHandler")
  Utils.ShipToQueue(payload, payload.Strings, type, payload.Type)

  if type == "Strings_Remove" then
    for key, val in pairs(Queue[Globals.ModuleTypes[payload.FileType]][payload.Target][payload.Type]) do
      if Utils.IsInTable(payload.Strings, val) then
        Queue[Globals.ModuleTypes[payload.FileType]][payload.Target][payload.Type][key] = nil
      end
    end
  end
end

function HandleString(payload, type)
  if payload ~= nil then
    Utils.Info("Entering HandleString")
    StringHandler(payload, type)
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

function RemoveSpellString(payload)
  Utils.Info("Entering RemoveSpellString")
  local target = Ext.Stats.Get(payload.Target)
  local separator = ";"
  if target ~= nil then
    local fieldStrings = Utils.createTableFromString(target[payload.Type], separator)
    local result = {}

    for _, value in pairs(fieldStrings) do
      if not Utils.IsInTable(payload.SubSpells, value) then
        table.insert(result, value)
      end
    end

    target[payload.Type] = table.concat(result, separator)
    Ext.Stats.Sync(payload.Target)
  else
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
end

function HandleRemoveSpellString(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleRemoveSpellString")
    RemoveSpellString(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
