-- Subclass Definitions
local subClasses = {
  DizBladesinger = { -- Bladesinger by DiZ91891
    modGuid = "a2c4b0fc-e745-41df-81b7-fa53950d86a0",
    subClassGuid = "3fd79523-a973-4373-a973-732344acc959",
    class = "wizard",
    subClassName = "Bladesinging"
  },
  FmsetteSorcery = { -- Sorcery Arcane Tradition by fmsette
    modGuid = "48c0e450-6d12-4308-8c12-a0f24077339b",
    subClassGuid = "6aa381bc-3dc2-11ee-be56-0242ac120002",
    class = "wizard",
    subClassName = "Sorcery"
  },
  FierrofWarMagic = {   -- War Magic by fierrof
    modGuid = "be37a0e6-f2bc-46f3-b98d-8cfbe977053a",
    subClassGuid = "bec3ead5-a59a-4241-b778-27fb17f28e54",
    class = "wizard",
    subClassName = "War Magic"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="wizard",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['wizard'] = "d6184c47-5b99-4e63-95ac-02f8ce4ccda1"
