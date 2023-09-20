-- For adding Support to 1 or more Subclasses
function Api.InsertSubClasses(subClasses)
  if subClasses ~= nil then
    for _, subClass in pairs(subClasses) do
      Utils.Info(Utils.Stringify(subClass))
      --table.insert(Globals.SupportedSubClasses, subClass)
      if Ext.Mod.IsModLoaded(subClass.modGuid) then
        SubClassHandler(subClass.subClassGuid, subClass.class)
      end
    end
  end
end

-- For adding support to a Custom Class
function Api.InsertClass(className, classGuid)
  Globals.ClassUUIDs[className] = classGuid
end

-- Additional endpoint to ensure support for classes with a level 1 subclass choice
function Api.InsertLevelOneProgression(className, classGuid)
  Globals.MulticlassClasses[className] = classGuid
end

function Api.InsertSelector(payloads)
  Utils.Error(Strings.UNFINISHED_API_WARNING)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleSelector(payload)
      end
    end
  end
end

--[[Api.InsertSelector = function (selector)
-- Selector: type, uuid, params
end]]
--

--[[Api.InsertBoost = function (boost)

end]]
--

--[[Api.InsertPassive = function (passive)

end]]
--
