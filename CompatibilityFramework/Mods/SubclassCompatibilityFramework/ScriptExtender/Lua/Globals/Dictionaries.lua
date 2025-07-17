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
local progUUIDs = Ext.StaticData.GetAll("Progression")
for _, uuid in pairs(progUUIDs) do
  local prog = Ext.StaticData.Get(uuid, "Progression")

  -- Filter out ones with no reason to do this with
  if prog.IsMulticlass == true then
    if prog.Level and prog.Name then
      if not Globals.ProgressionDict[prog.Name] then
        Globals.ProgressionDict[prog.Name] = {}
      end
      if not Globals.ProgressionDict[prog.Name][prog.Level] then
        Globals.ProgressionDict[prog.Name][prog.Level] = {}
      end

      table.insert(Globals.ProgressionDict[prog.Name][prog.Level], prog)
    end
  end
end
