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

function JsonUtils.BuildRacePayloads(data, modGuid, child)
  Utils.Info("Entering BuildPayloads")
  local result = {
    modGuid = data.modGuid or modGuid,
    raceGuid = data.UUID,
    children = {child}
  }

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
  Utils.Info("Entering BuildAddSelectorPayload")

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
  Utils.Info("Entering BuildRemoveSelectorPayload")

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
  local payloadBuilders = {
    Insert = JsonUtils.BuildAddSelectorPayload,
    Remove = JsonUtils.BuildRemoveSelectorPayload
  }

  JsonUtils.Endpoints[data.Action].Selector({ payloadBuilders[data.Action](data, modGuid, target, fileType) })
end

function JsonUtils.ParseAndSubmitStrings(data, target, modGuid, fileType)
  Utils.Info("Entering ParseAndSubmitStrings")
  local payloads = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)

  JsonUtils.Endpoints[data.Action].Strings({ payloads })
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
