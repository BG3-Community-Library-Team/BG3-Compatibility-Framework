function Utils.AddToLateLoaders(guid)
  table.insert(Globals.LateLoaders, CLUtils.RetrieveModHandleAndAuthor(guid))
end

function Utils.BuildLateLoaderString()
  CLUtils.Info(Strings.PREFIX .. Strings.GENERATING_LATE_LOADERS)
  local handleTable = {}
  for _, handle in pairs(Globals.LateLoaders) do
    if not CLUtils.IsInTable(handleTable, handle) then
      table.insert(handleTable, handle)
    end
  end
  return Strings.LATE_LOADER_PREFIX .. table.concat(handleTable, ", ")
end
