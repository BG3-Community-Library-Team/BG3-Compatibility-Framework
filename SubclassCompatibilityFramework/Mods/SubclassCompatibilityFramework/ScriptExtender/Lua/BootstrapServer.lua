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
--Ext.Require("SubclassSupport/ClassWarlock.lua")
Ext.Require("SubclassSupport/ClassWizard.lua")
Ext.Require("SubclassSupport/_SCF_Globals.lua")
Ext.Require("SubclassSupport/_SubclassCompatibilityFramework.lua")
Ext.Require("SubclassSupport/API.lua")


PersistentVars = {}
PersistentVars['SFC_BootstrapSubClass'] = SFC_BootstrapSubClass
PersistentVars['SFC_BootstrapClass'] = SFC_BootstrapClass

if (SCF_SupportedSubClasses) ~= nil then
  for _, subClass in pairs(SCF_SupportedSubClasses) do
    if Ext.Mod.IsModLoaded(subClass.modGuid) then
      SCF_SubClassHandler(subClass.subClassGuid, subClass.class)
    end
  end
end
