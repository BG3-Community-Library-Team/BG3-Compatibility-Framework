-- For adding Support to 1 or more Subclasses
function Api.InsertSubClasses(subClasses)
    if subClasses ~= nil then
        for _, subClass in pairs(subClasses) do
            --table.insert(Globals.SupportedSubClasses, subClass)
            if Ext.Mod.IsModLoaded(subClass.modGuid) then
              SubClassHandler(subClass.subClassGuid, subClass.class)
            end
        end
    end
end

-- For adding support to a Custom Class
function Api.InsertClass(className, classGuid)
    Globals.SupportedClassDict[className] = classGuid
    ProgressionHandler(className, classGuid)
end

--[[Api.InsertSelector = function (selector)
-- Selector: type, uuid, params
end]]--

--[[Api.InsertBoost = function (boost)

end]]--

--[[Api.InsertPassive = function (passive)

end]]--