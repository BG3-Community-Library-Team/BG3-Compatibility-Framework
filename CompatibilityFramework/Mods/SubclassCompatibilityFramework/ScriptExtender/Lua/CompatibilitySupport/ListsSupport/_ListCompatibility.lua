local function AddToTempTable(tempTable, arr)
  for _, item in pairs(arr) do
    if not CLUtils.IsInTable(tempTable, item) then
      table.insert(tempTable, item)
    end
  end
end

function AddList(payload)
  CLUtils.Info("Entering AddList")
  if CLUtils.IsKeyInTable(CLGlobals.ListTypes, payload.ListType) and payload.ListItems ~= nil then
    local list = CLUtils.CacheOrRetrieve(payload.TargetList, payload.ListType)
    if list ~= nil then
      if Queue.Lists[payload.ListType][payload.TargetList] == nil then
        Queue.Lists[payload.ListType][payload.TargetList] = {}
      end
      AddToTempTable(Queue.Lists[payload.ListType][payload.TargetList], payload.ListItems)
    else
      CLUtils.Error(CLStrings.ERROR_LIST_NOT_FOUND)
    end
  else
    CLUtils.Error(CLStrings.ERROR_INVALID_LIST_TYPE)
  end
end

function HandleList(payload)
  if payload ~= nil then
    CLUtils.Info("Entering HandleList")
    AddList(payload)
  else
    CLUtils.Error(CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
