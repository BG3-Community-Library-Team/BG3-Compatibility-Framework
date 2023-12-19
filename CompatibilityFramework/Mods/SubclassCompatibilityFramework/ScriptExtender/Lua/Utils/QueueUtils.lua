function Utils.BuildQueueEntry(moduleType, targetUUID, fieldType, tertiaryType)
  if Queue[moduleType][targetUUID] == nil then
    Queue[moduleType][targetUUID] = {}
  end

  if Queue[moduleType][targetUUID][fieldType] == nil then
    Queue[moduleType][targetUUID][fieldType] = {}
  end
  if tertiaryType ~= nil and Queue[moduleType][targetUUID][fieldType][tertiaryType] == nil then
    Queue[moduleType][targetUUID][fieldType][tertiaryType] = {}
  end
end

-- TODO: Consider shifting to CL
function Utils.StripInvalidStatData(arr)
  for key, value in pairs(arr) do
    if value == '' or value == ' ' then
      arr[key] = nil
    elseif Ext.Stats.Get(value, nil, false) == nil then
      arr[key] = nil
    end
  end

  return arr
end

-- TODO: Consider shifting to CL
function Utils.StripInvalidStaticData(arr, type)
  for key, value in pairs(arr) do
    if not CLUtils.IsGuid(value) then
      arr[key] = nil
    elseif not Ext.StaticData.Get(value, type) then
      arr[key] = nil
    end
  end

  return arr
end

function Utils.SortStaticData(arr, type, handle)
  local sortList = {}
  local res = {}
  for _, val in pairs(arr) do
    CLUtils.AddToTable(sortList, { CLUtils.RetrieveHandle_StaticData(val, type, handle), val })
  end

  table.sort(sortList, CLUtils.SimpleCompare)

  for _, val in ipairs(sortList) do
    if not CLUtils.IsInTable(res, val[2]) then
      CLUtils.AddToTable(res, val[2])
    end
  end

  return res
end

function Utils.IsPayloadInSelector(selectorField, selectorToInsert, idType)
  CLUtils.Info("Entering IsPayloadInSelector")
  local found = false

  local newSelectorID = selectorToInsert[idType]
  for _, value in pairs(selectorField) do
    local valID = value[idType]
    if valID == newSelectorID then
      found = true
    end
  end
  return found
end

function Utils.ManageDuplicates(field, strings)
  local res = {}
  for _, stringArr in pairs(strings) do
    for _, value in pairs(stringArr) do
      if not string.find(field, value) then
        if not string.find(table.concat(res, " "), value) then
          table.insert(res, value)
        end
      end
      if not CLUtils.IsInString(field, value) and not CLUtils.IsInTable(res, value) then
        table.insert(res, value)
      end
    end
  end

  return res
end

function Utils.stringTypeArrToSet(stringTypeArr)
  local set = {}
  local result = {}
  for _, currentArray in pairs(stringTypeArr) do
    for _, currentString in pairs(currentArray) do
      if not set[currentString] then
        set[currentString] = true
        table.insert(result, currentString)
      end
    end
  end

  return set, result
end

function Utils.ShipToQueue(payload, items, itemsType, itemsSubType)
  CLUtils.Info("Entering ShipToQueue for " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
  local type = payload.FileType or payload.Type or "Progression"
  local target = payload.Target or payload.TargetProgression

  if CLUtils.IsKeyInTable(Globals.ModuleTypes, type) and items ~= nil then
    CLUtils.Info(CLStrings.FRAG_KEY_IS_IN_TABLE .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
    local queueType = Globals.ModuleTypes[type]
    local fleshedObject = CLUtils.CacheOrRetrieve(target, type)
    if fleshedObject ~= nil then
      CLUtils.Info(CLStrings.FRAG_FLESHED_OBJECT_EXISTS .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
      Utils.BuildQueueEntry(queueType, target, itemsType, itemsSubType)
      table.insert(Queue[queueType][target][itemsType][itemsSubType], items)
    else
      CLUtils.Error(CLStrings.ERROR_TARGET_NOT_FOUND ..
        " " .. type .. ": " .. target .. CLStrings.FRAG_PROVIDED_BY .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
    end
  end
end
