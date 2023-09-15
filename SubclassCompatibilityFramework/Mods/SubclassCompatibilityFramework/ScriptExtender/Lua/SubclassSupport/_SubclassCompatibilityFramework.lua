local ClassProgressions = {}

local function InsertSubclass(arr, guid)
  Ext.Utils.Print("Entered InsertSubclass")
  if arr ~= nil then
    table.insert(arr, guid)
  end
end

local function FindExistingSubclass(arr, guid)
  Ext.Utils.Print("Entered FindExistingSubclass")
  if arr ~= nil then
        for _, value in pairs(arr) do
      if value == guid then
        return true
      end
    end
  end
end

local function LoadClass(className)
  Ext.Utils.Print("Entered LoadClass")
  if ClassProgressions[className] == nil and Globals.SupportedClassDict[className] then
    ClassProgressions[className] = Ext.Definition.Get(Globals.SupportedClassDict[className], "Progression")
  end

  return ClassProgressions[className].SubClasses
end

local function LoadSubClass(guid, className)
  Ext.Utils.Print("Entered LoadSubClass with " .. className .. " " .. guid)
  if Globals.SupportedClassDict[className] ~= nil then
    Ext.Utils.Print("SupportedClassDict " .. className .. " exists!")
    local subClassNodes = LoadClass(className)
    if not FindExistingSubclass(subClassNodes, guid) then
      Ext.Utils.Print("Subclass not a duplicate")
      InsertSubclass(subClassNodes, guid)
    end
  end
end

function SubClassHandler(guid, parentClass)
  Ext.Utils.Print("Entered Subclass Handler with " .. parentClass .. " " .. guid)
  LoadSubClass(guid, parentClass)

  if Globals.MulticlassClasses[parentClass] ~= nil then
    LoadSubClass(guid, Globals.MulticlassClasses[parentClass])
  end
end
