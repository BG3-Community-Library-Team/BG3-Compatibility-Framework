JsonUtils.Endpoints = {
  Insert = {
    ActionResourceGroup = Api.InsertResourceToGroup,
    List = Api.InsertToList,
    Race = Api.InsertRaceChildData,
    Strings = Api.InsertStrings,
    Selector = Api.InsertSelectors,
    SpellData = Api.InsertSpellStrings,
    Tags = Api.InsertTags
  },
  Remove = {
    ActionResourceGroup = Api.RemoveResourceFromGroup,
    List = Api.RemoveFromList,
    Race = Api.RemoveRaceChildData,
    Subclass = Api.RemoveSubClasses,
    Strings = Api.RemoveStrings,
    Selector = Api.RemoveSelectors,
    SpellData = Api.RemoveSpellStrings,
    Tags = Api.InsertTags
  },
  Set = {
    Booleans = Api.SetBoolean,
    Fields = Api.SetField
  },
  Blacklist = {
    Class = Api.ClassBlacklist
  }
}

function JsonUtils.DataValidator(modGuid, dataToValidate, target, fileType, errStr)
  CLUtils.Info(Strings.PREFIX .. "Entering DataValidator")
  local errString = "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) .. errStr
  if fileType then
    errString = errString .. " in " .. fileType
  end
  if target then
    errString = errString .. " with UUID: " .. target
  end

  errString = errString .. ". " .. Strings.CHANGES_NOT_APPLIED
  if not dataToValidate then
    CLUtils.Error(Strings.PREFIX .. errString)
    return false
  end

  return true
end

function JsonUtils.BuildRacePayloads(data, modGuid, child)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildPayloads")
  local result = {
    modGuid = data.modGuid or modGuid,
    raceGuid = data.UUID,
    children = { child }
  }

  return result
end

function JsonUtils.BuildSubclassPayload(data, classId, modGuid, subclassGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildSubclassPayload")
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
  CLUtils.Info(Strings.PREFIX .. "Entering BuildAddSelectorPayload")

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
  CLUtils.Info(Strings.PREFIX .. "Entering BuildRemoveSelectorPayload")

  return {
    modGuid = data.modGuid or modGuid,
    TargetUUID = target,
    FileType = type,
    Function = data.Function,
    ListUUID = data.UUID
  }
end

function JsonUtils.BuildStringPayload(data, modGuid, target, type)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildStringPayload")

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
  CLUtils.Info(Strings.PREFIX .. "Entering BuildBooleanPayload")
  return {
    modGuid = data.modGuid or modGuid,
    FileType = type,
    Target = target,
    Key = data.Key,
    Value = data.Value
  }
end

function JsonUtils.BuildListPayload(data, modGuid, listId)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildListPayload")

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
  CLUtils.Info(Strings.PREFIX .. "Entering BuildActionResourceGroupPayload")

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
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitSelectors")
  if not JsonUtils.DataValidator(modGuid, data.Function, target, fileType, Strings.ERR_DID_NOT_PROVIDE_SELECTOR_FUNCTION)
    or (data.Action ~= "Remove" and not JsonUtils.DataValidator(modGuid, data.Params, target, fileType, Strings.ERR_DID_NOT_PROVIDE_PARAMS)) then
    return nil
  end
  local payloadBuilders = {
    Insert = JsonUtils.BuildAddSelectorPayload,
    Remove = JsonUtils.BuildRemoveSelectorPayload
  }

  JsonUtils.Endpoints[data.Action].Selector({ payloadBuilders[data.Action](data, modGuid, target, fileType) })
end

function JsonUtils.ParseAndSubmitStrings(data, target, modGuid, fileType)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitStrings")
  if not JsonUtils.DataValidator(modGuid, data.Strings, target, fileType, Strings.ERR_DID_NOT_PROVIDE_STRINGS) then
    return nil
  end

  local payloads = JsonUtils.BuildStringPayload(data, modGuid, target, fileType)

  JsonUtils.Endpoints[data.Action].Strings({ payloads })
end

function JsonUtils.ParseAndSubmitBoolean(data, target, modGuid, fileType)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitBooleans")
  if not JsonUtils.DataValidator(modGuid, data.Key, target, fileType, Strings.ERR_DID_NOT_PROVIDE_BOOLEANS)
    or not JsonUtils.DataValidator(modGuid, data.Value, target, fileType, Strings.ERR_DID_NOT_PROVIDE_BOOLEANS) then
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

function JsonUtils.BuildTagPayload(data, target, modGuid, fileType)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildTagPayload")

  local count = 0
  local result = {
    modGuid = data.modGuid or modGuid,
    TargetUUID = target,
    TagType = data.Type,
    TagList = {},
    FileType = fileType
  }

  for _, item in pairs(data.UUIDs) do
    result.TagList[tostring(count)] = item
    count = count + 1
  end
end

function JsonUtils.ParseAndSubmitTags(data, target, modGuid, fileType)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitTags")
  if data.Action == "Insert" and not JsonUtils.DataValidator(modGuid, data.UUIDs, target, fileType, Strings.ERR_DID_NOT_PROVIDE_TAGS) then
    return nil
  end

  JsonUtils[data.Action].Tags({ JsonUtils.BuildTagPayload(data, target, modGuid, fileType) })
end

function JsonUtils.ParseAndSubmitClassBlacklist(classUUID, data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitClassBlacklist")
  local payload = {
    modGuid = modGuid,
    ClassUUID = classUUID,
    Blacklist = data.Blacklist
  }

  JsonUtils.Endpoints.Blacklist.Class({ payload })
end
