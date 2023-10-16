local bard = DictUtils.SpellList("Bard", { "Lore", "Sword", "Valor" })


bard.Base.Cantrips = "61f79a30-2cac-4a7a-b5fe-50c89d307dd6"
bard.Base.SongOfRest = "80225e21-5acd-4122-b779-488dae33a31c"
bard.Base.Scrolls = "c98f2011-31e1-4e9a-8061-62c8679c645e"
DictUtils.InsertField(bard.Base, { CounterCharm = "d84fc8ab-293e-437f-9825-e3e313f78060", MagicalSecrets = {} })
DictUtils.InsertField(bard.Base.MagicalSecrets, { Three = "65ad9f94-0cbf-4c79-9ffb-7fb9c19f9a50" })
DictUtils.InsertField(bard.Base.Spells, {
  One = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Two = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Three = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Four = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Five = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Six = "586a8796-34f4-41f5-a3ef-95738561d55d"
})

DictUtils.InsertField(bard.Lore.Spells, {
  Three = "ec3719ef-6a99-4305-8fd6-b2257b165aec"
})