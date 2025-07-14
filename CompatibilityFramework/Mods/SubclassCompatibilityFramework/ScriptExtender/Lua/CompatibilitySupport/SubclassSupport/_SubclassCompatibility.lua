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

local function GetMulticlassNode(classProgGuid)
  CLUtils.Info("Entering GetMulticlassNode")
  local targetProgression = CLUtils.CacheOrRetrieve(classProgGuid, "Progression")
  if Globals.ProgressionDict[targetProgression.Name] and Globals.ProgressionDict[targetProgression.Name][targetProgression.Level] then
    for _, v in pairs(Globals.ProgressionDict[targetProgression.Name][targetProgression.Level]) do
      if v.IsMulticlass == true then
        return v.ResourceUUID
      end
    end
  end

end

function SubClassHandler(payload)
  CLUtils.Info("Entering SubClassHandler")
  local classProgGuid = ClassNameToGuid(payload.class)
  if classProgGuid == nil then
    CLUtils.Error(Strings.ERROR_INVALID_CLASS_PROVIDED .. payload.class)
    return
  end

  AttachSubClass(payload.subClassGuid, classProgGuid)
  local mc = GetMulticlassNode(classProgGuid)

  if mc then
    AttachSubClass(payload.subClassGuid, mc)
  end
end
