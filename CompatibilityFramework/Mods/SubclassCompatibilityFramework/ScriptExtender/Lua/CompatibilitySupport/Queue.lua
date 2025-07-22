function Queue.Commit()
  CLUtils.Info("Entering Queue.Commit")
  Queue.DeclareModValidationFailures()
  Queue.CommitListItems()
  Queue.CommitSubclasses()
  Queue.CommitFeatsAndProgressions()
  Queue.CommitRaces()
  --Queue.CommitSpellData()
end

function Queue.DeclareModValidationFailures()
  CLUtils.Info("Entering Queue.DeclareModValidationFailures")
  if #Globals.ValidationErrors > 0 then
    local errStr = Strings.VAL_ERR_MOD_NOT_LOADED ..
      #Globals.ValidationErrors .. Strings.VAL_ERR_MOD_NOT_LOADED_B .. "\n" .. Strings.VAL_ERR_USER_REASSURANCE .. "\n"

    errStr = errStr .. table.concat(Globals.ValidationErrors, ", ")

    CLUtils.Warn(errStr)
  end
end

-- Some quick & dirty jank, refactor to actually be good code when time allows
local function CombineIterableLists(arrA, arrB)
  local res = {}

  for key, _ in pairs(arrA) do
    table.insert(res, key)
  end

  for key, _ in pairs(arrB) do
    if not CLUtils.IsInTable(res, key) then
      table.insert(res, key)
    end
  end

  return res
end

function Queue.CommitListItems()
  CLUtils.Info("Entering Queue.CommitListItems")
  for _, objectType in pairs(CLGlobals.ListTypes) do
    if Queue.Lists_Remove[objectType] or Queue.Lists[objectType] then
      listsToiterate = CombineIterableLists(Queue.Lists_Remove[objectType], Queue.Lists[objectType])
      for _, listId in pairs(listsToiterate) do
        local gameList = CLUtils.CacheOrRetrieve(listId, objectType)
        list = Queue.Lists[objectType][listId] or {}

        for _, item in pairs(gameList[CLGlobals.ListNodes[objectType]]) do
          if not CLUtils.IsInTable(list, item) then
            table.insert(list, item)
          end
          if Queue.Lists_Remove[objectType][listId] then
            localItemKey = CLUtils.GetKeyFromvalue(list, item)
            if localItemKey and CLUtils.IsInTable(Queue.Lists_Remove[objectType][listId], item) then
              CLUtils.Info("Removing " .. item .. " from " .. objectType .. " " .. listId)
              table.remove(list, localItemKey)
            end
          end
        end

        if list and #list > 0 then
          local res = Utils.StripInvalidStatData(list)
          gameList[CLGlobals.ListNodes[objectType]] = res
        else
          CLUtils.Warn("List " .. listId .. " cannot be empty", true)
        end
      end
    end
  end
end

local function populateClassDescriptionDict()
  local classDescUUIDs = Ext.StaticData.GetAll("ClassDescription")
  for _, uuid in pairs(classDescUUIDs) do
    local classDesc = Ext.StaticData.Get(uuid, "ClassDescription")
    if classDesc.ParentGuid == "00000000-0000-0000-0000-000000000000" then
      Globals.ClassDescriptionDict[classDesc.Name] = Globals.ClassDescriptionDict[classDesc.Name] or {}
    else
      local parent = Ext.StaticData.Get(classDesc.ParentGuid, "ClassDescription")
      if parent == nil then
        CLUtils.Error(classDesc.Name .. Strings.VAL_ERR_CLASS_DESCRIPTION_INVALID_PARENT)
      else
        Globals.ClassDescriptionDict[parent.Name] = Globals.ClassDescriptionDict[parent.Name] or {}
        table.insert(Globals.ClassDescriptionDict[parent.Name], classDesc.ResourceUUID)
      end
    end
  end
end

local function populateProgressionDict()
  local progUUIDs = Ext.StaticData.GetAll("Progression")
  for _, uuid in pairs(progUUIDs) do
    local prog = Ext.StaticData.Get(uuid, "Progression")

    if prog.ProgressionType == "Class" then
      Globals.ProgressionDict[prog.Name] = Globals.ProgressionDict[prog.Name] or {}
      table.insert(Globals.ProgressionDict[prog.Name], prog)
    end
  end
end

--- Separating out Subclass population from main progression population to allow for more comprehensive subclass handling
function Queue.CommitSubclasses()
  CLUtils.Info("Entering Queue.CommitSubclasses")
  populateClassDescriptionDict()
  populateProgressionDict()
  for className, _ in pairs(Globals.ClassDescriptionDict) do
    local sortedList = Utils.SortStaticData(Globals.ClassDescriptionDict[className], "ClassDescription", "DisplayName")

    if Globals.ProgressionDict[className] then
      for _, progression in pairs(Globals.ProgressionDict[className]) do
        if progression.SubClasses ~= nil and #progression.SubClasses > 0 then
          progression.SubClasses = sortedList
        end
      end
    end
  end
end

function Queue.CommitProgressions_Subclasses_Remove(progression, subclasses)
  CLUtils.Info("Entering Queue.CommitProgressions_Subclasses_Remove")
  -- local strippedList = Utils.StripInvalidStaticData(subclasses, "ClassDescription")
  -- for _, vanillaEntry in pairs(progression.SubClasses) do
  --   CLUtils.AddToTable(strippedList, vanillaEntry)
  -- end

  -- progression.SubClasses = Utils.SortStaticData(strippedList, "ClassDescription", "DisplayName")
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

function Queue.Commit_Selectors(gameObject, selectors)
  CLUtils.Info("Entering Queue.Commit_Selectors")
  for selectorFunction, selectorGroup in pairs(selectors) do
    local count = #gameObject[selectorFunction] + 1
    for _, selector in pairs(selectorGroup) do
      gameObject[selectorFunction][count] = selector
      count = count + 1
    end
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
        -- if objectTable.SubClasses ~= nil then
        --   Queue.CommitProgressions_Subclasses(gameObject, objectTable.SubClasses)
        -- end

        if objectTable.SubClasses_Remove ~= nil then
          Queue.CommitProgressions_Subclasses_Remove(gameObject, objectTable.SubClasses_Remove)
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
    local count = #gameObject[key] + 1
    for _, val in pairs(value) do
      gameObject[key][count] = val
      count = count + 1
    end
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
