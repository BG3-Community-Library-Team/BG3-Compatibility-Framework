function ParseAndSubmitLists(data, listId, modGuid)
  Utils.Info("Entering ParseAndSubmitLists")
  JsonUtils.Endpoints[data.Action].List({ JsonUtils.BuildListPayload(data, modGuid, listId) })
end

function ListJsonHandler(data, modGuid)
  Utils.Info("Entering ListJsonHandler")

  for _, list in pairs(data) do
    if list.UUIDs ~= nil then
      for _, uuid in pairs(list.UUIDs) do
        ParseAndSubmitLists(list, uuid, modGuid)
      end
    else
      ParseAndSubmitLists(list, list.UUID, modGuid)
    end
  end
end
