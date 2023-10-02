function Utils.Stringify(obj)
  return Ext.Json.Stringify(obj)
end

function Utils.Info(message)
  if Globals.Debug == true then
    Ext.Utils.Print(Strings.INFO_TAG .. message)
  end
end

function Utils.Warn(message)
  if Globals.ShowWarnings == true then
    Ext.Utils.Print(Strings.WARNING_TAG .. message)
  end
end

function Utils.Error(message)
  Ext.Utils.Print(Strings.ERROR_TAG .. message)
end