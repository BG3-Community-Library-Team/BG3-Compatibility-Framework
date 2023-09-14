local SCF_ClassProgressions = {}

function SCF_InsertSubclass(arr, guid, doInsert)
    if doInsert then
        table.insert(arr, guid)
    end
end

function SCF_FindExistingSubclass(arr, guid)
    if arr ~= nil then
      for _, value in pairs(arr) do
          if string.match(value, guid) then
              return true
          end
      end
    end
    return false
end

function SCF_LoadClass(className)
    if SCF_ClassProgressions[className] == nil and SCF_SupportedClassDict[className] then
        SCF_ClassProgressions[className] = Ext.Definition.Get(SCF_SupportedClassDict[className].guid, "Progression")
    end

    return SCF_ClassProgressions[className]
end

function SCF_LoadSubClass(guid, className)
    local subClassNodes = SCF_LoadClass(className)

    SCF_InsertSubclass(subClassNodes, guid, SCF_FindExistingSubclass(subClassNodes, guid))
end

function SCF_SubClassHandler(guid, parentClass)
    local mcClassName = "mc_" .. parentClass

    SCF_LoadSubClass(guid, parentClass)
    SCF_LoadSubClass(guid, mcClassName)
end