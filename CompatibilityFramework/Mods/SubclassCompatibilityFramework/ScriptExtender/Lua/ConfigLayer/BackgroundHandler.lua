local function BackgroundSubSectionHandler(data, backgroundUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering BackgroundSubSectionHandler")

  if data.Tags ~= nil then
    for _, tag in pairs(data.Tags) do
      JsonUtils.ParseAndSubmitTags(tag, backgroundUUID, modGuid, "Background")
    end
  end

  if data.Fields ~= nil then
    for _, field in pairs(data.Fields) do
      JsonUtils.ParseAndSubmitFields(field, backgroundUUID, modGuid, "Background")
    end
  end

  if data.Strings ~= nil then
    for _, str in pairs(data.Strings) do
      JsonUtils.ParseAndSubmitStrings(str, backgroundUUID, modGuid, "Background")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, backgroundUUID, modGuid, "Background")
    end
  end
end

function BackgroundDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering BackgroundDataHandler")

  for _, background in pairs(data) do
    for _, uuid in pairs(JsonUtils.ResolveUUIDs(background, modGuid)) do
      BackgroundSubSectionHandler(background, uuid, modGuid)
    end
  end
end
