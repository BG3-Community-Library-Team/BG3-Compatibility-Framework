Ext.Require("SubclassSupport/_SCF_Globals.lua")

-- Subclass Definitions
local subClasses = {
  ShivasShadowArcaneArcher = { -- Arcane Archer by ShivasShadow
    modGuid = "f1d9a7e0-7b48-4e36-abf5-ce2e312f7ee4",
    subClassGuid = "a86356c9-9fdf-45fb-912f-9b0d4ca0c32c",
    class = "fighter",
    subClassName = "Arcane Archer"
  },
  BackBurnerArtfulDodger = { -- Artful Dodger by Backburner26
    modGuid = "be37a0e6-f2bc-46f3-b98d-8cfbe977053a",
    subClassGuid = "ae652c3b-f9e1-4ff7-9419-344e8d9f922d",
    class = "fighter",
    subClassName = "Artful Dodger"
  },
  BackBurnerCombatMedic = { -- Combat Medic by Backburner26
    modGuid = "be37a0e6-f2bc-46f3-b98d-8cfbe977053a",
    subClassGuid = "c0af79a7-67d2-4a20-acd4-b0ee331ca5ad",
    class = "fighter",
    subClassName = "Combat Medic"
  },
  AfftorMarksman = { -- Marksman by afftor
    modGuid = "322ec70a-0bdc-444a-9ac2-edddfa837008",
    subClassGuid = "a9d9450b-52e3-4412-8559-322b6f5f7d7d",
    class = "fighter",
    subClassName = "Marksman"
  },
  BackBurnerPsychopath = { -- Psychopath by Backburner26
    modGuid = "be37a0e6-f2bc-46f3-b98d-8cfbe977053a",
    subClassGuid = "082e45c3-f102-42ea-8241-dd6fbd6bc307",
    class = "fighter",
    subClassName = "Psychopath"
  },
  ShivasShadowRuneKnight = { -- Rune Knight by ShivasShadow
    modGuid = "fe0f0a6b-8c7c-40a2-bf12-af6f06ae3172",
    subClassGuid = "0d0dc5c4-3bba-40a1-bb92-822bc41d8a9a",
    class = "fighter",
    subClassName = "Rune Knight"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="fighter",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(SCF_SupportedSubClasses, subClass)
  end
end

SCF_SupportedClassDict['fighter'] = "23eacff0-9efe-4ea6-b031-19075cc96b63"
