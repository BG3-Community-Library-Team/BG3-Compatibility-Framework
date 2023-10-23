JsonUtils.Endpoints = {
  Insert = {
    ActionResourceGroup = Api.InsertResourceToGroup,
    List = Api.InsertToList,
    Race = Api.InsertRaceChildData,
    Subclass = Api.InsertSubClasses,
    Strings = Api.InsertStrings,
    Selector = Api.InsertSelectors
  },
  Remove = {
    ActionResourceGroup = Api.RemoveResourceFromGroup,
    Race = Api.RemoveRaceChildData,
    Strings = Api.RemoveStrings,
    Selector = Api.RemoveSelectors
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
    if child.Action == action then
      result.children[tostring(count)] = { Type = child.Type, Value = child.Value }
      count = count + 1
    end
  end

  return result
end

function JsonUtils.BuildSubclassPayload(data, modGuid)
  Utils.Info("Entering BuildSubclassPayload")
  return {
    modGuid = modGuid,
    subClassGuid = data.UUID,
    class = data.Class,
    subClassName = data.SubClassName or ""
  }
end

function JsonUtils.BuildAddSelectorPayload(data, modGuid, target, type)
  Utils.Info("Entering BuildSelectorPayload")

  return {
    modGuid = modGuid,
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
    modGuid = modGuid,
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
    modGuid = modGuid,
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
  Utils.Info("Entering BuildStringPayload")
  return {
    modGuid = modGuid,
    FileType = type,
    Target = target,
    Key = data.Key,
    Value = data.Value
  }
end

function JsonUtils.BuildListPayload(data, modGuid)
  Utils.Info("Entering BuildListPayload")
  local count = 0
  local result = {
    modGuid = modGuid,
    TargetList = data.UUID,
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
    modGuid = modGuid,
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
    Insert = JsonUtils.BuildAddSelectorPayload(data, modGuid, target, fileType)
    -- Remove = JsonUtils.BuildRemoveSelectorPayload(data, modGuid, target, fileType)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Selector({ payload })
    end
  end
end

function JsonUtils.ParseAndSubmitStrings(data, target, modGuid, fileType)
  Utils.Info("Entering ParseAndSubmitStrings")
  local payloads = {
    Insert = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)
    -- Remove = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Strings({ payload })
    end
  end
end

function JsonUtils.ParseAndSubmitBooleans(data, target, modGuid, fileType)
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
