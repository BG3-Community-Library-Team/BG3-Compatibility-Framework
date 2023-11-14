Api = {}
Strings = {}
Utils = {}
Globals = {}
Globals.ShowWarnings = true

Ext.Require("Init/_InitGlobals.lua")
Ext.Require("Utils/_init.lua")
Ext.Require("Globals/_init.lua")
Ext.Require("Utils/ModUtils.lua")
Ext.Require("ServerDeprecation.lua")

Ext.Osiris.RegisterListener("CharacterCreationStarted", 5, "before", function()
  if #Globals.LateLoaders > 0 then
    local warnStr = Utils.BuildLateLoaderString()
    Utils.Warn(warnStr)
    Osi.ShowNotification(GetHostCharacter(), warnStr)
  end
end)