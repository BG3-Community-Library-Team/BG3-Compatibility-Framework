SCF = {}
SCF.modTableKey = "SubclassCompatibilityFramework"
SCF.modPrefix = "SCF"
SCF.modVersion = { major = 2, minor = 1, revision = 0, build = 0 }

Api = {}
Globals = {}
Ext.Require("SubclassSupport/_Globals.lua")
Ext.Require("SubclassSupport/_SubclassCompatibilityFramework.lua")
Ext.Require("SubclassSupport/API.lua")

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
Api.InsertClass("wizard", "d6184c47-5b99-4e63-95ac-02f8ce4ccda1")
Ext.Require("SubclassSupport/ClassWizard.lua")

--[[local function OnSubmit()
    if (Globals.SupportedSubClasses) ~= nil then
        for _, subClass in pairs(Globals.SupportedSubClasses) do
      if Ext.Mod.IsModLoaded(subClass.modGuid) then
        SubClassHandler(subClass.subClassGuid, subClass.class)
      end
    end
  end
end]]--

--Ext.Events.SessionLoaded:Subscribe(OnSubmit)