function Queue.Commit()
  Queue.CommitLists()
  Queue.CommitProgressions()
end

function Queue.CommitLists()
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = Utils.CacheOrRetrieve(listId, type)
      local strippedList = Utils.StripInvalidStatData(list)

      gameList[Globals.ListNodes[type]] = strippedList
    end
  end
end

function Queue.CommitProgressions_Subclasses(progression, subclasses)
  local strippedList = Utils.StripInvalidStaticData(subclasses, "ClassDescription")
  for _, vanillaEntry in pairs(progression.SubClasses) do
    Utils.AddToTable(strippedList, vanillaEntry)
  end

  progression.SubClasses = Utils.SortStaticData(strippedList, "ClassDescription", "DisplayName")
end

function Queue.CommitProgressions_Strings(progression, stringArr)
  --for _, value in pairs(progression.Strings) do
  --_P("Key: " .. key .. " | Value: ")
  --_D(value)
  --end
end

function Queue.CommitProgressions_Selectors(progression, selectors)
  for selectorFunction, selectorGroup in pairs(selectors) do
    local res = {}
    local count = 1

    for _, selector in pairs(selectorGroup) do
      if not Utils.IsPayloadInSelector(res, selector, Globals.SelectorIdTypes[selectorFunction]) then
        Utils.AddKeyValueToTable(res, tostring(count), selector)
        count = count + 1
      end
    end

    for _, val in pairs(progression[selectorFunction]) do
      if not Utils.IsPayloadInSelector(res, val, Globals.SelectorIdTypes[selectorFunction]) then
        Utils.AddKeyValueToTable(res, tostring(count), val)
        count = count + 1
      end
    end
    progression[selectorFunction] = res
  end
end

function Queue.CommitProgressions_Booleans(progression, booleans)
  --for _, value in pairs(progression.Booleans) do
  --_P("Key: " .. key .. " | Value: ")
  --_D(value)
  --end
end

function Queue.CommitProgressions()
  for progressionId, progressionTable in pairs(Queue.Progressions) do
    local progression = Utils.CacheOrRetrieve(progressionId, "Progression")
    if progression ~= nil then
      if progressionTable.SubClasses ~= nil then
        Queue.CommitProgressions_Subclasses(progression, progressionTable.SubClasses)
      end

      if progressionTable.Selectors ~= nil then
        Queue.CommitProgressions_Selectors(progression, progressionTable.Selectors)
      end

      if progressionTable.Strings ~= nil then
        Queue.CommitProgressions_Strings(progression, progressionTable.Strings)
      end

      if progressionTable.Booleans ~= nil then
        Queue.CommitProgressions_Booleans(progression, progressionTable.Booleans)
      end
    end
  end
end
