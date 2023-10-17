local function setupClassLevelEntry(progression, lists, multiclassProgression)
  lists = lists or {}

  return {
    Progression = progression or "",
    MulticlassProgression = multiclassProgression or nil,
    AbilityLists = lists.AbilityLists or {},
    SpellLists = lists.SpellLists or {},
    PassiveLists = lists.PassiveLists or {},
    SkillLists = lists.SkillLists or {},
  }
end

local function setupSubclassEntry(uuid, levels)
  return {
    ClassId = uuid or "",
    Levels = levels or {}
  }
end

-- Barbarian
local baseBarbarianLevels = {
  One = setupClassLevelEntry("a2198ee9-ea4c-468e-b6b4-22b32d37806e", {
    AbilityLists = { "b9149c8e-52c8-46e5-9cb6-fc39301c05fe" },
    SkillLists = { "233793b3-838a-4d4e-9d68-1e0a1089aba5" }
  }),
  Two = setupClassLevelEntry("89986e8a-09b1-4163-b1d0-ddb2332bf3c5"),
  Three = setupClassLevelEntry("0d4a6b4b-8162-414b-81ef-1838e36e778a"),
  Four = setupClassLevelEntry("942265f9-bb74-4f9b-82e4-0c8c8036ac7f"),
  Five = setupClassLevelEntry("76654cf4-89a5-4255-8e2a-cd4d08df0fe4"),
  Six = setupClassLevelEntry("2c296206-6a78-4ff4-8b5e-a8ba7c62a62a"),
  Seven = setupClassLevelEntry("2ad3b99d-3dae-4c9e-b8b0-8d2e4e0da805"),
  Eight = setupClassLevelEntry("26c5e940-6f74-43a1-b46e-7eb98e211cf5"),
  Nine = setupClassLevelEntry("2b2be55c-8c01-4bcd-84ff-b4c9ca23faf8"),
  Ten = setupClassLevelEntry("38f50ca6-9511-4b32-81e6-bb9a8a941a3d"),
  Eleven = setupClassLevelEntry("37055929-9081-4337-831f-7ac427ef02fd"),
  Twelve = setupClassLevelEntry("d31c7f2f-52e6-4c83-8a7b-9f0b7b953a79")
}

local berserkerBarbarianLevels = {
  Three = setupClassLevelEntry("5ce67263-04f2-4ede-b30a-2eb962d828f2", {
    SpellLists = { "17803035-4762-4143-8f2f-1143d47e4f40" }
  }),
  Six = setupClassLevelEntry("27a1114c-3f84-4f47-8544-865e91db8d0f"),
  Ten = setupClassLevelEntry("ad9a37aa-bc2d-4024-9b5f-5aaf330cb25c", {
    SpellLists = { "38191b4b-743a-4d82-800b-c0903baece24" }
  })
}

