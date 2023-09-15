Ext.Require("SubclassSupport/_SCF_Globals.lua")

-- For adding Support to 1 or more Subclasses
function SFC_BootstrapSubClass(subClasses)
    if subClasses ~= nil then
        for _, subClass in pairs(subClasses) do
            table.insert(SCF_SupportedSubClasses, subClass)
        end
    end
end

-- For adding support to a Custom Class
function SFC_BootstrapClass(classGuid, className)
  SCF_SupportedClassDict[className] = classGuid
end