JsonUtils.Endpoints = {
  Insert = {
    ActionResourceGroup = Api.InsertResourceToGroup,
    List = Api.InsertToList,
    Race = Api.InsertRaceChildData,
    Subclass = Api.InsertSubClasses,
    Strings = Api.InsertStrings,
    Selector = Api.InsertSelectors,
    SpellData = Api.InsertSpellStrings
  },
  Remove = {
    ActionResourceGroup = Api.RemoveResourceFromGroup,
    Race = Api.RemoveRaceChildData,
    Strings = Api.RemoveStrings,
    Selector = Api.RemoveSelectors,
    SpellData = Api.RemoveSpellStrings
  },
  Set = {
    Booleans = Api.SetBoolean
  }
}

function JsonUtils.BuildRacePayloads(data, modGuid, action)
  Utils.Info("Entering BuildPayloads")
  local count = 0
  local result = {
    modGuid = modGuid,
    raceGuid = data.UUID,
    children = {}
  }

  for _, child in pairs(data.Children) do
    if child.Action == action and child.Values ~= nil then
      for _, value in pairs(child.Values) do
        result.children[tostring(count)] = { Type = child.Type, Value = value }
        count = count + 1
      end
    elseif child.Action == action and child.Value ~= nil then
      result.children[tostring(count)] = { Type = child.Type, Value = child.Value }
      count = count + 1
    end
  end

  return result
end

function JsonUtils.BuildSubclassPayload(data, classId, modGuid, subclassGuid)
  Utils.Info("Entering BuildSubclassPayload")
  subclassGuid = subclassGuid or data.UUID
  return {
    modGuid = data.modGuid or modGuid,
    subClassGuid = subclassGuid,
    class = classId,
    subClassName = data.SubClassName or "",
    isIntegrated = data.IsIntegrated or false
  }
end

function JsonUtils.BuildAddSelectorPayload(data, modGuid, target, type)
  Utils.Info("Entering BuildSelectorPayload")

  return {
    modGuid = data.modGuid or modGuid,
    Target = target,
    FileType = type,
    Function = data.Function,
    Overwrite = data.Overwrite,
    Params = data.Params
  }
end

function JsonUtils.BuildRemoveSelectorPayload(data, modGuid, target, type)
  Utils.Info("Entering BuildSelectorPayload")

  return {
    modGuid = data.modGuid or modGuid,
    TargetUUID = target,
    FileType = type,
    Function = data.Function,
    ListUUID = data.UUID
  }
end

function JsonUtils.BuildStringPayload(data, modGuid, target, type)
  Utils.Info("Entering BuildStringPayload")
  local count = 0
  local result = {
    modGuid = data.modGuid or modGuid,
    Target = target,
    FileType = type,
    Type = data.Type,
    Strings = {}
  }

  for _, str in pairs(data.Strings) do
    result.Strings[tostring(count)] = str
    count = count + 1
  end

  return result
end

function JsonUtils.BuildBooleanPayload(data, modGuid, target, type)
  Utils.Info("Entering BuildBooleanPayload")
  return {
    modGuid = data.modGuid or modGuid,
    FileType = type,
    Target = target,
    Key = data.Key,
    Value = data.Value
  }
end

function JsonUtils.BuildListPayload(data, modGuid, listId)
  Utils.Info("Entering BuildListPayload")
  listId = listId or data.UUID
  local count = 0
  local result = {
    modGuid = data.modGuid or modGuid,
    TargetList = listId,
    ListType = data.Type,
    ListItems = {}
  }

  for _, item in pairs(data.Items) do
    result.ListItems[tostring(count)] = item
    count = count + 1
  end

  return result
end

function JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
  Utils.Info("Entering BuildActionResourceGroupPayload")
  local count = 0
  local result = {
    modGuid = data.modGuid or modGuid,
    Type = data.Type,
    Definitions = {}
  }

  for _, item in pairs(data.Definitions) do
    result.Definitions[tostring(count)] = item
    count = count + 1
  end

  return result
end

function JsonUtils.ParseAndSubmitSelectors(data, target, modGuid, fileType)
  Utils.Info("Entering ParseAndSubmitSelectors")
  local payloads = {
    Insert = JsonUtils.BuildAddSelectorPayload(data, modGuid, target, fileType),
    Remove = JsonUtils.BuildRemoveSelectorPayload(data, modGuid, target, fileType)
  }

  JsonUtils.Endpoints[data.Action].Selector({ payloads[data.Action] })
end

function JsonUtils.ParseAndSubmitStrings(data, target, modGuid, fileType)
  Utils.Info("Entering ParseAndSubmitStrings")
  local payloads = {
    Insert = JsonUtils.BuildStringPayload(data, modGuid, target, fileType),
    Remove = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)
  }

  JsonUtils.Endpoints[data.Action].Strings({ payloads[data.Action] })
end

function JsonUtils.ParseAndSubmitBoolean(data, target, modGuid, fileType)
  Utils.Info("Entering ParseAndSubmitBooleans")
  local payloads = {
    Set = JsonUtils.BuildBooleanPayload(data, modGuid, target, fileType)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Booleans({ payload })
    end
  end
end
