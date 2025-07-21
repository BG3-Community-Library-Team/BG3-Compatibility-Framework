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
    List = Api.RemoveFromList,
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
  CLUtils.Info("Entering BuildPayloads")
  local result = {
    modGuid = data.modGuid or modGuid,
    raceGuid = data.UUID,
    children = { child }
  }

  return result
end

function JsonUtils.BuildSubclassPayload(data, classId, modGuid, subclassGuid)
  CLUtils.Info("Entering BuildSubclassPayload")
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
  CLUtils.Info("Entering BuildAddSelectorPayload")

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
  CLUtils.Info("Entering BuildRemoveSelectorPayload")

  return {
    modGuid = data.modGuid or modGuid,
    TargetUUID = target,
    FileType = type,
    Function = data.Function,
    ListUUID = data.UUID
  }
end

function JsonUtils.BuildStringPayload(data, modGuid, target, type)
  CLUtils.Info("Entering BuildStringPayload")

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
  CLUtils.Info("Entering BuildBooleanPayload")
  return {
    modGuid = data.modGuid or modGuid,
    FileType = type,
    Target = target,
    Key = data.Key,
    Value = data.Value
  }
end

function JsonUtils.BuildListPayload(data, modGuid, listId)
  CLUtils.Info("Entering BuildListPayload")
  if not data.Type then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_LIST_TYPE " " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  elseif not data.Items then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_LIST .. data.Type .. " in CF config. " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  end

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
  CLUtils.Info("Entering BuildActionResourceGroupPayload")

  local count = 0
  local result = {
    modGuid = data.modGuid or modGuid,
    TargetUUID = data.UUID,
    Definitions = {}
  }

  for _, item in pairs(data.Definitions) do
    result.Definitions[tostring(count)] = item
    count = count + 1
  end

  return result
end

function JsonUtils.ParseAndSubmitSelectors(data, target, modGuid, fileType)
  CLUtils.Info("Entering ParseAndSubmitSelectors")
  if not data.Function then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_SELECTOR_FUNCTION .. target .. ". " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  elseif not data.Params then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_PARAMS .. data.Function .. " in " .. target .. " " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  end
  local payloadBuilders = {
    Insert = JsonUtils.BuildAddSelectorPayload,
    Remove = JsonUtils.BuildRemoveSelectorPayload
  }

  JsonUtils.Endpoints[data.Action].Selector({ payloadBuilders[data.Action](data, modGuid, target, fileType) })
end

function JsonUtils.ParseAndSubmitStrings(data, target, modGuid, fileType)
  CLUtils.Info("Entering ParseAndSubmitStrings")
  if not data.Strings then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_STRINGS .. fileType .. " " .. target .. " " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  end

  local payloads = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)

  JsonUtils.Endpoints[data.Action].Strings({ payloads })
end

function JsonUtils.ParseAndSubmitBoolean(data, target, modGuid, fileType)
  CLUtils.Info("Entering ParseAndSubmitBooleans")
  if not data.Key or not data.Value then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_BOOLEANS .. fileType .. " " .. target .. ". " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  end
  local payloads = {
    Set = JsonUtils.BuildBooleanPayload(data, modGuid, target, fileType)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Booleans({ payload })
    end
  end
end
