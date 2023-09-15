Ext.Require("SubclassSupport/ClassBarbarian.lua")
Ext.Require("SubclassSupport/ClassBard.lua")
Ext.Require("SubclassSupport/ClassCleric.lua")
Ext.Require("SubclassSupport/ClassDruid.lua")
Ext.Require("SubclassSupport/ClassFighter.lua")
Ext.Require("SubclassSupport/ClassMonk.lua")
Ext.Require("SubclassSupport/ClassPaladin.lua")
Ext.Require("SubclassSupport/ClassRanger.lua")
Ext.Require("SubclassSupport/ClassRogue.lua")
Ext.Require("SubclassSupport/ClassSorcerer.lua")
Ext.Require("SubclassSupport/ClassWarlock.lua")
Ext.Require("SubclassSupport/ClassWizard.lua")
Ext.Require("SubclassSupport/_Globals.lua")
Ext.Require("SubclassSupport/_SubclassCompatibilityFramework.lua")
Ext.Require("SubclassSupport/API.lua")

if (Globals.SupportedSubClasses) ~= nil then
  for _, subClass in pairs(Globals.SupportedSubClasses) do
    if Ext.Mod.IsModLoaded(subClass.modGuid) then
      SubClassHandler(subClass.subClassGuid, subClass.class)
    end
  end
end