local totemBarbarianLevels = {
  Three = setupClassLevelEntry("42329ce3-0fb3-43a3-a0b4-79584c6877e7", {
    SpellLists = { "4acd9ef6-719d-4248-90ae-0cb66da87c6a" },
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Four = setupClassLevelEntry("6777c3c3-5f17-4d49-8da7-0f0b8b380d06", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Five = setupClassLevelEntry("0fe6f4ec-8601-462d-a233-53fc0ad62513", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Six = setupClassLevelEntry("0b05af61-85e4-4183-8422-6c8ced307d7a", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf", "fb9ea4a2-a1ce-4242-a893-84a088ac1145" }
  }),
  Seven = setupClassLevelEntry("bbc1564b-4688-484f-84f3-1b3b02173bab", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Eight = setupClassLevelEntry("6de45010-ac1e-420d-ab84-31146c14dada", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Nine = setupClassLevelEntry("dfb1038e-9178-475e-abdc-19f0cba244cb", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Ten = setupClassLevelEntry("8013e565-55a5-4847-8ebc-e2971e25151e", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf", "fb9ea4a2-a1ce-4242-a893-84a088ac1145" }
  }),
  Eleven = setupClassLevelEntry("55fd65cf-928d-4ed6-b35e-76422bb0d196", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  }),
  Twelve = setupClassLevelEntry("7521f3eb-efa9-4d40-9f65-e6ff247a9ee8", {
    PassiveLists = { "7f7340a0-faf3-4122-bd3f-37a5434dd6cf" }
  })
}

local wildMagicBarbarianLevels = {
  Three = setupClassLevelEntry("9026e0b6-52a7-46b9-a318-d85b6a2a81c5", {
    SpellLists = { "6a27ea3e-ed94-4d90-9a27-109a902dd049" }
  }),
  Six = setupClassLevelEntry("7509026b-0ea3-40cb-a106-95977a40a3b7", {
    SpellLists = { "9e604f0f-ec60-402d-b8c8-7707a1caefd8" }
  }),
  Nine = setupClassLevelEntry("c6894048-1489-406d-b601-e3c8c96f4e42", {
    SpellLists = { "4e7b517a-2eca-4463-99a6-a5ffa5036216" }
  }),
  Ten = setupClassLevelEntry("3782ea9f-917b-4823-ba34-b619c76a4429")
}

-- Bard
local baseBardLevels = {

}

local loreBardLevels = {

}

local swordBardLevels = {

}
local valorBardLevels = {

}

-- Cleric
local baseClericLevels = {

}

local lifeClericLevels = {

}

local lightClericLevels = {

}

local knowledgeClericLevels = {

}

local natureClericLevels = {

}

local trickeryClericLevels = {

}

local tempestClericLevels = {

}

local warClericLevels = {

}

-- Druid
local baseDruidLevels = {

}

local landDruidLevels = {

}

local moonDruidLevels = {

}

local sporeDruidLevels = {

}
-- Fighter
local baseFighterLevels = {

}

local battleMasterFighterLevels = {

}

local championFighterLevels = {

}

local eldritchFighterLevels = {

}

-- Monk
local baseMonkLevels = {

}

local fourElementsMonkLevels = {

}

local openHandMonkLevels = {

}

local shadowsMonkLevels = {

}

-- Paladin
local basePaladinLevels = {

}

local ancientsPaladinLevel = {

}

local devotionPaladinLevel = {

}

local oathBreakerPaladinLevels = {

}

local vengeancePaladinLevels = {

}

-- Ranger
local baseRangerLevels = {

}

local beastMasterRangerLevels = {

}

local hunterRangerLevels = {

}

local gloomStalkerRangerLevels = {

}


-- Rogue
local baseRogueLevels = {

}

local arcaneTricksterRogueLevels = {
  
}

local assassinRogueLevels = {

}

local thiefRogueLevels = {

}

-- Sorcerer
local baseSorcererLevels = {

}

local draconicSorcererLevels = {

}

local stormSorcererLevels = {

}

local wildMagicSorcererLevels = {

}

-- Warlock
local baseWarlockLevels = {

}

local archFeyWarlockLevels = {

}

local fiendWarlockLevels = {

}

local greatOldOneWarlockLevels = {

}

-- Wizard
local baseWizardLevels = {

}

local abjurationWizardLevels = {

}

local conjurationWizardLevels = {

}

local divinationWizardLevels = {

}

local enchantmentWizardLevels = {

}

local evocationWizardLevels = {

}

local illusionWizardLevels = {

}

local necromancyWizardLevels = {

}

local transmutationWizardLevels = {

}

Globals.ClassDict.Barbarian = {
  Base = setupSubclassEntry("d8cadb42-0ff9-4049-afaf-e5d78d06a399", baseBarbarianLevels),
  Berserker = setupSubclassEntry("32eee7d8-1b2f-4de5-b9ee-78fbd286c6ef", berserkerBarbarianLevels),
  Totem = setupSubclassEntry("2e585948-d775-451d-b58b-15b75321d11e", totemBarbarianLevels),
  WildMagic = setupSubclassEntry("d6bf00fc-3518-4d63-ba8b-03532c1abc4d", wildMagicBarbarianLevels)
}

Globals.ClassDict.Bard = {
  Base = setupSubclassEntry("92cd50b6-eb1b-4824-8adb-853e90c34c90", baseBardLevels),
  Lore = setupSubclassEntry("d21368ac-c776-465c-9dcf-6123dd52734f", loreBardLevels),
  Sword = setupSubclassEntry("c4bd5252-d68a-4330-9431-5e8ab24c5f29", swordBardLevels),
  Valor = setupSubclassEntry("2b46330d-0ada-4eb5-a131-3d250a41ca6a", valorBardLevels)
}

Globals.ClassDict.Cleric = {
  Base = setupSubclassEntry("114e7aee-d1d4-4371-8d90-8a2080592faf", baseClericLevels),
  Life = setupSubclassEntry("4b5da2f5-b999-4623-8bff-a63df5560fb3", lifeClericLevels),
  Light = setupSubclassEntry("c54d7591-b305-4f22-b2a7-1bf5c4a3470a", lightClericLevels),
  Knowledge = setupSubclassEntry("ebe18794-b5e1-41c4-befa-4b9d6922b0ec", knowledgeClericLevels),
  Nature = setupSubclassEntry("6dec76d0-df22-411c-8a78-3d6fb843ae50", natureClericLevels),
  Trickery = setupSubclassEntry("f013d01b-3310-43f7-81bf-a51130442b5e", trickeryClericLevels),
  Tempest = setupSubclassEntry("89bacf1b-8f15-4972-ada7-bf59c7c78441", tempestClericLevels),
  War = setupSubclassEntry("b9ccf90e-b35b-4b73-b896-8ed2d32ae8c6", warClericLevels)
}

Globals.ClassDict.Druid = {
  Base = setupSubclassEntry("457d0a6e-9da8-4f95-a225-18382f0e94b5", baseDruidLevels),
  Land = setupSubclassEntry("7458da78-34b7-4150-a42f-37197ab04510", landDruidLevels),
  Moon = setupSubclassEntry("3eab0689-e51b-4634-a690-0375d3cb2716", moonDruidLevels),
  Spore = setupSubclassEntry("4b61af6c-4a44-436e-aa0a-0d11a2d6b8ee", sporeDruidLevels)
}

Globals.ClassDict.Fighter = {
  Base = setupSubclassEntry("721dfac3-92d4-41f5-b773-b7072a86232f", baseFighterLevels),
  BattleMaster = setupSubclassEntry("e668c6f1-5149-4b10-ab7e-3637ed444066", battleMasterFighterLevels),
  Champion = setupSubclassEntry("22894c32-54cf-49ea-b366-44bfcf01bb2a", championFighterLevels),
  EldritchKnight = setupSubclassEntry("b722614a-303f-411a-bb19-a1882ad1f4cc", eldritchFighterLevels)
}

Globals.ClassDict.Monk = {
  Base = setupSubclassEntry("c4598bdb-fc07-40dd-a62c-90cc138bd76f", baseMonkLevels),
  FourElements = setupSubclassEntry("22894c32-54cf-49ea-b366-44bfcf01bb2a", fourElementsMonkLevels),
  OpenHand = setupSubclassEntry("2a5e3097-384c-4d29-8d6e-054fdfd26b80", openHandMonkLevels),
  Shadows = setupSubclassEntry("bf46d73f-d406-4cb8-9a1d-e6e758ca02c7", shadowsMonkLevels)
}

Globals.ClassDict.Paladin = {
  Base = setupSubclassEntry("ff4d9497-023c-434a-bd14-82fc367e991c", basePaladinLevels),
  Ancients = setupSubclassEntry("b36d247e-d39f-4ae9-9476-3ec315c55789", ancientsPaladinLevel),
  Devotion = setupSubclassEntry("1c761ad0-6f5f-409e-ac1d-ddf6f85c1fc4", devotionPaladinLevel),
  Vengeance = setupSubclassEntry("3cc3d397-c47d-4966-87ae-88827f73f645", vengeancePaladinLevels),
  OathBreaker = setupSubclassEntry("6fb3831e-45d8-4b30-9714-6fe73988921b", oathBreakerPaladinLevels)
}

Globals.ClassDict.Ranger = {
  Base = setupSubclassEntry("36be18ba-23db-4dff-bfa6-ae105ce43144", baseRangerLevels),
  BeastMaster = setupSubclassEntry("6fd9547d-cc28-400e-bfa9-3a85baa70f24", beastMasterRangerLevels),
  Hunter = setupSubclassEntry("0aa1cff9-c45f-4d00-a95b-99a7aa96dd06", hunterRangerLevels),
  GloomStalker = setupSubclassEntry("d5f10e55-84e3-409b-aa64-2098c9550319", gloomStalkerRangerLevels)
}

Globals.ClassDict.Rogue = {
  Base = setupSubclassEntry("e8b1eab0-ef11-40a2-8a0b-cee8d062bf2a", baseRogueLevels),
  ArcaneTrickster = setupSubclassEntry("ede4778e-7602-440f-9075-b4bc8dc31cea", arcaneTricksterRogueLevels),
  Assassin = setupSubclassEntry("b53a8061-f31d-4985-adfe-d4d691a918d9", assassinRogueLevels),
  Thief = setupSubclassEntry("32c7b8df-a6ec-4848-a9db-c0dce781beb9", thiefRogueLevels)
}

Globals.ClassDict.Sorcerer = {
  Base = setupSubclassEntry("784001e2-c96d-4153-beb6-2adbef5abc92", baseSorcererLevels),
  Draconic = setupSubclassEntry("36286b0a-26f9-4b4e-9311-fd1404301d20", draconicSorcererLevels),
  Storm = setupSubclassEntry("d379fdae-b401-4731-8d50-277c73919ae3", stormSorcererLevels),
  WildMagic = setupSubclassEntry("14374d37-a70e-41a8-9dc5-85a23f8b5dd2", wildMagicSorcererLevels)
}

Globals.ClassDict.Warlock = {
  Base = setupSubclassEntry("b4225a4b-4bbe-4d97-9e3c-4719dbd1487c", baseWarlockLevels),
  ArchFey = setupSubclassEntry("733ddf8c-9ec4-4c5a-85e3-c70fd3df3c24", archFeyWarlockLevels),
  Fiend = setupSubclassEntry("8866db28-7dda-4fd6-93ed-20eca16314f0", fiendWarlockLevels),
  GreatOldOne = setupSubclassEntry("e1e4a21f-9405-46ec-81a0-ccc8d58d9736", greatOldOneWarlockLevels)
}

Globals.ClassDict.Wizard = {
  Base = setupSubclassEntry("a865965f-501b-46e9-9eaa-7748e8c04d09", baseWizardLevels),
  Abjuration = setupSubclassEntry("e6a0eb75-7a01-4f40-8563-24ba2615e99b", abjurationWizardLevels),
  Conjuration = setupSubclassEntry("7a3feb8d-dda7-46ec-9029-1f302f537432", conjurationWizardLevels),
  Divination = setupSubclassEntry("7577b0e1-a517-4f82-8f72-05a227dc5e88", divinationWizardLevels),
  Enchantment = setupSubclassEntry("46d31950-6917-444e-ac87-706702825215", enchantmentWizardLevels),
  Evocation = setupSubclassEntry("c059dca1-c17d-4dce-8260-83ede5070eac", evocationWizardLevels),
  Illusion = setupSubclassEntry("436c9e1a-3a39-48dd-b753-7cee1bd19c00", illusionWizardLevels),
  Necromancy = setupSubclassEntry("fbb8347b-20e3-4846-ba91-0552cd12fc5f", necromancyWizardLevels),
  Transmutation = setupSubclassEntry("a12f2924-30b4-4185-9db9-2c5b383ff449", transmutationWizardLevels),
}
