function Utils.CacheOrRetrieve(guid, type)
  if Globals.Cache ~= nil and Globals.Cache[guid] ~= nil then
    return Globals.Cache[guid]
  else
    Globals.Cache[guid] = Ext.StaticData.Get(guid, type)
    return Globals.Cache[guid]
  end
end


