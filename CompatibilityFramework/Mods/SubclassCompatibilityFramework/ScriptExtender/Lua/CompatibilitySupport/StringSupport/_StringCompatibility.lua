local function StringHandler(payload, addRemove)
  CLUtils.Info(Strings.PREFIX .. "Entering StringHandler")

  local queueType = Globals.ModuleTypes[payload.FileType or "Progression"]
  local target = payload.Target
  local stringType = payload.Type

  Utils.BuildQueueEntry(queueType, target, addRemove, stringType)
  local queueItem = Queue[queueType][target][addRemove][stringType]

  for _, v in pairs(payload.Strings) do
    queueItem[v] = true
  end

  if addRemove == "Strings_Remove" then
    if Queue[queueType][target].Strings then
      local addStrings = queueItem[stringType]
      if addStrings then
        for _, v in pairs(payload.Strings) do
          if addStrings[v] then addStrings[v] = nil end
        end
      end
    end
  end
end

function HandleString(payload, type)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleString")
    StringHandler(payload, type)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end

local function AddSpellString(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering AddSpellString")
  local target = Ext.Stats.Get(payload.Target)
  local baseSpells = {}
  if type(target[payload.Type]) == "table" then
    for _, value in pairs(target[payload.Type]) do
      table.insert(baseSpells, value)
    end
  else
    table.insert(baseSpells, target[payload.Type])
  end
  for _, spell in pairs(payload.SubSpells) do
    table.insert(baseSpells, spell)
  end

  target[payload.Type] = table.concat(baseSpells, ";")
end

function HandleSpellString(payload)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleSpellString")
    AddSpellString(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end

function RemoveSpellString(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering RemoveSpellString")
  local target = Ext.Stats.Get(payload.Target)

  if target ~= nil then
    local fieldStrings = {}
    local result = {}

    for _, value in pairs(target[payload.Type]) do
      table.insert(fieldStrings, value)
    end

    for _, value in pairs(fieldStrings) do
      if not CLUtils.IsInTable(payload.SubSpells, value) then
        table.insert(result, value)
      end
    end

    target[payload.Type] = result
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_TARGET_NOT_FOUND)
  end
end

function HandleRemoveSpellString(payload)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleRemoveSpellString")
    RemoveSpellString(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
