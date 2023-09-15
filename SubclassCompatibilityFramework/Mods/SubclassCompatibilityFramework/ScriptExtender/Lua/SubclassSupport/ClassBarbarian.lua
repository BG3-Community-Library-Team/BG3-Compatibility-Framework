Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  -- Add your own!,
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="barbarian",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
    for _, subClass in pairs(subClasses) do
        table.insert(Globals.SupportedSubClasses, subClass)
    end
end

Globals.SupportedClassDict['barbarian'] = "0d4a6b4b-8162-414b-81ef-1838e36e778a"
