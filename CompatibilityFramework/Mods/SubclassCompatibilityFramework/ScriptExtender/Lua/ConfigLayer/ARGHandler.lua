function ParseAndSubmitActionResourceGroups(data, modGuid, targetUUID)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitActionResourceGroups")
  targetUUID = targetUUID or data.UUID
  if not JsonUtils.DataValidator(modGuid, data.Definitions, targetUUID, nil, Strings.ERR_DID_NOT_PROVIDE_AR_DEFINITIONS) then
    return nil
  end

  if data.Action == "Insert" or data.Action == "Remove" then
    payload = JsonUtils.BuildActionResourceGroupPayload(data, modGuid, targetUUID)
    if payload then
      JsonUtils.Endpoints[data.Action].ActionResourceGroup({ payload })
    end
  end
end

function ActionResourceGroupDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ActionResourceGroupDataHandler")
  for _, actionResourceGroup in pairs(data) do
    for _, uuid in pairs(JsonUtils.ResolveUUIDs(actionResourceGroup, modGuid)) do
      ParseAndSubmitActionResourceGroups(actionResourceGroup, modGuid, uuid)
    end
  end
end
