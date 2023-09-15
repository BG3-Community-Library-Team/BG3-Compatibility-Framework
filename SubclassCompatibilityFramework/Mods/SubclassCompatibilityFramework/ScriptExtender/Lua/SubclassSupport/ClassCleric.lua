-- Subclass Definitions
local subClasses = {
  BaltaviArcana = { -- Arcana Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "e7fc0b04-a1b6-4539-af0e-f309a76d2427",
      class = "cleric",
      subClassName = "Arcana Domain"
  },
  CrackerJackDeathDomain = { -- Death Domain by CrackerJackGCO
      modGuid = "36ffab06-d6b3-4cbb-8e9f-f16a01c06473",
      subClassGuid = "e64c5974-b64b-42b7-b86d-2fb368ae9d33",
      class = "cleric",
      subClassName = "Death Domain (crackerjack)"
  },
  BaltaviDeathDomain = { -- Death Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "f0f90719-e27a-403a-b891-4d739b4bf589",
      class = "cleric",
      subClassName = "Death Domain (baltavi)"
  },
  BaltaviForgeDomain = { -- Forge Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "af5d4ccc-e144-41aa-9c92-325618fb1a76",
      class = "cleric",
      subClassName = "Forge Domain"
  },
  BaltaviGraveDomain = { -- Grave Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "394a1640-4c1d-49e3-aedd-7cc4fa38fd0e",
      class = "cleric",
      subClassName = "Grave Domain"
  },
  BaltaviOrderDomain = { -- Order Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "4d6f7d28-2f87-4012-aab2-71045c1f61ad",
      class = "cleric",
      subClassName = "Order Domain"
  },
  BaltaviPeaceDomain = { -- Peace Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "edf303e8-f04b-4e7b-96f1-97624c977822",
      class = "cleric",
      subClassName = "Peace Domain"
  },
  BaltaviTwilightDomain = { -- Twilight Domain by baltavi
      modGuid = "eef7b885-1423-4096-abd6-7a5db5f871db",
      subClassGuid = "828350d9-d916-48fa-ad87-a531c03099cc",
      class = "cleric",
      subClassName = "Twilight Domain"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="cleric",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
    for _, subClass in pairs(subClasses) do
        table.insert(Globals.SupportedSubClasses, subClass)
    end
end

Globals.SupportedClassDict['cleric'] = "1dbce574-fff1-49be-b7da-704f9b73cad9"
Globals.SupportedClassDict['mc_cleric'] = "366cde9c-db0c-43ce-a49c-fb140e084b3c"