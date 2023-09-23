-- Insert Subclass into Progression Nodes
local function AttachSubClass(subClassGuid, parentClassProgressionGuid)
  Utils.Info("Entering AttachSubClass")
  local subClassNodes = Globals.ClassProgressions[parentClassProgressionGuid].SubClasses

  if subClassNodes ~= nil and not Utils.IsInTable(subClassNodes, subClassGuid) then
    Utils.Info("Adding " .. subClassGuid .. " to Progression")
    Utils.AddToTable(subClassNodes, subClassGuid)
  end
end

-- Cache our Subclass-Choice Progression if it's not already loaded
local function PrepareMainClassProgression(parentClassProgressionGuid)
  Utils.Info("Entering PrepareMainClassProgression")
  if Globals.ClassProgressions[parentClassProgressionGuid] == nil then
    -- Cache our Progression for later usage
    Globals.ClassProgressions[parentClassProgressionGuid] = Ext.Definition.Get(parentClassProgressionGuid, "Progression")
  end

  if not Utils.IsInTable(Globals.ClassUUIDs, parentClassProgressionGuid) then
    Utils.Info(parentClassProgressionGuid .. " not present in ClassUUIDs, inserting...")
    local className = Globals.ClassProgressions[parentClassProgressionGuid].Name
    Globals.ClassUUIDs[className] = parentClassProgressionGuid
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

    PrepareMainClassProgression(classGuid)
    AttachSubClass(guid, classGuid)
  end
end

function SubClassHandler(guid, parentClass)
  Utils.Info("Entering SubClassHandler")
  AddSubClass(guid, parentClass)
  AddSubClass(guid, Globals.MulticlassClasses[parentClass])
end
