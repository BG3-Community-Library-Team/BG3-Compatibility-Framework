function Utils.createTableFromString(str, separator)
  local result = {}

  for value in str:gmatch("([^" .. separator .. "]+),?") do
    table.insert(result, value)
  end
  return result
end

function Utils.IsInTable_Nested(arr, str)
  local returnValue = arr
  for key in string.gmatch(str, "[^.]+") do
    if returnValue[key] then
      returnValue = returnValue[key]
    else
      return nil
    end
  end

  return returnValue
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

function Utils.Traverse(item, filterFn, doFn)
  if filterFn(item) then
    doFn(item)
  else
    if type(item) == "table" then
      for _, value in pairs(item) do
        Utils.Traverse(value, filterFn, doFn)
      end
    end
  end
end
