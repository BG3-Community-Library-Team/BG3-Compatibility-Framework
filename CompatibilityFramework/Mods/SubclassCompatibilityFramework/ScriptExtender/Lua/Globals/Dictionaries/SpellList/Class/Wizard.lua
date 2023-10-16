local wizard = DictUtils.SpellList("Wizard", { "Abjuration", "Conjuration", "Divination", "Enchantment", "Evocation", "Illusion", "Necromancy", "Transmutation" })

wizard.Base.Scrolls = "beb9389e-24f8-49b0-86a5-e8d08b6fdc2e"
wizard.Base.Cantrips = "3cae2e56-9871-4cef-bba6-96845ea765fa"
wizard.Base.ArcaneRecovery = "34c3321d-75ab-4b50-a44d-cbac8705a360"
DictUtils.InsertField(wizard.Base.Spells, {
  One = "11f331b0-e8b7-473b-9d1f-19e8e4178d7d",
  Two = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Three = "22755771-ca11-49f4-b772-13d8b8fecd93"
})

wizard.Enchantment.Scrolls = "355aa142-57f6-4616-b5d1-04777309d9d1"