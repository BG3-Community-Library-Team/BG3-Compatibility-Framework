function Utils.Stringify(obj)
  return Ext.Json.Stringify(obj)
end

function Utils.Info(message)
  if Globals.Debug == 1 then
    Ext.Utils.Print("[INFO]: " .. message)
  end
end

function Utils.Error(message)
  Ext.Utils.Print("[Error]: " .. message)
end

function Utils.IsInTable(arr, val, giveKey)
  if arr ~= nil then
    for key, value in pairs(arr) do
      if val == value then
        return true
      end
    end
  end
  return false
end

function Utils.IsKeyInTable(arr, key)
  return arr[key] ~= nil
end

function Utils.GetKeyFromvalue(arr, val)
    if arr ~= nil then
        for key, value in pairs(arr) do
            if val == value then
                return key
            end
        end
    end
end

function Utils.AddToTable(arr, val)
  if arr ~= nil then
    table.insert(arr, val)
  end
end

-- TODO: Send this to Community Library
function Utils.IsGuid(string)
  local x = "%x"
  local t = { x:rep(8), x:rep(4), x:rep(4), x:rep(4), x:rep(12) }
  local pattern = table.concat(t, '%-')

  return string:match(pattern)
end
