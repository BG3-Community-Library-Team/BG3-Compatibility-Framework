Ext.Require("SubclassSupport/_Globals.lua")

-- Subclass Definitions
local subClasses = {
  LostSoulInquisitive = { -- Inquisitive by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "30fa5210-8dac-4c7a-902c-453375ee31e2",
    class = "rogue",
    subClassName = "Inquisitive (lostsoulman)"
  },
  YoshiInquisitive = { -- Inquisitive by Kingdomyoshi
    modGuid = "5a470936-d860-4c5e-b3db-b7cd90ac7f13",
    subClassGuid = "dd277e29-a530-433f-92b8-3a1a212fcc88",
    class = "rogue",
    subClassName = "Inquisitive (yoshi)"
  },
  LostSoulMastermind = { -- Mastermind by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "eeaf288b-96d4-474a-b061-8cdcb7f1aa8d",
    class = "rogue",
    subClassName = "Mastermind (lostsoulman)"
  },
  YoshiMastermind = { -- Mastermind by Kingdomyoshi
    modGuid = "2c843f62-da26-4c97-ae08-f774d1ca37e6",
    subClassGuid = "c869ae04-2560-463d-9fab-9c25411ee038",
    class = "rogue",
    subClassName = "Mastermind (yoshi)"
  },
  LostSoulPhantom = { -- Phantom by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "e4d07723-a782-4c77-8907-c225724e8cb2",
    class = "rogue",
    subClassName = "Phantom"
  },
  LostSoulScout = { -- Scout by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "77b17b01-df39-474d-bfe8-34678ea5277f",
    class = "rogue",
    subClassName = "Scout"
  },
  LostSoulSoulKnife = { -- Soulknife by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "fdc1d56d-17b5-4830-ab40-d49330b87b4b",
    class = "rogue",
    subClassName = "Soulknife"
  },
  LostSoulSwashbuckler = { -- Swashbuckler by lostsoulman
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "5f88f78b-2884-4434-9a7a-27c961183b15",
    class = "rogue",
    subClassName = "Swashbuckler (lostsoulman)"
  },
  WesslenSwashbuckler = { -- Swashbuckler by wesslen
    modGuid = "0f5d4cc4-4fa7-42a9-9a1b-e676244f940a",
    subClassGuid = "e23f6e6b-7317-4f1c-90d5-f40bd9f2fbe1",
    class = "rogue",
    subClassName = "Swashbuckler (wesslen)"
  },
  WesslenSwashbucklerStar = { -- Swashbuckler* by wesslen
    modGuid = "b986a6b0-6755-496c-8ea8-0fbee6b66026",
    subClassGuid = "32c7b8df-a6ec-4848-a9db-c0dce781beb9",
    class = "rogue",
    subClassName = "Swashbuckler* (wesslen)"
  },
--[[
  MySubclass = {
    modGuid = "GUID from your meta.lsx file",
    suibClassGuid = "UUID from your CLassDescription",
    class ="rogue",
    subClassName = "Localized Name of Subclass for sorting"
  }
]] --
}

if subClasses ~= nil then
  for _, subClass in pairs(subClasses) do
    table.insert(Globals.SupportedSubClasses, subClass)
  end
end

Globals.SupportedClassDict['rogue'] = "6f8d3e70-9b20-4fe0-914f-0f8f19206329"
