local function AddToTempTable(tempTable, arr)
  CLUtils.Info("Entering AddToTempTable")
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

function ListToQueue(payload, actionType)
  CLUtils.Info("Entering AddList")
  if CLUtils.IsKeyInTable(CLGlobals.ListTypes, payload.ListType) and payload.ListItems ~= nil then
    local list = CLUtils.CacheOrRetrieve(payload.TargetList, payload.ListType)
    if list ~= nil then
      if actionType == 'Add' then
        PrepareQueueTable(Queue.Lists, payload.ListType, payload.TargetList)
        AddToTempTable(Queue.Lists[payload.ListType][payload.TargetList], payload.ListItems)
      else
        PrepareQueueTable(Queue.Lists_Remove, payload.ListType, payload.TargetList)
        AddToTempTable(Queue.Lists_Remove[payload.ListType][payload.TargetList], payload.ListItems)
      end
    else
      CLUtils.Error(CLStrings.ERROR_LIST_NOT_FOUND)
    end
  else
    CLUtils.Error(CLStrings.ERROR_INVALID_LIST_TYPE)
  end
end

function HandleList(payload, actionType)
  if payload ~= nil then
    CLUtils.Info("Entering HandleList")
    ListToQueue(payload, actionType)
  else
    CLUtils.Error(CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
