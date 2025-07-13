function ParseAndSubmitLists(data, listId, modGuid)
  CLUtils.Info("Entering ParseAndSubmitLists")
  if data.Action == "Insert" or data.Action == "Remove" then
    JsonUtils.Endpoints[data.Action].List({ JsonUtils.BuildListPayload(data, modGuid, listId) })
  else

  end
end

function ListJsonHandler(data, modGuid)
  CLUtils.Info("Entering ListJsonHandler")

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
