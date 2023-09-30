function Utils.CacheOrRetrieve(guid, type)
  if Globals.Cache ~= nil and Globals.Cache[guid] ~= nil then
    return Globals.Cache[guid]
  else
    Globals.Cache[guid] = Ext.StaticData.Get(guid, type)
    return Globals.Cache[guid]
  end
end

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

function Utils.IsInString(str, value)
  return str.find(value)
end

function Utils.IsInTable(arr, val)
  if arr ~= nil then
    for _, value in pairs(arr) do
      if val == value then
        return true
      end
    end
  end
  return false
end

function Utils.IsKeyInTable(arr, key)
  if arr ~= nil then
    return arr[key] ~= nil
  end
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

function Utils.AddKeyValueToTable(arr, key, value)
  if arr ~= nil then
    arr[key] = value
  end
end

function Utils.GetTableSize(arr)
  local count = 0
  for _, val in pairs(arr) do
    count = count + 1
  end

  return count
end

function Utils.InsertFromTableToTable(arr, resultArr, count)
  for _, value in pairs(arr) do
    if not Utils.IsInTable(resultArr, value) then
      resultArr[count] = value
      count = count + 1
    end
  end
  return resultArr, count
end

function Utils.MergeTables(arrA, arrB)
  local result = {}
  local count = 0

  if arrA ~= nil and arrB ~= nil then
    result, count = Utils.InsertFromTableToTable(arrA, result, count)
    result, count = Utils.InsertFromTableToTable(arrB, result, count)
  end

  return result
end

-- TODO: Send this to Community Library
function Utils.IsGuid(string)
  local x = "%x"
  local t = { x:rep(8), x:rep(4), x:rep(4), x:rep(4), x:rep(12) }
  local pattern = table.concat(t, '%-')

  return string:match(pattern)
end
