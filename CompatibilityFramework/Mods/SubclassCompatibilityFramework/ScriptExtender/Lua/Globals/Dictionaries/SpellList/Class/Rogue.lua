local rogue = DictUtils.SpellList("Rogue", { "Thief", "Assassin", "ArcaneTrickster" })

rogue.Base.SneakAttacks = "d84379aa-8bd1-41e5-a21c-242669151fae"
rogue.Base.CunningActions = "2dc120ff-903b-494b-8dc8-38721098ce38"

rogue.ArcaneTrickster.MageHand = "e1407db3-e476-4d8f-a687-d3c795ad8c04"
rogue.ArcaneTrickster.Scrolls = "c3a861a2-6bbc-4ff6-96e4-a4accf10d957"
DictUtils.InsertField(rogue.ArcaneTrickster.Spells, {
  Three = "4b629bbb-203b-4382-9786-755bf897567f"
})