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
  for subclass, field in pairs(fieldObj) do
    for key, value in pairs(field) do
      obj[subclass][key] = value
    end
  end
end

local barbarian = ClassSpellList("Barbarian", { "Berserker", "WildMagic", "WildShape" })
local bard = ClassSpellList("Bard", { "Lore", "Sword", "Valor" })
local cleric = ClassSpellList("Cleric", { "Life", "Light", "Trickery" })
local wizard = ClassSpellList("Wizard", {})

InsertField(barbarian.Berserker.Spells, { Ten = "38191b4b-743a-4d82-800b-c0903baece24" })
InsertField(barbarian.WildMagic.Spells, {
  Three = "6a27ea3e-ed94-4d90-9a27-109a902dd049",
  Six = "9e604f0f-ec60-402d-b8c8-7707a1caefd8",
  Nine = "4e7b517a-2eca-4463-99a6-a5ffa5036216"
})
InsertField(wizard, { Base = { ArcaneRecovery = "34c3321d-75ab-4b50-a44d-cbac8705a360" } })
InsertField(bard, { Base = { CounterCharm = "d84fc8ab-293e-437f-9825-e3e313f78060", MagicalSecrets = {} } })
InsertField(bard.Base.Spells, {
  Two = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Three = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Four = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Five = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Six = "586a8796-34f4-41f5-a3ef-95738561d55d"
})
local magicalSecrets = {
  Base = {
    MagicalSecrets = {
      Three = "65ad9f94-0cbf-4c79-9ffb-7fb9c19f9a50"
    }
  }
}
InsertField(bard, magicalSecrets)
local channelDivinity = {
  Base = { ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51" },
  Life = { ChannelDivinity = "36795b9e-f712-44a4-9c0f-eda1e78df9ab" },
  Light = { ChannelDivinity = "a322dbfe-69d0-421a-819a-4317b6c87a3b" },
  Trickery = { ChannelDivinity = "c35cb4e6-2690-4e1f-bd89-69f4f69ae818" },
}
InsertField(cleric, channelDivinity)
cleric.Base.Cantrips = "2f43a103-5bf1-4534-b14f-663decc0c525"
cleric.Base.Spells.One = "269d1a3b-eed8-4131-8901-a562238f5289"
cleric.Base.Spells.Two = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac"
cleric.Base.Spells.Three = "21be0992-499f-4c7a-a77a-4430085e947a"
cleric.Life.Spells.One = "26ffbe70-23c6-4918-9e6a-a3e556a9d355"
cleric.Life.Spells.Two = "bbaf0bab-b0b3-44c9-a567-304e35c063c9"
cleric.Life.Spells.Five = "a9ff6ed3-050e-4963-b37b-c083285d6214"
cleric.Light.Spells.One = "e2464518-2484-436e-9153-864c9dd05a7d"
cleric.Light.Spells.Two = "31037493-7a57-4dce-9412-4689c010199c"
cleric.Light.Spells.Five = "1a50d25a-27b5-4789-b2d6-532fac4437c6"
cleric.Trickery.Spells.One = "98ef625f-d127-4fc3-8e37-37a4b27e6393"
cleric.Trickery.Spells.Two = "9f603ac8-2e51-4ce9-b924-c8093148bdf5"
cleric.Trickery.Spells.Five = "8a9faf7a-aacf-43f4-a0dd-5ea7e72449f3"
