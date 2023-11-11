function Queue.Commit()
  Queue.CommitLists()
  Queue.CommitProgressions()
end

local function StripInvalidStatData(arr)
  for key, value in pairs(arr) do
    if value == '' or value == ' ' then
      arr[key] = nil
    elseif Ext.Stats.Get(value, nil, false) == nil then
      arr[key] = nil
    end
  end

  return arr
end

function StripInvalidStaticData(arr, type)
  for key, value in pairs(arr) do
    if not Utils.IsGuid(value) then
      arr[key] = nil
    elseif not Ext.StaticData.Get(value, type) then
      arr[key] = nil
    end
  end

  return arr
end

function SortStaticData(arr, type, handle)
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

function Queue.CommitLists()
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = Utils.CacheOrRetrieve(listId, type)
      local strippedList = StripInvalidStatData(list)

      gameList[Globals.ListNodes[type]] = strippedList
    end
  end
end

function Queue.CommitProgressions_Subclasses(progression, subclasses)
  local strippedList = StripInvalidStaticData(subclasses, "ClassDescription")
  for _, vanillaEntry in pairs(progression.SubClasses) do
    Utils.AddToTable(strippedList, vanillaEntry)
  end

  progression.SubClasses = SortStaticData(strippedList, "ClassDescription", "DisplayName")
end

function Queue.CommitProgressions_Strings(progression, stringArr)

end

function Queue.CommitProgressions_Selectors(progression, selectors)

end

function Queue.CommitProgressions()
  for progressionId, progressionTable in pairs(Queue.Progressions) do
    local progression = Utils.CacheOrRetrieve(progressionId, "Progression")
    if progression ~= nil then
      if progressionTable.SubClasses ~= nil then
        Queue.CommitProgressions_Subclasses(progression, progressionTable.SubClasses)
      end
    end
  end
end
