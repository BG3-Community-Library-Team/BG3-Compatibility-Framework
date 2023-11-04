local function ParseAndSubmitSubclasses(data, classId, modGuid)
  Utils.Info("Entering ParseAndSubmitSubclasses")
  if Utils.IsGuid(classId) then
    classId = string.lower(DictUtils.RetrieveClassNameFromProgression(classId))
  end
  if data.UUIDs ~= nil then
    for _, subclass in pairs(data.UUIDs) do
      JsonUtils.Endpoints.Insert.Subclass({ JsonUtils.BuildSubclassPayload(data, classId, modGuid, subclass) })
    end
  else
    JsonUtils.Endpoints.Insert.Subclass({ JsonUtils.BuildSubclassPayload(data, classId, modGuid) })
  end
end

local function ProgressionSubSectionHandler(data, progUUID, modGuid)
  if data.Subclasses ~= nil then
    for _, subclass in pairs(data.Subclasses) do
      ParseAndSubmitSubclasses(subclass, progUUID, modGuid)
    end
  end

  if data.Selectors ~= nil then
    for _, selector in pairs(data.Selectors) do
      JsonUtils.ParseAndSubmitSelectors(selector, progUUID, modGuid, "Progression")
    end
  end

  if data.Strings ~= nil then
    for _, strings in pairs(data.Strings) do
      JsonUtils.ParseAndSubmitStrings(strings, progUUID, modGuid, "Progression")
    end
  end

  if data.Booleans ~= nil then
    for _, boolean in pairs(data.Booleans) do
      JsonUtils.ParseAndSubmitBoolean(boolean, progUUID, modGuid, "Progression")
    end
  end
end

function ProgressionJsonHandler(data, modGuid)
  Utils.Info("Entering ProgressionJsonHandler")
  for _, progressions in pairs(data) do
    if progressions.UUIDs ~= nil then
      for _, uuid in pairs(progressions.UUIDs) do
        ProgressionSubSectionHandler(progressions, uuid, modGuid)
      end
    elseif progressions.UUID ~= nil then
      ProgressionSubSectionHandler(progressions, progressions.UUID, modGuid)
    end
  end
end
