-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, classGuid)
  Utils.Info("Entering AttachSubClass")

  if Queue.Progressions[classGuid] == nil then
    Queue.Progressions[classGuid] = {}
  end
  if Queue.Progressions[classGuid].SubClasses == nil then
    Queue.Progressions[classGuid].SubClasses = {}
  end
  Utils.AddToTable(Queue.Progressions[classGuid].SubClasses, subClassGuid)
end

-- Check if our classname is already a guid
local function ClassNameToGuid(parentClass)
  Utils.Info("Entering ClassNameToGuid")
  if Utils.IsGuid(parentClass) then
    return parentClass
  end

  return Globals.ClassUUIDs[parentClass] or nil
end

local function AddSubClass(guid, parentClass)
  Utils.Info("Entering AddSubClass")
  if parentClass ~= nil then
    local classGuid = ClassNameToGuid(parentClass)

    if classGuid == nil then
      Utils.Error(Strings.INVALID_CLASS_PROVIDED .. parentClass)
      return
    end

    AttachSubClass(guid, classGuid)
  end
end

function SubClassHandler(payload)
  Utils.Info("Entering SubClassHandler")
  AddSubClass(payload.subClassGuid, payload.class)
  AddSubClass(payload.subClassGuid, Globals.MulticlassClasses[payload.class])
end
