function ParseAndSubmitLists(data, modGuid)
  Utils.Info("Entering ParseAndSubmitLists")

  if data.UUIDs ~= nil then
    for _, uuid in pairs(data.UUIDs) do
      JsonUtils.Endpoints[data.Action].List({ JsonUtils.BuildListPayload(data, modGuid, uuid) })
    end
  else
    JsonUtils.Endpoints[data.Action].List({JsonUtils.BuildListPayload(data, modGuid)})
  end

end

function ListJsonHandler(data, modGuid)
  Utils.Info("Entering ListJsonHandler")
  for _, list in pairs(data) do
    ParseAndSubmitLists(list, modGuid)
  end
end
