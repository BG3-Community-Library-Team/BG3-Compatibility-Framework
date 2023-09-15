Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  SneedDrunkenMaster = { -- Way of the Drunken Master by Johnny Sneed
    modGuid = "83e20b3d-75cc-4d9a-af04-430f797290e5",
    subClassGuid = "bbd5e265-82f5-403f-8141-887480d41bba",
    class = "monk",
    subClassName = "Way of the Drunken Master"
  },
  YuukaYunnaKensei = { -- Way of Kensei by YuukaYunna
    modGuid = "b4ff257e-7522-4fcd-b919-7dec4250dc36",
    subClassGuid = "dd9f59af-7b14-4d01-bb7a-cbb372ff0a7a",
    class = "monk",
    subClassName = "Way of Kensei"
  },
  PlatypusVenomMercy = {   -- Way of Mercy by PlatypusVenom
    modGuid = "c5343ccb-d1d8-4970-8a1d-c44203a6a55a",
    subClassGuid = "54bdda89-b5a1-4f4e-9366-3057b079613f",
    class = "monk",
    subClassName = "Way of Mercy"
  },
  YoshiSunSoul = {   -- Way of the Sun Soul by Kingdomyoshi
    modGuid = "b382793b-6161-42d2-a3fb-a4d69fa3a8e8",
    subClassGuid = "62db00d9-2298-43a3-9fd8-64cdfed3a0df",
    class = "monk",
    subClassName = "Way of the Sun Soul"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="monk",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['monk'] = "296468cb-3640-4460-9f44-b30ee820a9ed"
