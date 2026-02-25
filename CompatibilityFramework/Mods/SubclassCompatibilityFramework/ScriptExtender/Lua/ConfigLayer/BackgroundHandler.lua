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
    if background.UUIDs ~= nil then
      for _, uuid in pairs(background.UUIDs) do
        BackgroundSubSectionHandler(background, uuid, modGuid)
      end
    elseif type(background.UUID) == "table" then
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
        Strings.VAL_ERR_UUID_IS_TABLE .. table.concat(background.UUID, ", ") ..
        Strings.VAL_ERR_UUID_IS_TABLE_B)
      for _, uuid in pairs(background.UUID) do
        BackgroundSubSectionHandler(background, uuid, modGuid)
      end
    elseif background.UUID ~= nil then
      BackgroundSubSectionHandler(background, background.UUID, modGuid)
    end
  end
end
