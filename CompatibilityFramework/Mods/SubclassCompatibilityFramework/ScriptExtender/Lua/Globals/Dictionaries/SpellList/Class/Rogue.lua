local rogue = DictUtils.SpellList("Rogue", { "Thief", "Assassin", "ArcaneTrickster" })

rogue.Base.SneakAttacks = "d84379aa-8bd1-41e5-a21c-242669151fae"
rogue.Base.CunningActions = "2dc120ff-903b-494b-8dc8-38721098ce38"

rogue.ArcaneTrickster.MageHand = "e1407db3-e476-4d8f-a687-d3c795ad8c04"
rogue.ArcaneTrickster.Scrolls = "c3a861a2-6bbc-4ff6-96e4-a4accf10d957"
DictUtils.InsertField(rogue.ArcaneTrickster.Spells, {
  Two = "f9fd64f1-f417-4544-94a9-51d8876d68df",
  Three = "4b629bbb-203b-4382-9786-755bf897567f"
})

rogue.Assassin.Infiltration = "fab9f457-4570-472e-95be-ffe5b5aa863d"

rogue.Thief.Sneak = "7cf87f47-e2f7-4ac5-a0b2-88a3e963d29d"
