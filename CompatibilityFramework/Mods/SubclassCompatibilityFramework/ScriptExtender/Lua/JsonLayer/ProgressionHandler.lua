local function ParseAndSubmitSubclasses(data, modGuid)
  Utils.Info("Entering ParseAndSubmitSubclasses")
  local payloads = {
    Insert = JsonUtils.BuildRacePayloads(data, modGuid)
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Subclass({ payload })
    end
  end
end

local function ProgressionSubSectionHandler(data, modGuid)
  if data.Subclasses ~= nil then
    for _, subclass in pairs(data.Subclasses) do
      ParseAndSubmitSubclasses(subclass, modGuid)
    end
  end

  if data.Selectors ~= nil then
    for _, selector in pairs(data.Selectors) do
      JsonUtils.ParseAndSubmitSelectors(selector, data.UUID, modGuid, "Progression")
    end
  end

  if data.Strings ~= nil then
    for _, strings in pairs(data.strings) do
      JsonUtils.ParseAndSubmitStrings(strings, data.UUID, modGuid, "Progression")
    end
  end
end

function ProgressionJsonHandler(data, modGuid)
  Utils.Info("Entering ProgressionJsonHandler")
  for _, progressions in pairs(data) do
    ProgressionSubSectionHandler(progressions, modGuid)
  end
end
