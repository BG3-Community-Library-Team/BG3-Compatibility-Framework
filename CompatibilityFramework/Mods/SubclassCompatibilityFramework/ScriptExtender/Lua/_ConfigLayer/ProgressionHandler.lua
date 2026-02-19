local function ParseAndSubmitSubclasses(data, classId, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitSubclasses")
  if data.Action ~= "Remove" then
    local modGuidVal = modGuid or data.modGuid
    local modHandle = CLUtils.RetrieveModHandleAndAuthor(modGuidVal)
    if modGuidVal ~= nil and not modHandle ~= CLStrings.WARN_GUID_NOT_DEFINED and not CLUtils.IsInTable(Globals.Deprecated.SubclassJSON, modHandle) then
      table.insert(Globals.Deprecated.SubclassJSON, modHandle)
    end
    return
  end
  if CLUtils.IsGuid(classId) then
    local className = CLDictUtils.RetrieveClassNameFromProgression(classId)

    if className and type(className) ~= "nil" then
      classId = string.lower(className)
    end
  end
  if data.UUIDs ~= nil then
    for _, subclass in pairs(data.UUIDs) do
      JsonUtils.Endpoints.Remove.Subclass({ JsonUtils.BuildSubclassPayload(data, classId, modGuid, subclass) })
    end
  else
    JsonUtils.Endpoints.Remove.Subclass({ JsonUtils.BuildSubclassPayload(data, classId, modGuid) })
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

function ProgressionDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ProgressionDataHandler")
  for _, progressions in pairs(data) do
    if progressions.UUIDs ~= nil then
      for _, uuid in pairs(progressions.UUIDs) do
        ProgressionSubSectionHandler(progressions, uuid, modGuid)
      end
    elseif type(progressions.UUID) == "table" then
      -- Error in JSON  Config format, we'll catch it gracefully, but inform users/authors that it's an error
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) .. Strings.VAL_ERR_UUID_IS_TABLE .. table.concat(progressions.UUID, (", ")) .. Strings.VAL_ERR_UUID_IS_TABLE_B)
      for _, uuid in pairs(progressions.UUID) do
        ProgressionSubSectionHandler(progressions, uuid, modGuid)
      end
    elseif progressions.UUID ~= nil then
      ProgressionSubSectionHandler(progressions, progressions.UUID, modGuid)
    end
  end
end
