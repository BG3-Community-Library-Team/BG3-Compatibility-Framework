function FeatJsonHandler(data, modGuid)
  Utils.Info("Entering FeatJsonHandler")
  for _, feat in pairs(data) do
    if feat.Selectors ~= nil then
      for _, selector in pairs(feat.Selectors) do
        JsonUtils.ParseAndSubmitSelectors(selector, feat.UUID, modGuid)
      end
    end

    if feat.Strings ~= nil then
      for _, strings in pairs(feat.strings) do
        JsonUtils.ParseAndSubmitStrings(strings, feat.UUID, modGuid, "Feat")
      end
    end
  end
end
