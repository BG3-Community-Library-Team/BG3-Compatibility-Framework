local function AddToTempTable(tempTable, arr)
  for _, item in pairs(arr) do
    if not Utils.IsInTable(tempTable, item) then
      table.insert(tempTable, item)
    end
  end
end

function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) and payload.ListItems ~= nil then
    local list = Utils.CacheOrRetrieve(payload.TargetList, payload.ListType)
    if list ~= nil then
      if Queue.Lists[payload.ListType][payload.TargetList] == nil then
        Queue.Lists[payload.ListType][payload.TargetList] = {}
      end
      AddToTempTable(Queue.Lists[payload.ListType][payload.TargetList], payload.ListItems)
    else
      Utils.Error(Strings.ERROR_LIST_NOT_FOUND)
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
