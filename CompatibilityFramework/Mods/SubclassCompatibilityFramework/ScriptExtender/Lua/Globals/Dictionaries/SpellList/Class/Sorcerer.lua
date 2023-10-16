local sorcerer = DictUtils.SpellList("Sorcerer", { "Draconic", "Storm", "WildMagic" })

sorcerer.Base.Scrolls = "2ba5248a-f014-409d-ab26-b50116f7e477"
sorcerer.Base.Cantrips = "485a68b4-c678-4888-be63-4a702efbe391"
sorcerer.Base.FontOfMagic = "979e37ad-05fa-466c-af99-9eb104a6e876"

DictUtils.InsertField(sorcerer.Base.Spells, {
  One = "92c4751f-6255-4f67-822c-a75d53830b27",
  Two = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Three = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4"
})

sorcerer.Storm.Scrolls = "c572712a-eabf-4659-8289-ea1fa4a0d234"