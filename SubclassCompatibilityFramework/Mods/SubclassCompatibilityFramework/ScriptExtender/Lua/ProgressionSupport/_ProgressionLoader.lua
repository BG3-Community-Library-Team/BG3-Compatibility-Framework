

function LoadClass(className)
  if ClassProgressions[className] == nil and Globals.SupportedClassDict[className] then
    ClassProgressions[className] = Ext.Definition.Get(Globals.SupportedClassDict[className], "Progression")
  end

  return ClassProgressions[className].SubClasses
end