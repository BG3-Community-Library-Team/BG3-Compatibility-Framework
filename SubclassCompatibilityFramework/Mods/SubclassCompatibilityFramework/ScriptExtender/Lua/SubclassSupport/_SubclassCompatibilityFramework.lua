ClassProgressions = {}

-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, parentClassProgressionGuid)
  local subClassNodes = ClassProgressions[parentClassProgressionGuid].SubClasses

  if not Utils.IsInTable(subClassNodes, subClassGuid) then
    Utils.Info("Adding " .. subClassGuid .. " to Progression")
    Utils.AddToTable(subClassNodes, subClassGuid)
  end
end

-- Cache our Subclass-Choice Progression if it's not already loaded
local function PrepareMainClassProgression(parentClassProgressionGuid)
  ClassProgressions[parentClassProgressionGuid] = Ext.Definition.Get(parentClassProgressionGuid, "Progression")
  if not Utils.IsInTable(ClassProgressions, parentClassProgressionGuid) then
    Utils.Info(parentClassProgressionGuid .. " not present in ClassUUIDs, inserting...")
    if not Utils.IsInTable(Globals.ClassUUIDs, parentClassProgressionGuid) then
      Globals.ClassUUIDs[ClassProgressions[parentClassProgressionGuid].Name] = parentClassProgressionGuid
    end
  end
end

-- Need to handle special cases where Subclass choice is at level 1
local function HandleLevelOneProgressions(parentClass)
  if Utils.IsInTable(Globals.MulticlassClasses, parentClass) then
    return Globals.MulticlassClasses[parentClass]
  end
end

-- Check if our classname is already a guid
local function ClassNameToGuid(parentClass)
  if Utils.IsGuid(parentClass) then
    return parentClass
  end

  return Globals.ClassUUIDs[parentClass] or nil
end

local function AddSubClass(guid, parentClass)
  local classGuid = ClassNameToGuid(parentClass)

  if classGuid == nil then
    Utils.Error(Strings.INVALID_CLASS_PROVIDED)
  end

  PrepareMainClassProgression(classGuid)
  AttachSubClass(guid, classGuid)
end

function SubClassHandler(guid, parentClass)
  AddSubClass(guid, parentClass)
  LevelOneMulticlassGuid = HandleLevelOneProgressions(parentClass)
  if LevelOneMulticlassGuid ~= nil then
    AddSubClass(guid, LevelOneMulticlassGuid)
  end
end
