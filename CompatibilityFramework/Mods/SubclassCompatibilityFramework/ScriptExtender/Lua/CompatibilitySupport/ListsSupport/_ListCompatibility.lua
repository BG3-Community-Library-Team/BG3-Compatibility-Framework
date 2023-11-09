local function SpellSort(items, arr)
  local spellsToSort = arr or {}
  for _, item in pairs(items) do
    local spellLevel = 0
    local spellName = item
    if Ext.Stats.Get(item) ~= nil then
      if Ext.Stats.Get(item).Level ~= nil then spellLevel = Ext.Stats.Get(item).Level end
      if Utils.RetrieveHandle_Stats(Ext.Stats.Get(item).DisplayName) ~= nil then
        spellName = Utils.RetrieveHandle_Stats(
          Ext.Stats.Get(item).DisplayName)
      end
      if spellsToSort[spellLevel] == nil then spellsToSort[spellLevel] = {} end
      table.insert(spellsToSort[spellLevel], { spellName, item })
    else
      Utils.Warn(Strings.WARN_INVALID_SPELLDATA_SUPPLIED .. item)
    end
  end
  return spellsToSort
end

local function DoSort(arr)
  local realArr = {}
  for _, element in ipairs(arr) do
    table.sort(element, Utils.SimpleCompare)
    for _, value in ipairs(element) do
      table.insert(realArr, value[2])
    end
  end
  return realArr
end

function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) and payload.ListItems ~= nil then
    local listNode = Globals.ListNodes[payload.ListType]
    local list     = Utils.CacheOrRetrieve(payload.TargetList, payload.ListType)
    if list == nil then
      Utils.Error(Strings.ERROR_LIST_NOT_FOUND)
    end

    if list[listNode] ~= nil then
      local sortTable = SpellSort(list[listNode])
      sortTable = SpellSort(payload.ListItems, sortTable)
      list[listNode] = DoSort(sortTable)
    else
      Utils.Error(payload.TargetList .. "of type " .. payload.ListType .. Strings.ERROR_LIST_NOT_FOUND)
    end
  else
    Utils.Error(Strings.ERROR_INVALID_LIST_TYPE)
  end
end

function HandleList(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleList")
    AddList(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
