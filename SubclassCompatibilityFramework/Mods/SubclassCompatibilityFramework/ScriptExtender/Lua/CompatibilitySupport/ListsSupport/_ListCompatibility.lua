function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) then
    local listNode = Globals.ListNodes[payload.ListType]
    local list     = Utils.CacheOrRetrieveList(payload.TargetList, payload.ListType)

    if list ~= nil then
      list[listNode] = Utils.MergeTables(list[listNode], payload.ListItems)
    else
      Utils.Error(payload.TargetList .. "of type " .. payload.ListType ..  Strings.ERROR_LIST_NOT_FOUND)
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
