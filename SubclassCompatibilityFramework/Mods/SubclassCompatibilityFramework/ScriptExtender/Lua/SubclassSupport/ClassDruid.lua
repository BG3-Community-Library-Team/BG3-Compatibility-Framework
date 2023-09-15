-- Subclass Definitions
local subClasses = {
  YoshiDreams = { -- Circle of Dreams by Kingdomyoshi
    modGuid = "81d10c14-3abb-41d6-a6a6-78daab7076d5",
    subClassGuid = "0e4f565b-1970-4ee5-9a1e-5020ff62cfdd",
    class = "druid",
    subClassName = "Circle of Dreams"
  },
  HavsglimtStars = { -- Circle of Stars by havsglimt
    modGuid = "7588b857-8bae-4967-a73c-20f7833ae26f",
    subClassGuid = "5ef8c19d-cb24-4192-83bf-5db9593c7fde",
    class = "druid",
    subClassName = "Circle of Stars"
  },
  YoshiWildfire = {   -- Circle of Wildfire by Kingdomyoshi
    modGuid = "c9cfbec9-136f-40de-a12e-33650efea178",
    subClassGuid = "d06c070d-43c9-4bfe-b68e-7fe6e2ec10c5",
    class = "druid",
    subClassName = "Circle of Wildfire"
  }
}

Api.InsertSubClasses(subClasses)
Api.InsertClass("druid", "95322dde-349a-4101-964f-9aa46abd890b")
