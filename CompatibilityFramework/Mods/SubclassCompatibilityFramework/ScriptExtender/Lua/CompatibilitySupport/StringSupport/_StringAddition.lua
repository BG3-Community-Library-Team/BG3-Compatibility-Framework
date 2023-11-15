local function AddString(payload)
  Utils.Info("Entering AddString")
  Utils.ShipToQueue(payload, payload.Strings, "Strings", payload.Type)
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
