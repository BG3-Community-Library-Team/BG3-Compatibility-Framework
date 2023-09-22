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

function Api.InsertSelectors(payloads)
    if payloads ~= nil then
        for _, payload in pairs(payloads) do
            Utils.Info(Utils.Stringify(payload))

            if Ext.Mod.IsModLoaded(payload.modGuid) then
                HandleSelector(payload)
            end
        end
    end
end

-- Whoops, we provided someone with the wrong Endpoint. Here's to making things right.:
function Api.InsertSelector(payloads)
  Api.InsertSelectors(payloads)
end

-- Use only for debugging, this will enable Debug across the Framework
function Api.ToggleDebug(bool)
  Globals.Debug = bool
end

--[[Api.InsertBoost = function (boost)

end]]
--

--[[Api.InsertPassive = function (passive)

end]]
--
