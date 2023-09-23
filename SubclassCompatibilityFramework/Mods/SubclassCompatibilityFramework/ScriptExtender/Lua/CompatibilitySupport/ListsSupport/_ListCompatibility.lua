function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) then
    local list = Utils.CacheOrRetrieveList(payload.TargetList, payload.ListType)
    Utils.Info(Utils.Stringify(list))

    Utils.AddToTable(payload.ListItems, list[Globals.ListNodes[payload.ListType]])
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
