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

local function AddSubClass(guid, parentClass)
  CLUtils.Info("Entering AddSubClass")
  if parentClass ~= nil then
    local classGuid = ClassNameToGuid(parentClass)

    if classGuid == nil then
      CLUtils.Error(Strings.ERROR_INVALID_CLASS_PROVIDED .. parentClass)
      return
    end

    AttachSubClass(guid, classGuid)
  end
end

function SubClassHandler(payload)
  CLUtils.Info("Entering SubClassHandler")
  AddSubClass(payload.subClassGuid, payload.class)
  AddSubClass(payload.subClassGuid, Globals.MulticlassClasses[payload.class])
end
