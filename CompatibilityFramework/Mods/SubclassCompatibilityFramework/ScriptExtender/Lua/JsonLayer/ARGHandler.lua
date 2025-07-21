function ParseAndSubmitActionResourceGroups(data, modGuid)
  CLUtils.Info("Entering ParseAndSubmitActionResourceGroups")
  if not data.Definitions then
    CLUtils.Error("Mod" ..
      CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
      Strings.ERR_DID_NOT_PROVIDE_AR_DEFINITIONS .. data.UUID .. ". " .. Strings.CHANGES_NOT_APPLIED)
    return nil
  end
  local payloads = {
    Insert = JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
    -- Remove = JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].ActionResourceGroup({ payload })
    end
  end
end

function ActionResourceGroupJsonHandler(data, modGuid)
  CLUtils.Info("Entering ActionResourceGroupJsonHandler")
  for _, actionResourceGroup in pairs(data) do
    ParseAndSubmitActionResourceGroups(actionResourceGroup, modGuid)
  end
end
