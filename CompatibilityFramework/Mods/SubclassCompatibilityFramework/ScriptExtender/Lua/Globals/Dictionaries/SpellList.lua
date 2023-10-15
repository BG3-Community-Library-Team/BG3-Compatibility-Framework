Globals.SpellLists = {}

local function setupClass()
  local result = {
    Cantrips = {},
    Spells = {}
  }

  return result
end

local function ClassSpellList(name, subclasses)
  Globals.SpellLists[name] = {
    Base = setupClass()
  }

  for _, val in pairs(subclasses) do
    Globals.SpellLists[name][val] = setupClass()
  end

  return Globals.SpellLists[name]
end

local function InsertField(obj, fieldObj)
  obj = obj or {}
  for key, value in pairs(fieldObj) do
    obj[key] = value
  end
end

local barbarian = ClassSpellList("Barbarian", { "Berserker", "WildMagic", "WildShape" })
local bard = ClassSpellList("Bard", { "Lore", "Sword", "Valor" })
local cleric = ClassSpellList("Cleric", { "Life", "Light", "Knowledge", "Nature", "Tempest", "Trickery", "War" })
local druid = ClassSpellList("Druid", { "Moon", "Land", "Spore" })
local fighter = ClassSpellList("Fighter", { "Champion", "BattleMaster", "EldritchKnight" })
local monk = ClassSpellList("Monk", { "OpenHand", "Shadows", "FourElements" })
local paladin = ClassSpellList("Paladin", { "Ancients", "Devotion", "Vengeance", "Oathbreaker" })
local ranger = ClassSpellList("Ranger", { "BeastMaster", "Hunter", "GloomStalker"})
local rogue = ClassSpellList("Rogue", { "Thief", "Assassin", "ArcaneTrickster" })
local sorcerer = ClassSpellList("Sorcerer", {"Draconic", "Storm", "WildMagic"})
local wizard = ClassSpellList("Wizard", { "Abjuration", "Conjuration", "Divination", "Enchantment", "Evocation", "Illusion", "Necromancy", "Transmutation" })
local warlock = ClassSpellList("Warlock", { "Fiend", "GreatOldOne", "ArchFey" })

InsertField(barbarian.Berserker.Spells, { Ten = "38191b4b-743a-4d82-800b-c0903baece24" })
InsertField(barbarian.WildMagic.Spells, {
  Three = "6a27ea3e-ed94-4d90-9a27-109a902dd049",
  Six = "9e604f0f-ec60-402d-b8c8-7707a1caefd8",
  Nine = "4e7b517a-2eca-4463-99a6-a5ffa5036216"
})
InsertField(wizard.Base, { ArcaneRecovery = "34c3321d-75ab-4b50-a44d-cbac8705a360" })
InsertField(bard.Base, { CounterCharm = "d84fc8ab-293e-437f-9825-e3e313f78060", MagicalSecrets = {} })
InsertField(bard.Base.Spells, {
  Two = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Three = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Four = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Five = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Six = "586a8796-34f4-41f5-a3ef-95738561d55d"
})
InsertField(bard.Base.MagicalSecrets, { Three = "65ad9f94-0cbf-4c79-9ffb-7fb9c19f9a50" })


InsertField(cleric.Base.Spells, {
  One = "269d1a3b-eed8-4131-8901-a562238f5289",
  Two = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
  Three = "21be0992-499f-4c7a-a77a-4430085e947a"
})
InsertField(cleric.Life.Spells, {
  One = "26ffbe70-23c6-4918-9e6a-a3e556a9d355",
  Two = "bbaf0bab-b0b3-44c9-a567-304e35c063c9",
  Five = "a9ff6ed3-050e-4963-b37b-c083285d6214"
})
InsertField(cleric.Light.Spells, {
  One = "e2464518-2484-436e-9153-864c9dd05a7d",
  Two = "31037493-7a57-4dce-9412-4689c010199c",
  Five = "1a50d25a-27b5-4789-b2d6-532fac4437c6"
})
InsertField(cleric.Trickery.Spells, {
  One = "98ef625f-d127-4fc3-8e37-37a4b27e6393",
  Two = "9f603ac8-2e51-4ce9-b924-c8093148bdf5",
  Five = "8a9faf7a-aacf-43f4-a0dd-5ea7e72449f3"
})
cleric.Base.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Life.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Light.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Trickery.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Base.Cantrips = "2f43a103-5bf1-4534-b14f-663decc0c525"

wizard.Base.Cantrips = "3cae2e56-9871-4cef-bba6-96845ea765fa"
InsertField(wizard.Base.Spells, {
  One = "11f331b0-e8b7-473b-9d1f-19e8e4178d7d",
  Two = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Three = "22755771-ca11-49f4-b772-13d8b8fecd93"
})

warlock.Base.Cantrips = "f5c4af9c-5d8d-4526-9057-94a4b243cd40"
InsertField(warlock.Fiend.Spells, {
  One = "4823a292-f584-4f7f-8434-6630c72e5411",
  Two = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
  Three = "5dec41aa-f16a-434e-b209-50c07e64e4ed"
})
InsertField(warlock.GreatOldOne.Spells, {
  One = "65952d48-bb16-4ad7-b173-532182bf7770",
  Two = "fe101a94-8619-49b2-859d-a68c2c291054",
  Three = "30e9b761-6be0-418e-bb28-5103c00c663b"
})

rogue.Base.SneakAttacks = "d84379aa-8bd1-41e5-a21c-242669151fae"
rogue.Base.CunningActions = "2dc120ff-903b-494b-8dc8-38721098ce38"
rogue.ArcaneTrickster.Spells.Three = "4b629bbb-203b-4382-9786-755bf897567f"