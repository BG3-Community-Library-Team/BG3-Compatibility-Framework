Globals.ModuleTypes = {
  Progression = "Progressions",
  Feat = "Feats",
  List = "Lists",
  Race = "Races"
}

-- Mods that loaded too late to join the queue
Globals.LateLoaders = {}

-- God help me
-- This should only happen once so performance impact should be minimal but ajdlskdfhsdkjhfksjafhslkjdfhjksldfg
Globals.ProgressionDict = {}
Globals.MC_ProgressionDict = {}
local progUUIDs = Ext.StaticData.GetAll("Progression")
for _, uuid in pairs(progUUIDs) do
  local prog = Ext.StaticData.Get(uuid, "Progression")

  if prog.ProgressionType == "Class" then
    Globals.ProgressionDict[prog.Name] = {}
    Globals.ProgressionDict[prog.Name][prog.Level] = {}
    table.insert(Globals.ProgressionDict[prog.Name][prog.Level], prog)

    if prog.IsMulticlass == true then
      Globals.MC_ProgressionDict[prog.Name] = {}
      Globals.MC_ProgressionDict[prog.Name][prog.Level] = {}
      table.insert(Globals.MC_ProgressionDict[prog.Name][prog.Level], prog)
    end
  end
end
