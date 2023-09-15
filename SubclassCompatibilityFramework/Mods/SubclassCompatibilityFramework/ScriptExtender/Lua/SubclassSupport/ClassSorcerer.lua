Ext.Require("SubclassSupport/_SCF_Globals.lua")

-- Subclass Definitions
local subClasses = {
  BaaleosShadowSorcerer = { -- BG3ShadowSorcerer by Baaleos
    modGuid = "f48b2612-4d95-4601-b324-b8a07c9d90be",
    subClassGuid = "d007a7be-60c6-4606-87db-66eb9e247050",
    class = "sorcerer",
    subClassName = "Shadow Sorcerery"
  },
  CodyAbodeStoneSorcery = { -- Stone Sorcery by Cody Abode
  modGuid = "1be07b69-db2d-4df4-9f3f-1b00fd07e2cb",
  subClassGuid = "3c335f43-bae3-4468-9972-d9bdedca2a71",
  class = "sorcerer",
  subClassName = "Stone Sorcery"
},
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="sorcerer",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(SCF_SupportedSubClasses, subClass)
  end
end

SCF_SupportedClassDict['sorcerer'] = "42af9bda-9ac0-4564-920b-f9ca1588d6ee"
SCF_SupportedClassDict['mc_sorcerer'] = "e115c732-80b1-4ae1-bf04-cee44660d64f"
