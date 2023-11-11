function Utils.StripInvalidStatData(arr)
  for key, value in pairs(arr) do
    if value == '' or value == ' ' then
      arr[key] = nil
    elseif Ext.Stats.Get(value, nil, false) == nil then
      arr[key] = nil
    end
  end

  return arr
end

function Utils.StripInvalidStaticData(arr, type)
  for key, value in pairs(arr) do
    if not Utils.IsGuid(value) then
      arr[key] = nil
    elseif not Ext.StaticData.Get(value, type) then
      arr[key] = nil
    end
  end

  return arr
end

function Utils.SortStaticData(arr, type, handle)
  local sortList = {}
  local res = {}
  for _, val in pairs(arr) do
    Utils.AddToTable(sortList, { Utils.RetrieveHandle(val, type, handle), val })
  end

  table.sort(sortList, Utils.SimpleCompare)

  for _, val in ipairs(sortList) do
    if not Utils.IsInTable(res, val[2]) then
      Utils.AddToTable(res, val[2])
    end
  end

  return res
end