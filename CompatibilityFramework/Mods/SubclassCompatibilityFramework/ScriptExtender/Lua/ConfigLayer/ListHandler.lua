function ParseAndSubmitLists(data, listId, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitLists")

  if data.Action ~= "Insert" and data.Action ~= "Remove" then return end

  -- Type is always required
  if not JsonUtils.DataValidator(modGuid, data.Type, data.UUID, nil,
    Strings.ERR_DID_NOT_PROVIDE_LIST_TYPE) then
    return nil
  end

  -- Require at least one actionable field
  if not data.Items and not data.Inherit and not data.Exclude then
    CLUtils.Error(Strings.PREFIX .. "Mod "
      .. CLUtils.RetrieveModHandleAndAuthor(modGuid)
      .. Strings.ERR_DID_NOT_PROVIDE_LIST_CONTENT .. data.Type)
    return nil
  end

  local payload = JsonUtils.BuildListPayload(data, modGuid, listId)
  if not payload then return end

  -- Route Items → Action-based endpoint (existing behaviour)
  if data.Items then
    JsonUtils.Endpoints[data.Action].List({ payload })
  end

  -- Route Inherit → always Insert (Inherit is an Add operation)
  if data.Inherit then
    JsonUtils.Endpoints["Insert"].List({ payload })
  end

  -- Route Exclude → always Remove (Exclude is a Remove operation)
  if data.Exclude then
    JsonUtils.Endpoints["Remove"].List({ payload })
  end
end

function ListDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ListDataHandler")

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
