local function AddToTempTable(tempTable, arr)
  for _, item in pairs(arr) do
    if not Utils.IsInTable(tempTable, item) then
      table.insert(tempTable, item)
    end
  end
end

function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) then
    local listNode = Globals.ListNodes[payload.ListType]
    local list     = Utils.CacheOrRetrieve(payload.TargetList, payload.ListType)
    local tempList = {}
    if list[listNode] ~= nil then
      AddToTempTable(tempList, list[listNode])
      AddToTempTable(tempList, payload.ListItems)
      table.sort(tempList)
      list[listNode] = tempList
    else
      Utils.Error(payload.TargetList .. "of type " .. payload.ListType .. Strings.ERROR_LIST_NOT_FOUND)
    end
  else
    Utils.Error(Strings.ERROR_INVALID_LIST_TYPE)
  end
end

function HandleList(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleSelector")
    AddList(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
