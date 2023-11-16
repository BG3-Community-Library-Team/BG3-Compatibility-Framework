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

function Utils.StripInvalidStaticData(arr, type)
  for key, value in pairs(arr) do
    if not Utils.IsGuid(value) then
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
    Utils.AddToTable(sortList, { Utils.RetrieveHandle(val, type, handle), val })
  end

  table.sort(sortList, Utils.SimpleCompare)

  for _, val in ipairs(sortList) do
    if not Utils.IsInTable(res, val[2]) then
      Utils.AddToTable(res, val[2])
    end
  end

  return res
end

function Utils.IsPayloadInSelector(selectorField, selectorToInsert, idType)
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
      if not Utils.IsInString(field, value) and not Utils.IsInTable(res, value) then
        table.insert(res, value)
      end
    end
  end

  return res
end

function Utils.ShipToQueue(payload, items, itemsType, itemsSubType)
  Utils.Info("Entering ShipToQueue for " .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
  local type = payload.FileType or payload.Type or "Progression"
  local target = payload.Target or payload.TargetProgression

  if Utils.IsKeyInTable(Globals.ModuleTypes, type) and items ~= nil then
    Utils.Info("Key is in table: " .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
    local queueType = Globals.ModuleTypes[type]
    _D(target)
    _D(type)
    local fleshedObject = Utils.CacheOrRetrieve(target, type)
    _D(fleshedObject)
    if fleshedObject ~= nil then
      Utils.Info("Fleshed Object Exists: " .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
      Utils.BuildQueueEntry(queueType, target, itemsType, itemsSubType)
      table.insert(Queue[queueType][target][itemsType][itemsSubType], items)
    else
      Utils.Error(Strings.ERROR_TARGET_NOT_FOUND ..
        " " .. type .. ": " .. target .. Strings.FRAG_PROVIDED_BY .. Utils.RetrieveModHandleAndAuthor(payload.modGuid))
    end
  end
end
