local function ActionResourceSubSectionHandler(data, resourceUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ActionResourceSubSectionHandler")

  if data.Fields ~= nil then
    for _, field in pairs(data.Fields) do
      JsonUtils.ParseAndSubmitFields(field, resourceUUID, modGuid, "ActionResource")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, resourceUUID, modGuid, "ActionResource")
    end
  end
end

function ActionResourceDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ActionResourceDataHandler")

  for _, resource in pairs(data) do
    if resource.UUIDs ~= nil then
      for _, uuid in pairs(resource.UUIDs) do
        ActionResourceSubSectionHandler(resource, uuid, modGuid)
      end
    elseif type(resource.UUID) == "table" then
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
        Strings.VAL_ERR_UUID_IS_TABLE .. table.concat(resource.UUID, ", ") ..
        Strings.VAL_ERR_UUID_IS_TABLE_B)
      for _, uuid in pairs(resource.UUID) do
        ActionResourceSubSectionHandler(resource, uuid, modGuid)
      end
    elseif resource.UUID ~= nil then
      ActionResourceSubSectionHandler(resource, resource.UUID, modGuid)
    end
  end
end
