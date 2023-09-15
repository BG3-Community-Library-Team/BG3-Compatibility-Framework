Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  ShivasShadowArcaneArcher = { -- Arcane Archer by ShivasShadow
    modGuid = "38c4c12d-f325-4493-8fd7-fac1d63fdace",
    subClassGuid = "a86356c9-9fdf-45fb-912f-9b0d4ca0c32c",
    class = "ranger",
    subClassName = "Arcane Archer"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="ranger",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['ranger'] = "e6179c57-47e9-4f83-831e-28b73f4b5d0d"
