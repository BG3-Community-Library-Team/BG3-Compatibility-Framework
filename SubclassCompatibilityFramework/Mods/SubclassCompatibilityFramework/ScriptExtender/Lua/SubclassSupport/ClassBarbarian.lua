Ext.Require("SubclassSupport/_SCF_Globals.lua")

-- Subclass Definitions
local subClasses = {
  -- Add your own!
}

if subClasses ~= nil then
    for _, subClass in pairs(subClasses) do
        table.insert(SCF_SupportedSubClasses, subClass)
    end
end

SCF_SupportedClassDict['barbarian'] = ""
