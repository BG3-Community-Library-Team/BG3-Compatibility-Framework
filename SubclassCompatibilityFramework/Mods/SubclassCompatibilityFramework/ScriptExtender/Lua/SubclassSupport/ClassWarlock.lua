Ext.Require("SubclassSupport/_SCF_Globals.lua")

-- Subclass Definitions
local subClasses = {
  FeriatHexBlade = { -- HexBlade by Feriat111
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
  }
}

if subClasses ~= nil then
    for _, subClass in pairs(subClasses) do
        table.insert(SCF_SupportedSubClasses, subClass)
    end
end

SCF_SupportedClassDict['warlock'] = "a7767dc5-e6ab-4e05-96fd-f0424256121c"
SCF_SupportedClassDict['mc_warlock'] = "20015e25-8aa9-41bf-b959-aa587ba0aa27"