function AddList(payload)
  Utils.Info("Entering AddList")
  if Utils.IsKeyInTable(Globals.ListTypes, payload.ListType) then
    local listNode = Globals.ListNodes[payload.ListType]
    local list = Ext.StaticData.Get(payload.TargetList, payload.ListType) -- Utils.CacheOrRetrieveList(payload.TargetList, payload.ListType)

    Ext.Utils.Print("List: " .. Utils.Stringify(Ext.Dump(list)))
    -- Ext.Utils.Print("Original List: " .. Utils.Stringify(Globals.ListCache[payload.TargetList]))
    Ext.Utils.Print("Payload Items: " .. Utils.Stringify(payload.ListItems))
    -- list[listNode] = Utils.TableMerge({Globals.ListCache[payload.TargetList].Spells, payload.ListItems})
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
