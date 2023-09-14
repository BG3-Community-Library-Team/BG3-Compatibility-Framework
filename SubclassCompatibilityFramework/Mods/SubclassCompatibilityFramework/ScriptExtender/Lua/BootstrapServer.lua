Ext.Require("SubclassSupport/ClassSorcerer.lua")
Ext.Require("SubclassSupport/ClassWarlock.lua")
Ext.Require("SubclassSupport/_SCF_Globals.lua")
Ext.Require("SubclassSupport/_SubclassCompatibilityFramework.lua")

if (SCF_SupportedSubClasses) ~= nil then
  for _, subClass in pairs(SCF_SupportedSubClasses) do
    if Ext.Mod.IsModLoaded(subClass.modGuid) then
      SCF_SubClassHandler(subClass.subClassGuid, subClass.class)
    end
  end
end