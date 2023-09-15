local ClassProgressions = {}

local InsertSubclass = function(arr, guid)
  if arr ~= nil then
    table.insert(arr, guid)
  end
end

local FindExistingSubclass = function(arr, guid)
  if arr ~= nil then
        for _, value in pairs(arr) do
      if value == guid then
        return true
      end
    end
  end
end

local LoadClass = function(className)
  if ClassProgressions[className] == nil and Globals.SupportedClassDict[className] then
    ClassProgressions[className] = Ext.Definition.Get(Globals.SupportedClassDict[className], "Progression")
  end

  return ClassProgressions[className].SubClasses
end

local LoadSubClass = function(guid, className)
  if Globals.SupportedClassDict[className] ~= nil then
    local subClassNodes = LoadClass(className)
    if not FindExistingSubclass(subClassNodes, guid) then
      InsertSubclass(subClassNodes, guid)
    end
  end
end

function SubClassHandler(guid, parentClass)
  LoadSubClass(guid, parentClass)

  if Globals.MulticlassClasses[parentClass] ~= nil then
    LoadSubClass(guid, Globals.MulticlassClasses[parentClass])
  end
end
