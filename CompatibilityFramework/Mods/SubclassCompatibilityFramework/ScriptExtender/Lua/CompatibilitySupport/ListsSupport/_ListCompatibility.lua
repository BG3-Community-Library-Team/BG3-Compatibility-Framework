local function AddToTempTable(tempTable, arr)
  CLUtils.Info(Strings.PREFIX .. "Entering AddToTempTable")
  for _, item in pairs(arr) do
    if not CLUtils.IsInTable(tempTable, item) then
      table.insert(tempTable, item)
    end
  end
end

local function PrepareQueueTable(tempTable, listType, targetList)
  if tempTable[listType][targetList] == nil then
    tempTable[listType][targetList] = {}
  end
end

local function ValidateSourceLists(sourceUUIDs, listType)
  local valid = {}
  for _, sourceId in pairs(sourceUUIDs) do
    local sourceList = CLUtils.CacheOrRetrieve(sourceId, listType)
    if sourceList ~= nil then
      table.insert(valid, sourceId)
    else
      CLUtils.Warn(Strings.PREFIX .. Strings.WARN_SOURCE_LIST_NOT_FOUND
        .. sourceId .. " (" .. listType .. ")")
    end
  end
  return valid
end

function ListToQueue(payload, actionType)
  CLUtils.Info(Strings.PREFIX .. "Entering AddList")

  -- Validate list type
  if not CLUtils.IsKeyInTable(CLGlobals.ListTypes, payload.ListType) then
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_INVALID_LIST_TYPE)
    return
  end

  -- Must have at least one actionable field
  if payload.ListItems == nil
     and payload.InheritFrom == nil
     and payload.ExcludeFrom == nil then
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
    return
  end

  -- Validate target list exists
  local list = CLUtils.CacheOrRetrieve(payload.TargetList, payload.ListType)
  if list == nil then return end

  -- Process explicit items (existing behaviour)
  if payload.ListItems ~= nil then
    if actionType == 'Add' then
      PrepareQueueTable(Queue.Lists, payload.ListType, payload.TargetList)
      AddToTempTable(Queue.Lists[payload.ListType][payload.TargetList], payload.ListItems)
    else
      PrepareQueueTable(Queue.Lists_Remove, payload.ListType, payload.TargetList)
      AddToTempTable(Queue.Lists_Remove[payload.ListType][payload.TargetList], payload.ListItems)
    end
  end

  -- Process InheritFrom — only valid on 'Add' action
  if payload.InheritFrom ~= nil then
    if actionType == 'Add' then
      local validSources = ValidateSourceLists(payload.InheritFrom, payload.ListType)
      if #validSources > 0 then
        PrepareQueueTable(Queue.Lists_Inherit, payload.ListType, payload.TargetList)
        AddToTempTable(Queue.Lists_Inherit[payload.ListType][payload.TargetList], validSources)
      end
    else
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
        .. Strings.WARN_INHERIT_WRONG_ACTION .. payload.TargetList
        .. ". InheritFrom is only valid on Add/Insert actions. Ignoring.")
    end
  end

  -- Process ExcludeFrom — only valid on 'Remove' action
  if payload.ExcludeFrom ~= nil then
    if actionType == 'Remove' then
      local validSources = ValidateSourceLists(payload.ExcludeFrom, payload.ListType)
      if #validSources > 0 then
        PrepareQueueTable(Queue.Lists_Exclude, payload.ListType, payload.TargetList)
        AddToTempTable(Queue.Lists_Exclude[payload.ListType][payload.TargetList], validSources)
      end
    else
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
        .. Strings.WARN_EXCLUDE_WRONG_ACTION .. payload.TargetList
        .. ". ExcludeFrom is only valid on Remove actions. Ignoring.")
    end
  end
end

function HandleList(payload, actionType)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleList")
    ListToQueue(payload, actionType)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
