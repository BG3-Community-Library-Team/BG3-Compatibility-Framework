Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  BonebreakerGlamour = { -- College of Glamour by Bonebreaker687
    modGuid = "50b1fe7-4733-40bd-9506-5f5dd2bad616",
    subClassGuid = "3450a3cb-1831-4387-9214-70a9267b5a4b",
    class = "bard",
    subClassName = "College of Glamour"
  },
  DrozZhatPlayers = { -- College of Players by DroZzhat
    modGuid = "1be07b69-db2d-4df4-9f3f-1b00fd07e2cb",
    subClassGuid = "5c6d6be7-f302-4dfa-9545-3dc719f1abbd",
    class = "bard",
    subClassName = "College of Players"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="bard",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['bard'] = "26f64038-6033-48d5-9da7-38e8c95ce712"
