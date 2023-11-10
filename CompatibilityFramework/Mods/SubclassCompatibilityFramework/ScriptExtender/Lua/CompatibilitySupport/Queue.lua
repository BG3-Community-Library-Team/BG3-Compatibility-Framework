function Queue.Commit()
  Queue.CommitLists()
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

function Queue.CommitLists()
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = Utils.CacheOrRetrieve(listId, type)
      local strippedList = StripInvalidStatData(list)

      gameList[Globals.ListNodes[type]] = strippedList
    end
  end
end

function Queue.CommitProgressions()
  -- for key, progression in pairs(Queue.Progressions) do
    -- TODO
    --end
  return
end