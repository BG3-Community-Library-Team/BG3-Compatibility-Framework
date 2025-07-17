-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, classGuid)
  CLUtils.Info("Entering AttachSubClass")
  Utils.BuildQueueEntry("Progressions", classGuid, "SubClasses")
  CLUtils.AddToTable(Queue.Progressions[classGuid].SubClasses, subClassGuid)
end

local function DetachSubClass(subClassGuid, classGuid)
  CLUtils.Info("Entering DetachSubClass")
  Utils.BuildQueueEntry("Progressions", classGuid, "SubClasses_Remove")
  CLUtils.AddToTable(Queue.Progressions[classGuid].SubClasses_Remove, subClassGuid)
end

-- Check if our classname is already a guid
local function ClassNameToGuid(parentClass)
  CLUtils.Info("Entering ClassNameToGuid")
  if CLUtils.IsGuid(parentClass) then
    return parentClass
  end

  return CLGlobals.ClassUUIDs[parentClass] or nil
end

local function GetSubclassSelectionNodes(dict, classProgGuid)
  CLUtils.Info("Entering GetSubclassSelectionNodes")
  res = {}
  local targetProgression = CLUtils.CacheOrRetrieve(classProgGuid, "Progression")
  if dict[targetProgression.Name] and dict[targetProgression.Name][targetProgression.Level] then
    for _, v in pairs(dict[targetProgression.Name][targetProgression.Level]) do
      table.insert(res, v.ResourceUUID)
    end
  end

  return res
end

function SubClassHandler(payload, action)
  CLUtils.Info("Entering SubClassHandler")
  local classProgGuid = ClassNameToGuid(payload.class)
  if classProgGuid == nil then
    CLUtils.Error(Strings.ERROR_INVALID_CLASS_PROVIDED .. payload.class)
    return
  end

  local base_nodes = GetSubclassSelectionNodes(Globals.ProgressionDict, classProgGuid) or {}

  for _, node in pairs(base_nodes) do
    AttachSubClass(payload.subClassGuid, node)
  end
end
