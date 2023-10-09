local function bootStrapSpellList(name, additionalFields)
  Globals.SpellLists[name] = {
    Cantrips = {},
    Spells = {}
  }

  for key, val in pairs(additionalFields) do
    Globals.SpellLists[name][key] = val
  end

  return Globals.SpellLists[name]
end

local function populateSubsets(name, subsets)
    for key, val in pairs(subsets) do
        for listKey, _ in pairs(Globals.SpellLists[name]) do
            Globals.SpellLists[name][listKey][key] = val
        end
    end
end

local barbarian = bootStrapSpellList("barbarian")
populateSubsets("barbarian", {WildMagic = {}, Berserker = {}, WildShape = {}})
local bard = bootStrapSpellList("bard", {CounterCharm = "d84fc8ab-293e-437f-9825-e3e313f78060", MagicalSecrets = {}})
populateSubsets("bard", {Lore = {}, Sword = {}, Valor = {}})
local cleric = bootStrapSpellList("cleric", { ChannelDivinity = {} })
populateSubsets("cleric", {Base = {}, Life = {}, Light = {}, Trickery = {}})

barbarian.Berserker.Spells.Ten = "38191b4b-743a-4d82-800b-c0903baece24"
barbarian.Spells.WildMagic.Three = "6a27ea3e-ed94-4d90-9a27-109a902dd049"
barbarian.Spells.WildMagic.Six = "9e604f0f-ec60-402d-b8c8-7707a1caefd8"
barbarian.Spells.WildMagic.Nine = "4e7b517a-2eca-4463-99a6-a5ffa5036216"

bard.MagicalSecrets.Three = "65ad9f94-0cbf-4c79-9ffb-7fb9c19f9a50"
bard.Spells.Base.Two = "7ea8f476-97a1-4256-8f10-afa76a845cce"
bard.Spells.Base.Three = "c213ca01-3767-457b-a5c8-fd4c1dd656e2"
bard.Spells.Base.Four = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6"
bard.Spells.Base.Five = "bd71fffb-e4d2-4233-9a31-13d43fba36e3"
bard.Spells.Base.Six = "586a8796-34f4-41f5-a3ef-95738561d55d"

cleric.Cantrips.Base = "2f43a103-5bf1-4534-b14f-663decc0c525"
cleric.ChannelDivinity.Base = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.ChannelDivinity.Life = "36795b9e-f712-44a4-9c0f-eda1e78df9ab"
cleric.ChannelDivinity.Light = "a322dbfe-69d0-421a-819a-4317b6c87a3b"
cleric.ChannelDivinity.Trickery = "c35cb4e6-2690-4e1f-bd89-69f4f69ae818"
cleric.Spells.Base.One = "269d1a3b-eed8-4131-8901-a562238f5289"
cleric.Spells.Base.Two = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac"
cleric.Spells.Base.Three = "21be0992-499f-4c7a-a77a-4430085e947a"
cleric.Spells.Life.One = "26ffbe70-23c6-4918-9e6a-a3e556a9d355"
cleric.Spells.Life.Two = "bbaf0bab-b0b3-44c9-a567-304e35c063c9"
cleric.Spells.Life.Five = "a9ff6ed3-050e-4963-b37b-c083285d6214"
cleric.Spells.Light.One = "e2464518-2484-436e-9153-864c9dd05a7d"
cleric.Spells.Light.Two = "31037493-7a57-4dce-9412-4689c010199c"
cleric.Spells.Light.Five = "1a50d25a-27b5-4789-b2d6-532fac4437c6"
cleric.Spells.Trickery.One = "98ef625f-d127-4fc3-8e37-37a4b27e6393"
cleric.Spells.Trickery.Two = "9f603ac8-2e51-4ce9-b924-c8093148bdf5"
cleric.Spells.Trickery.Five = "8a9faf7a-aacf-43f4-a0dd-5ea7e72449f3"

local wizard = {}
wizard.ArcaneRecovery = "34c3321d-75ab-4b50-a44d-cbac8705a360"

Globals.SpellLists = {
  Cleric = cleric,
  Wizard = wizard
}
