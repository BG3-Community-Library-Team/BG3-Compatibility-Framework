function FeatSubSectionHandler(data, featUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering FeatDataHandler")
  if data.Selectors ~= nil then
    for _, selector in pairs(data.Selectors) do
      JsonUtils.ParseAndSubmitSelectors(selector, featUUID, modGuid, "Feat")
    end
  end

  if data.Strings ~= nil then
    for _, strings in pairs(data.Strings) do
      JsonUtils.ParseAndSubmitStrings(strings, featUUID, modGuid, "Feat")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, featUUID, modGuid, "Feat")
    end
  end
end

function FeatDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering FeatDataHandler")
  for _, feats in pairs(data) do
    for _, uuid in pairs(JsonUtils.ResolveUUIDs(feats, modGuid)) do
      FeatSubSectionHandler(feats, uuid, modGuid)
    end
  end
end
