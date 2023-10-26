local function ParseAndSubmitSubclasses(data, classId, modGuid)
  Utils.Info("Entering ParseAndSubmitSubclasses")
  local payloads = {}
  if Utils.IsGuid(classId) then
    classId = string.lower(DictUtils.RetrieveClassNameFromProgression(classId))
  end

  if data.UUIDs ~= nil then
    for _, uuid in pairs(data.UUIDs) do
      payloads.Insert = JsonUtils.BuildSubclassPayload(data, classId, modGuid, uuid)
    end
  elseif data.UUID ~= nil then
    payloads.Insert = JsonUtils.BuildSubclassPayload(data, classId, modGuid)
  end

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Subclass({ payload })
    end
  end
end

local function ProgressionSubSectionHandler(data, modGuid)
  if data.Subclasses ~= nil then
    for _, subclass in pairs(data.Subclasses) do
      ParseAndSubmitSubclasses(subclass, data.UUID, modGuid)
    end
  end

  if data.Selectors ~= nil then
    for _, selector in pairs(data.Selectors) do
      JsonUtils.ParseAndSubmitSelectors(selector, data.UUID, modGuid, "Progression")
    end
  end

  if data.Strings ~= nil then
    for _, strings in pairs(data.Strings) do
      JsonUtils.ParseAndSubmitStrings(strings, data.UUID, modGuid, "Progression")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, data.UUIT, modGuid, "Progression")
    end
  end
end

function ProgressionJsonHandler(data, modGuid)
  Utils.Info("Entering ProgressionJsonHandler")
  for _, progressions in pairs(data) do
    ProgressionSubSectionHandler(progressions, modGuid)
  end
end
