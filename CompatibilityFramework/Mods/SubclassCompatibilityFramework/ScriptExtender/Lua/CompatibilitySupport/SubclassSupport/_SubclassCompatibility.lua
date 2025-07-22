-- Insert Subclass into Progression Nodes
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
local function RemoveSubClass(guid, parentClass)
  CLUtils.Info("Entering AddSubClass")
  if parentClass ~= nil then
    local classGuid = ClassNameToGuid(parentClass)

    if classGuid == nil then
      CLUtils.Error(Strings.ERROR_INVALID_CLASS_PROVIDED .. parentClass)
      return
    end

    DetachSubClass(guid, classGuid)
  end
end

function SubClassHandler(payload, action)
  CLUtils.Info("Entering SubClassHandler")
  if action == "Remove" then
    RemoveSubClass(payload.subClassGuid, payload.class)
  end

end
