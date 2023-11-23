function Utils.RetrieveModHandleAndAuthor(guid)
Utils.Info("Entering Utils.RetrieveModHandleAndAuthor")
  if guid and Ext.Mod.IsModLoaded(guid) then
    local mod = Ext.Mod.GetMod(guid)
    return mod.Info.Name .. " (" .. mod.Info.Author .. ")"
  else
    return guid
  end
end

function Utils.AddToLateLoaders(guid)
  table.insert(Globals.LateLoaders, Utils.RetrieveModHandleAndAuthor(guid))
end

function Utils.BuildLateLoaderString()
  Utils.Info("Building Late Loader String")
  local handleTable = {}
  for _, handle in pairs(Globals.LateLoaders) do
    if not Utils.IsInTable(handleTable, handle) then
      table.insert(handleTable, handle)
    end
  end
  return Strings.LATE_LOADER_PREFIX .. table.concat(handleTable, ", ")
end
