Globals.ListTypes = {
  -- Abilities = "AbilityList",
  SpellList = "SpellList",
  SkillList = "SkillList",
  PassiveList = "PassiveList",
  -- Equipment = "EquipmentList",
  -- Colors = "ColorDefinition", Partially supported, figure out actual arrays
  -- CampChestTemplate = "CampChestTemplates"
}

Globals.ListNodes = {
  -- Abilities = "Abilities", Not Supported
  SpellList = "Spells",
  SkillList = "Skills",
  PassiveList = "Passives",
  -- Equipment = "EquipmentList", Not Supported
  -- Colors = "ColorDefinition", Partially supported, figure out actual arrays
}

Globals.SelectorFunctions = {
  SelectSpells = "SelectSpells",
  AddSpells = "AddSpells",
  SelectSkills = "SelectSkills",
  SelectPassives = "SelectPassives",
  SelectAbilities = "SelectAbilities",
  SelectAbilityBonus = "SelectAbilityBonus",
  SelectSkillsExpertise = "SelectSkillsExpertise",
  SelectEquipment = "SelectEquipment",
  ReplacePassives = "ReplacePassives"
}

Globals.SelectorIdTypes = {
  SelectSpells = "SpellUUID",
  AddSpells = "SpellUUID",
  SelectSkills = "UUID",
  SelectPassives = "UUID",
  SelectAbilityBonus = "UUID",
  SelectSkillsExpertise = "UUID",
  SelectEquipment = "UUID",
  ReplacePassives = "UUID"
}

Globals.StringTypes = {
  Boosts = "Boosts",
  PassivesAdded = "PassivesAdded",
  PassivesRemoved = "PassivesRemoved",
  Requirements = "Requirements"
}

Globals.FieldSeparator = {
  Boosts = ";",
  PassivesAdded = ";",
  PassivesRemoved = ";",
  Requirements = ";"
}

Globals.CacheTypes = {
  "Feat",
  "Progression"
}

Globals.BooleanTypes = {
  "AllowImprovement",       -- Progression
  "IsMulticlass",           -- Progression
  "CanBeTakenMultipleTimes" -- Feat
}

Globals.Attributes = {
  aSTR = "Strength",
  aDEX = "Dexterity",
  aCON = "Constitution",
  aINT = "Intelligence",
  aWIS = "Wisdom",
  aCHA = "Charisma"
}
