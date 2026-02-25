
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
    for _, uuid in pairs(JsonUtils.ResolveUUIDs(class, modGuid)) do
      ClassDescriptionSubSectionHandler(class, uuid, modGuid)
    end
  end
end
