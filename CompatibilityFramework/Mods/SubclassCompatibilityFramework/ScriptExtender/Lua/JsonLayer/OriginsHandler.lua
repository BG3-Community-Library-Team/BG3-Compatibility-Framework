
function OriginsSubSectionHandler(data, originUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering OriginsSubSectionHandler")
  if data.Tags ~= nil then
    for _, tag in pairs(data.Tags) do
      JsonUtils.ParseAndSubmitTags(tag, originUUID, modGuid, "Origin")
    end
  end

  if data.Fields ~= nil then
    for _, field in pairs(data.Fields) do
      JsonUtils.ParseAndSubmitFields(field, originUUID, modGuid, "Origin")
    end
  end

  if data.Strings ~= nil then
    for _, string in pairs(data.Strings) do
      JsonUtils.ParseAndSubmitStrings(string, originUUID, modGuid, "Origin")
    end
  end
end

function OriginJsonHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering OriginsHandler")

  for _, origin in pairs(data) do
    if origin.UUIDs ~= nil then
      for _, uuid in pairs(list.UUIDs) do
        OriginsSubSectionHandler(origin, uuid, modGuid)
      end
    else
      OriginsSubSectionHandler(origin, origin.UUID, modGuid)
    end
  end
end
