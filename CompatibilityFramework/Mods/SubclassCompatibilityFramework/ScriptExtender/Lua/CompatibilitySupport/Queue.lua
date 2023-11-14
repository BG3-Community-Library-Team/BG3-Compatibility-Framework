function Queue.Commit()
  Queue.CommitLists()
  Queue.CommitFeatsAndProgressions()
end

function Queue.CommitLists()
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = Utils.CacheOrRetrieve(listId, type)
      local res = Utils.StripInvalidStatData(list)
      for _, item in pairs(gameList[Globals.ListNodes[type]]) do
        if not Utils.IsInTable(res, item) then
          table.insert(res, item)
        end
      end
      gameList[Globals.ListNodes[type]] = res
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

function Queue.Commit_Strings(objectType, stringArr)
  for stringType, stringTable in pairs(stringArr) do
    local res = {}
    local count = 1

    for _, string in pairs(stringTable) do
      -- TODO
    end
  end
end

function Queue.ParseInsertSelectors(tempArr, selectorGroup, selectorFunction)
  for _, selector in pairs(selectorGroup) do
    if not Utils.IsPayloadInSelector(tempArr, selector, selectorFunction) then
      table.insert(tempArr, selector)
    end
  end
end

function Queue.Commit_Selectors(gameObject, selectors)
  for selectorFunction, selectorGroup in pairs(selectors) do
    local res = {}
    Queue.ParseInsertSelectors(res, selectorGroup, Globals.SelectorIdTypes[selectorFunction])
    Queue.ParseInsertSelectors(res, gameObject[selectorFunction], Globals.SelectorIdTypes[selectorFunction])

    gameObject[selectorFunction] = res
  end
end

function Queue.Commit_SelectorRemoval(objectType, selectors)
  for selectorFunction, selectorIds in pairs(selectors) do
    local res = {}
    local count = 1
    for _, selector in pairs(objectType[selectorFunction]) do
      local selectorUUID = ""
      if selector.SpellUUID ~= nil then
        selectorUUID = selector.SpellUUID
      else
        selectorUUID = selector.UUID
      end
      if selectorUUID ~= nil and not Utils.IsInTable(selectorIds, selectorUUID) then
        Utils.AddKeyValueToTable(res, tostring(count), selector)
      end
    end
    objectType[selectorFunction] = res
  end
end

function Queue.Commit_Booleans(objectType, booleans)
  --for _, value in pairs(progression.Booleans) do
  --_P("Key: " .. key .. " | Value: ")
  --_D(value)
  --end
end

function Queue.CommitFeatsAndProgressions()
  for _, objectType in pairs(Globals.CacheTypes) do
    for objectId, objectTable in pairs(Queue[Globals.ModuleTypes[objectType]]) do
      local gameObject = Utils.CacheOrRetrieve(objectId, objectType)
      if gameObject ~= nil then
        if objectTable.SubClasses ~= nil then
          Queue.CommitProgressions_Subclasses(gameObject, objectTable.SubClasses)
        end

        if objectTable.Selectors_Remove ~= nil then
          Queue.Commit_SelectorRemoval(gameObject, objectTable.Selectors_Remove)
        end

        if objectTable.Selectors ~= nil then
          Queue.Commit_Selectors(gameObject, objectTable.Selectors)
        end

        --if objectTable.Strings ~= nil then
        --  Queue.Commit_Strings(gameObject, objectTable.Strings)
        --end

        --if objectTable.Booleans ~= nil then
        --  Queue.Commit_Booleans(gameObject, objectTable.Booleans)
        --end
      end
    end
  end
end
