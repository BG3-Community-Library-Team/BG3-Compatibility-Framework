function ParseAndSubmitLists(data, listId, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitLists")
  if data.Action == "Insert" or data.Action == "Remove" then
    if not JsonUtils.DataValidator(modGuid, data.Type, data.UUID, nil, Strings.ERR_DID_NOT_PROVIDE_LIST_TYPE)
      or not JsonUtils.DataValidator(modGuid, data.Items, data.UUID, data.Type, Strings.ERR_DID_NOT_PROVIDE_LIST) then
      return nil
    end
    payload = JsonUtils.BuildListPayload(data, modGuid, listId)
    if payload then
      JsonUtils.Endpoints[data.Action].List({ payload })
    end
  end
end

function ListJsonHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ListJsonHandler")

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
