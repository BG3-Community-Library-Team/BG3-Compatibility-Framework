-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, classGuid)
  CLUtils.Info("Entering AttachSubClass")
  Utils.BuildQueueEntry("Progressions", classGuid, "SubClasses")
  CLUtils.AddToTable(Queue.Progressions[classGuid].SubClasses, subClassGuid)
end

-- Check if our classname is already a guid
local function ClassNameToGuid(parentClass)
  CLUtils.Info("Entering ClassNameToGuid")
  if CLUtils.IsGuid(parentClass) then
    return parentClass
  end

  return CLGlobals.ClassUUIDs[parentClass] or nil
end

local function GetMulticlassNodes(classProgGuid)
  CLUtils.Info("Entering GetMulticlassNode")
  res = {}
  local targetProgression = CLUtils.CacheOrRetrieve(classProgGuid, "Progression")
  if Globals.ProgressionDict[targetProgression.Name] and Globals.ProgressionDict[targetProgression.Name][targetProgression.Level] then
    for _, v in pairs(Globals.ProgressionDict[targetProgression.Name][targetProgression.Level]) do
      table.insert(res, v.ResourceUUID)
    end
  end

  return res
end

function SubClassHandler(payload)
  CLUtils.Info("Entering SubClassHandler")
  local classProgGuid = ClassNameToGuid(payload.class)
  if classProgGuid == nil then
    CLUtils.Error(Strings.ERROR_INVALID_CLASS_PROVIDED .. payload.class)
    return
  end

  AttachSubClass(payload.subClassGuid, classProgGuid)
  local mc_nodes = GetMulticlassNodes(classProgGuid)

  if mc_nodes and #mc_nodes then
    for _,node in pairs(mc_nodes) do
      AttachSubClass(payload.subClassGuid, node)
    end
  end
end
