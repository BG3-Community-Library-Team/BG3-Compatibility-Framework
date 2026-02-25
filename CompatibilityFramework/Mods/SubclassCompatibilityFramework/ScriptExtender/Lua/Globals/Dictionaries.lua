Globals.ModuleTypes = {
  Progression = "Progressions",
  Feat = "Feats",
  List = "Lists",
  Race = "Races",
  Origin = "Origins",
  Background = "Backgrounds",
  BackgroundGoal = "BackgroundGoals"
}

-- Mods that loaded too late to join the queue
Globals.LateLoaders = {}
Globals.ValidationErrors = {}
Globals.Deprecated = {}
Globals.Deprecated.SubclassAPI = {}
Globals.Deprecated.SubclassJSON = {}
Globals.ProgressionDict = {}
Globals.ClassDescriptionDict = {}
Globals.SubclassBlacklist = {}

Globals.TagFileTargets = {
  Origin = {
    Really = "ReallyTags",
    Appearance = "AppearanceTags"
  },
  ClassDescription = {
    Tags = "Tags"
  },
  Background = {
    Tags = "Tags"
  }
}
