
function ClassDescriptionSubSectionHandler(data, classUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ClassDescriptionSubSectionHandler")
  if data.Blacklist ~= nil then
    JsonUtils.ParseAndSubmitClassBlacklist(classUUID, data, modGuid)
  end
end

function ClassDescriptionJsonHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ClassDescriptionJsonHandler")

  for _, class in pairs(data) do
    if class.UUIDs ~= nil then
      for _, uuid in pairs(list.UUIDs) do
        ClassDescriptionSubSectionHandler(class, uuid, modGuid)
      end
    else
      ClassDescriptionSubSectionHandler(class, class.UUID, modGuid)
    end
  end
end
