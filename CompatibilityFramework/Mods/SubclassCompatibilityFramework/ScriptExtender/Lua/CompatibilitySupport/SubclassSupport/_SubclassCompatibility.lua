-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, progression)
  Utils.Info("Entering AttachSubClass")
  local sortTable = {}
  local subclassTable = {}
  for _, val in pairs(progression.SubClasses) do
    Utils.AddToTable(sortTable, { Utils.RetrieveHandle(val, "ClassDescription", "DisplayName"), val })
  end

  table.sort(sortTable, Utils.SimpleCompare)

  for _, val in pairs(sortTable) do
    Utils.AddToTable(subclassTable, val[2])
  end
  if progression.SubClasses ~= nil and not Utils.IsInTable(progression.SubClasses, subClassGuid) then
    Utils.AddToTable(subclassTable, subClassGuid)

    progression.SubClasses = subclassTable
  end
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

    AttachSubClass(guid, Utils.CacheOrRetrieve(classGuid, "Progression"))
  end
end

function SubClassHandler(payload)
  Utils.Info("Entering SubClassHandler")
  AddSubClass(payload.subClassGuid, payload.class)
  AddSubClass(payload.subClassGuid, Globals.MulticlassClasses[payload.class])
end
