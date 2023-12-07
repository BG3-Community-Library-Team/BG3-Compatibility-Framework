function Queue.Commit()
  CLUtils.Info("Entering Queue.Commit")
  Queue.CommitLists()
  Queue.CommitFeatsAndProgressions()
  Queue.CommitRaces()
  --Queue.CommitSpellData()
end

function Queue.CommitLists()
  CLUtils.Info("Entering Queue.CommitLists")
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = CLUtils.CacheOrRetrieve(listId, type)
      for _, item in pairs(gameList[CLGlobals.ListNodes[type]]) do
        if not CLUtils.IsInTable(list, item) then
          table.insert(list, item)
        end
      end
      local res = Utils.StripInvalidStatData(list)
      gameList[CLGlobals.ListNodes[type]] = res
    end
  end
end

function Queue.CommitProgressions_Subclasses(progression, subclasses)
  CLUtils.Info("Entering Queue.CommitProgressions_Subclasses")
  local strippedList = Utils.StripInvalidStaticData(subclasses, "ClassDescription")
  for _, vanillaEntry in pairs(progression.SubClasses) do
    CLUtils.AddToTable(strippedList, vanillaEntry)
  end

  progression.SubClasses = Utils.SortStaticData(strippedList, "ClassDescription", "DisplayName")
end

function Queue.Commit_Strings(gameObject, stringArr)
  CLUtils.Info("Entering Queue.Commit_Strings")

  for stringType, addSet in pairs(stringArr) do
    local separator = CLGlobals.FieldSeparator[stringType]
    local set, result = CLUtils.createSetFromString(gameObject[stringType], separator)

    for element, _ in pairs(addSet) do
      if not set[element] then
        set[element] = true
        table.insert(result, element)
      end
    end

    gameObject[stringType] = table.concat(result, separator)
  end
end

function Queue.Commit_StringRemoval(gameObject, stringArr)
  CLUtils.Info("Entering Queue.Commit_StringRemoval")

  for stringType, removeSet in pairs(stringArr) do
    local separator = CLGlobals.FieldSeparator[stringType]
    local set, _ = CLUtils.createSetFromString(gameObject[stringType], separator)
    local result = {}

    for element, _ in pairs(removeSet) do
      if set[element] then
        set[element] = nil
      end
    end

    for element, exists in pairs(set) do
      if exists then
        table.insert(result, element)
      end
    end

    gameObject[stringType] = table.concat(result, separator)
  end
end

function Queue.ParseInsertSelectors(tempArr, selectorGroup, selectorFunction)
  CLUtils.Info("Entering Queue.ParseInsertSelectors")
  for _, selector in pairs(selectorGroup) do
    if not Utils.IsPayloadInSelector(tempArr, selector, selectorFunction) then
      table.insert(tempArr, selector)
    end
  end
end

function Queue.Commit_Selectors(gameObject, selectors)
  CLUtils.Info("Entering Queue.Commit_Selectors")
  for selectorFunction, selectorGroup in pairs(selectors) do
    local res = {}
    Queue.ParseInsertSelectors(res, selectorGroup, CLGlobals.SelectorIdTypes[selectorFunction])
    Queue.ParseInsertSelectors(res, gameObject[selectorFunction], CLGlobals.SelectorIdTypes[selectorFunction])

    gameObject[selectorFunction] = res
  end
end

function Queue.Commit_SelectorRemoval(gameObject, selectors)
  CLUtils.Info("Entering Queue.Commit_SelectorRemoval")
  for selectorFunction, selectorIds in pairs(selectors) do
    local res = {}
    local count = 1
    for _, selector in pairs(gameObject[selectorFunction]) do
      local selectorUUID = selector[CLGlobals.SelectorIdTypes[selectorFunction]]

      if selectorUUID ~= nil and not CLUtils.IsInTable(selectorIds, selectorUUID) then
        CLUtils.AddKeyValueToTable(res, tostring(count), selector)
      end
    end
    gameObject[selectorFunction] = res
  end
end

function Queue.Commit_Booleans(gameObject, booleans)
  CLUtils.Info("Entering Queue.Commit_Booleans")
  for key, value in pairs(booleans) do
    if gameObject[key] ~= nil then
      gameObject[key] = value
    end
  end
end

function Queue.CommitFeatsAndProgressions()
  CLUtils.Info("Entering Queue.CommitFeatsAndProgressions")
  for _, objectType in pairs(CLGlobals.CacheTypes) do
    for objectId, objectTable in pairs(Queue[Globals.ModuleTypes[objectType]]) do
      local gameObject = CLUtils.CacheOrRetrieve(objectId, objectType)
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

        if objectTable.Strings_Remove ~= nil then
          Queue.Commit_StringRemoval(gameObject, objectTable.Strings_Remove)
        end

        if objectTable.Strings ~= nil then
          Queue.Commit_Strings(gameObject, objectTable.Strings)
        end

        if objectTable.Booleans ~= nil then
          Queue.Commit_Booleans(gameObject, objectTable.Booleans)
        end
      end
    end
  end
end

function Queue.Commit_ChildNodes(gameObject, childNodes)
  for key, value in pairs(childNodes) do
    local res = CLUtils.InsertFromTableToTable(gameObject[key], {})
    for _, val in pairs(value) do
      table.insert(res, val)
    end

    gameObject[key] = res
  end
end

function Queue.CommitRaces()
  CLUtils.Info("Entering Queue.CommitRaces")
  for objectId, objectTable in pairs(Queue.Races) do
    local gameObject = CLUtils.CacheOrRetrieve(objectId, "Race")
    if gameObject ~= nil and objectTable ~= nil then
      Queue.Commit_ChildNodes(gameObject, objectTable)
    end
  end
end

function Queue.CommitSpellData()
  CLUtils.Info("Entering Queue.CommitSpellData")
end
