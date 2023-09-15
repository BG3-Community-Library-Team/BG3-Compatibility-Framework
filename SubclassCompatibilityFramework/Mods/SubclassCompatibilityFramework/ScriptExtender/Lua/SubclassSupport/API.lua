Ext.Require("SubclassSupport/_Globals.lua")
Api = {}

-- For adding Support to 1 or more Subclasses
Api.InsertSubClass = function (subClasses)
    if subClasses ~= nil then
        for _, subClass in pairs(subClasses) do
            table.insert(Globals.SupportedSubClasses, subClass)
        end
    end
end

-- For adding support to a Custom Class
Api.InsertClass = function(classGuid, className)
    Globals.SupportedClassDict[className] = classGuid
end

--[[Api.InsertSelector = function (selector)
-- Selector: type, uuid, params
end]]--

--[[Api.InsertBoost = function (boost)

end]]--

--[[Api.InsertPassive = function (passive)

end]]--