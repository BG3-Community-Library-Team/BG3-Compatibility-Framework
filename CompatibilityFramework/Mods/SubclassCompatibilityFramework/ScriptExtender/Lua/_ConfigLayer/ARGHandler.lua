function ParseAndSubmitActionResourceGroups(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitActionResourceGroups")
  if not JsonUtils.DataValidator(modGuid, data.Definitions, data.UUID, nil, Strings.ERR_DID_NOT_PROVIDE_AR_DEFINITIONS) then
    return nil
  end

  if data.Action == "Insert" or data.Action == "Remove" then
    payload = JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
    if payload then
      JsonUtils.Endpoints[data.Action].ActionResourceGroup({ payload })
    end
  end
end

function ActionResourceGroupDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ActionResourceGroupDataHandler")
  for _, actionResourceGroup in pairs(data) do
    ParseAndSubmitActionResourceGroups(actionResourceGroup, modGuid)
  end
end
