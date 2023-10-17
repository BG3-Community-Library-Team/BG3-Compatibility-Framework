local paladin = DictUtils.Progression("NPC_Paladin")

Utils.MergeTables(paladin.Base.Levels, {
  One = DictUtils.setupClassLevelEntry("ba895540-fb26-4c85-9024-fe15c9a832ec"),
  Two = DictUtils.setupClassLevelEntry("0ba007e2-806a-4198-ad5d-f47045d27be4"),
  Three = DictUtils.setupClassLevelEntry("c5c25a3d-e5f0-44a2-9509-d30da893bf12"),
  Four = DictUtils.setupClassLevelEntry("faf53759-109c-4551-b1c3-459abe545106"),
  Five = DictUtils.setupClassLevelEntry("50e571ec-3dfa-4f2a-8f03-2812b29934c7")
})
