function ParseAndSubmitLists(data, modGuid)
  Utils.Info("Entering ParseAndSubmitLists")

  local payloads = {
    Insert = JsonUtils.BuildListPayload(data, modGuid)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].List({ payload })
    end
  end
end

function ListJsonHandler(data, modGuid)
  Utils.Info("Entering ListJsonHandler")
  for _, list in pairs(data) do
    ParseAndSubmitLists(list, modGuid)
  end
end
