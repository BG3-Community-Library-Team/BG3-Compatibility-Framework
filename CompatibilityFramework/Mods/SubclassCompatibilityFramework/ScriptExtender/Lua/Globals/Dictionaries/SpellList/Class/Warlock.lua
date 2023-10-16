local warlock = DictUtils.SpellList("Warlock", { "Fiend", "GreatOldOne", "ArchFey" })

warlock.Base.Scrolls = "32879c22-4858-48ef-8f8d-22e6d395b396"
warlock.Base.Cantrips = "f5c4af9c-5d8d-4526-9057-94a4b243cd40"

warlock.ArchFey.Scrolls = "f95ef4cc-5f75-4274-bda5-589175d2ac66"

warlock.Fiend.Scrolls = "69d140ce-e988-4007-b069-30fe2e5f0d2f"
DictUtils.InsertField(warlock.Fiend.Spells, {
  One = "4823a292-f584-4f7f-8434-6630c72e5411",
  Two = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
  Three = "5dec41aa-f16a-434e-b209-50c07e64e4ed"
})

warlock.GreatOldOne.Scrolls = "9bcde680-356e-445e-abdb-c21f3400648b"
DictUtils.InsertField(warlock.GreatOldOne.Spells, {
  One = "65952d48-bb16-4ad7-b173-532182bf7770",
  Two = "fe101a94-8619-49b2-859d-a68c2c291054",
  Three = "30e9b761-6be0-418e-bb28-5103c00c663b"
})