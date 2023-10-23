function ParseAndSubmitActionResourceGroups(data, modGuid)
  Utils.Info("Entering ParseAndSubmitActionResourceGroups")

  local payloads = {
    Insert = JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
    -- Remove = JsonUtils.BuildActionResourceGroupPayload(data, modGuid)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].List({ payload })
    end
  end
end

function ActionResourceGroupJsonHandler(data, modGuid)
  Utils.Info("Entering ActionResourceGroupJsonHandler")
  for _, actionResourceGroup in pairs(data) do
    ParseAndSubmitActionResourceGroups(actionResourceGroup, modGuid)
  end
end
