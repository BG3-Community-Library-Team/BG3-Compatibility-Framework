Globals.ModuleTypes = {
  Progression = "Progressions",
  Feat = "Feats",
  List = "Lists",
  Race = "Races"
}

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
  "AllowImprovement",           -- Progression
  "IsMulticlass",               -- Progression
  "CanBeTakenMultipleTimes",    -- Feat
  "HasGod",                     -- ClassDescriptions
  "CanLearnSpells",             -- ClassDescriptions
  "MustPrepareSpells",          -- ClassDescriptions
  "IsDefaultForUseSpellAction", -- ClassDescriptions
  "IsSomaticWithInstrument",    -- ClassDescriptions
  "AppearanceLocked",           -- Origins
  "IsHenchman",                 -- Origins
  "LockClass",                  -- Origins
  "LockRace",                   -- Origins
  "Unique",                     -- Origins
  "ShowOnActionResourcePanel",  -- ActionResourceDefinition
  "IsSpellResource",            -- ActionResourceDefinition
  "PartyActionResource",        -- ActionResourceDefinition
  "UpdatesSpellPowerLevel",     -- ActionResourceDefinition
  "IsHidden",                   -- ActionResourceDefinition
  "Hidden",                     -- ConditionErrors, ProgressionDescription
  "CharacterCreationSet",       -- CharacterCreationAccessorySet
  "MeshIsTwoSided",             -- CharacterCreationEquipmentIcon
  "IsDefault",                  -- CustomDice
  "Default",                    -- RulesetModifier
  "Value",                      -- RulesetValue
  "FootstepsType",              -- Rule
  "MuteEquipmentSound",         -- Rule
  "WildShapeHotBar",            -- Rule
  "UseShapeshiftIdentity",      -- Rule
  "RetainDisplayName",          -- Rule
  "MuteEquipmentSound",         -- Rule
  "IgnoreCustomLooks",          -- Rule
  "DisableEquipmentSlots",      -- Rule
  "UseTemplateEquipmentSet",    -- Rule
  "ChangeRace",                 -- Rule
  "ChangeIcon",                 -- Rule
  "ChangeBodyType",             -- Rule
  "ApplyVisual",                -- Rule
  "ApplyTagsFromTemplate",      -- Rule
  "ApplySpellsFromTemplate",    -- Rule
  "RemovePrevSpells",           -- Rule
  "UnarmedAbilityFromTemplate", -- Rule
  "BaseACOverride",             -- Rule
  "RetainDisplayName",          -- Rule
  "BlockLevelUp",               -- Rule
  "RemoveOldTags",              -- Rule
  "ChangeAi",                   -- Rule
  "KillEntityAtZeroHP",         -- Rule
  "RetainCanSeeThrough",        -- Rule
  "RetainCanShootThrough",      -- Rule
  "RetainCanWalkThrough",       -- Rule
  "OverrideSwitch",             -- TagSoundState/FlagSoundState
  "DefaultSwitch",              -- TagSoundState/FlagSoundState
  "OverrideOriginalCondition",  -- MetaCondition
  "BlockVocals",                -- StatusSoundState
  "RandomRotation",             -- ItemWallTemplates
  "NeedsHalfIllithidToUnlock"   -- TadpolePowerNode
}

Globals.Attributes = {
  aSTR = "Strength",
  aDEX = "Dexterity",
  aCON = "Constitution",
  aINT = "Intelligence",
  aWIS = "Wisdom",
  aCHA = "Charisma"
}

-- Mods that loaded too late to join the queue
Globals.LateLoaders = {}
