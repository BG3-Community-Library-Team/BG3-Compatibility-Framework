local cleric = DictUtils.SpellList("Cleric", { "Life", "Light", "Knowledge", "Nature", "Tempest", "Trickery", "War" })

cleric.Base.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Base.Scrolls = "42acd9d3-3b44-4d08-a061-3fd2f69aa4bf"
cleric.Base.Cantrips = "2f43a103-5bf1-4534-b14f-663decc0c525"
DictUtils.InsertField(cleric.Base.Spells, {
  One = "269d1a3b-eed8-4131-8901-a562238f5289",
  Two = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
  Three = "21be0992-499f-4c7a-a77a-4430085e947a"
})

cleric.Knowledge.Scrolls = "6e728725-5a3a-42f4-ae6c-93b803e5d979"

cleric.Life.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Life.Scrolls = "79f6a154-c3e0-4a6a-ad96-faa89166d1cc"
DictUtils.InsertField(cleric.Life.Spells, {
  One = "26ffbe70-23c6-4918-9e6a-a3e556a9d355",
  Two = "bbaf0bab-b0b3-44c9-a567-304e35c063c9",
  Five = "a9ff6ed3-050e-4963-b37b-c083285d6214"
})

cleric.Light.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Light.Scrolls = "ad589eda-d471-49fb-a629-f9c5a1860666"
DictUtils.InsertField(cleric.Light.Spells, {
  One = "e2464518-2484-436e-9153-864c9dd05a7d",
  Two = "31037493-7a57-4dce-9412-4689c010199c",
  Five = "1a50d25a-27b5-4789-b2d6-532fac4437c6"
})

cleric.Nature.Scrolls = "38f8f794-6c62-4641-bcb9-2d1a733badaa"

cleric.Trickery.ChannelDivinity = "239cc7cc-f642-4ddc-b091-498d81612c51"
cleric.Trickery.Scrolls = "25157f12-3bfb-4df0-a322-a3109066037a"
DictUtils.InsertField(cleric.Trickery.Spells, {
  One = "98ef625f-d127-4fc3-8e37-37a4b27e6393",
  Two = "9f603ac8-2e51-4ce9-b924-c8093148bdf5",
  Five = "8a9faf7a-aacf-43f4-a0dd-5ea7e72449f3"
})

cleric.Tempest.Scrolls = "264c3b2d-8445-40f6-9a2f-383de3baa01e"

cleric.War.Scrolls = "d76e6293-e2e3-4e63-9ef1-655556b18833"