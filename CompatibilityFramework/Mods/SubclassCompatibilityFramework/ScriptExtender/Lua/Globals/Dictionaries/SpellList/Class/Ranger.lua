local ranger = DictUtils.SpellList("Ranger", { "BeastMaster", "Hunter", "GloomStalker" })

ranger.Base.Scrolls = "ffd3b636-d424-4120-87ae-4499a34828dc"
DictUtils.InsertField(ranger.Base.Spells, {
  One = "458be063-60d4-4548-ae7d-50117fa0226f",
  Two = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814"
})

ranger.BeastMaster.Companions = "93ba8d5f-e25a-40d6-ab25-a19af93130c7"

ranger.GloomStalker.Scrolls = "54450a9e-a079-4449-9463-089916803d9c"

ranger.Hunter.HordeBreaker = "8fe0d752-8846-41fd-a071-52592060cba8"
