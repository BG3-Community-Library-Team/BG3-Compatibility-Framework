-- Subclass Definitions
local subClasses = {
  FeriatHexBlade = { -- Hexblade by Feriat111
    modGuid = "e1eb6d1a-5922-4964-bfd7-c971e71e351a",
    subClassGuid = "95f27fb1-7e7d-4ae3-ba42-17c2f11b4bc3",
    class = "warlock",
    subClassName = "Hexblade"
  },
  DreadOverlordNecromancer = { -- Necromancer/Dread Overlord by dreadoverlord
    modGuid = "2e686664-8fbb-4e08-9ec2-3eea5d0300ab",
    subClassGuid = "41297931-500e-4179-93b9-8c9754de424a",
    class = "warlock",
    subClassName = "Dread Overlord"
  },
  FluffyDragonCelestial = { -- Celestial by FluffyDragon24
    modGuid = "1d7bb32c-396d-11ee-be56-0242ac120002",
    subClassGuid = "1d7bb4b2-396d-11ee-be56-0242ac120002",
    class = "warlock",
    subClassName = "Celestial"
  },
  GladoffelLpRavenQueen = { -- The Raven Queen by GladoffelLp
    modGuid = "9d5e409f-5c4e-4c14-b1f3-6fd47c9359bf",
    subClassGuid = "7842f798-5354-4285-906f-ea2d4202aeff",
    class = "warlock",
    subClassName = "Raven Queen"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="warlock",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['warlock'] = "a7767dc5-e6ab-4e05-96fd-f0424256121c"
Globals.SupportedClassDict['mc_warlock'] = "20015e25-8aa9-41bf-b959-aa587ba0aa27"
