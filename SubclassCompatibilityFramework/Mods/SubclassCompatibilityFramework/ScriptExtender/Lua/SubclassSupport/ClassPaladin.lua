Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  YoshiDreams = { -- Oath of Conquest by havsglimt
    modGuid = "74b2a448-6771-4289-9393-d359c3b79596",
    subClassGuid = "d05d37d9-c702-4924-9e8d-5d5d7db19918",
    class = "paladin",
    subClassName = "Oath of Conquest"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="paladin",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['paladin'] = "b60618d1-c262-42b5-9fdd-2c0f7aa5e5af"
Globals.SupportedClassDict['mc_paladin'] = "1f5396ad-65e3-4ed5-a339-d76b11af96ea"
