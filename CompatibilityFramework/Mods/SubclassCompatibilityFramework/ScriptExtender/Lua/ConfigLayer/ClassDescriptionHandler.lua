
local function ClassDescriptionSubSectionHandler(data, classUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ClassDescriptionSubSectionHandler")

  if data.Blacklist ~= nil then
    JsonUtils.ParseAndSubmitClassBlacklist(classUUID, data, modGuid)
  end

  if data.Tags ~= nil then
    for _, tag in pairs(data.Tags) do
      JsonUtils.ParseAndSubmitTags(tag, classUUID, modGuid, "ClassDescription")
    end
  end

  if data.Fields ~= nil then
    for _, field in pairs(data.Fields) do
      JsonUtils.ParseAndSubmitFields(field, classUUID, modGuid, "ClassDescription")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, classUUID, modGuid, "ClassDescription")
    end
  end
end

function ClassDescriptionDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ClassDescriptionDataHandler")

  for _, class in pairs(data) do
    if class.UUIDs ~= nil then
      for _, uuid in pairs(class.UUIDs) do
        ClassDescriptionSubSectionHandler(class, uuid, modGuid)
      end
    elseif type(class.UUID) == "table" then
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
        Strings.VAL_ERR_UUID_IS_TABLE .. table.concat(class.UUID, ", ") ..
        Strings.VAL_ERR_UUID_IS_TABLE_B)
      for _, uuid in pairs(class.UUID) do
        ClassDescriptionSubSectionHandler(class, uuid, modGuid)
      end
    elseif class.UUID ~= nil then
      ClassDescriptionSubSectionHandler(class, class.UUID, modGuid)
    end
  end
end
