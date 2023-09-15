-- Subclass Definitions
local subClasses = {
  BaaleosShadowSorcerer = { -- BG3ShadowSorcerer by Baaleos
    modGuid = "38291fe1-40a3-4af7-bbbd-c9a55f3e39c0",
    subClassGuid = "d007a7be-60c6-4606-87db-66eb9e247050",
    class = "sorcerer",
    subClassName = "Shadow Sorcerery"
  },
  CodyAbodeStoneSorcery = { -- Stone Sorcery by Cody Abode
    modGuid = "f48b2612-4d95-4601-b324-b8a07c9d90be",
    subClassGuid = "3c335f43-bae3-4468-9972-d9bdedca2a71",
    class = "sorcerer",
    subClassName = "Stone Sorcery"
  }
}

Api.InsertSubClasses(subClasses)
Api.InsertClass("sorcerer", "42af9bda-9ac0-4564-920b-f9ca1588d6ee")
Api.InsertClass("mc_sorcerer", "e115c732-80b1-4ae1-bf04-cee44660d64f")
