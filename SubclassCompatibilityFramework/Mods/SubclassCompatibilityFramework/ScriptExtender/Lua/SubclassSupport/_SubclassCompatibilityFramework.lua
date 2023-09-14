Ext.Require("SubclassSupport/_SCF_Globals.lua")
local SCF_ClassProgressions = {}

function SCF_InsertSubclass(arr, guid)
  if arr ~= nil then
    table.insert(arr, guid)
  end
end

function SCF_FindExistingSubclass(arr, guid)
  if arr ~= nil then
        for _, value in pairs(arr) do
      if value == guid then
        return true
      end
    end
  end
end

function SCF_LoadClass(className)
  if SCF_ClassProgressions[className] == nil and SCF_SupportedClassDict[className] then
    SCF_ClassProgressions[className] = Ext.Definition.Get(SCF_SupportedClassDict[className], "Progression")
  end

  return SCF_ClassProgressions[className].SubClasses
end

function SCF_LoadSubClass(guid, className)
  if SCF_SupportedClassDict[className] ~= nil then
    local subClassNodes = SCF_LoadClass(className)
    if not SCF_FindExistingSubclass(subClassNodes, guid) then
      SCF_InsertSubclass(subClassNodes, guid)
    end
  end
end

function SCF_SubClassHandler(guid, parentClass)
  SCF_LoadSubClass(guid, parentClass)

  if SCF_MulticlassClasses[parentClass] ~= nil then
    SCF_LoadSubClass(guid, SCF_MulticlassClasses[parentClass])
  end
end
