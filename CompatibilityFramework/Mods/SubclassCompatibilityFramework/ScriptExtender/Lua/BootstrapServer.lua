Api = {}
Strings = {}
Utils = {}
Globals = {}

Ext.Require("Init/_InitGlobals.lua")
CLGlobals.ShowWarnings = true

Ext.Require("Utils/_init.lua")
Ext.Require("Globals/_init.lua")
Ext.Require("ServerDeprecation.lua")

Ext.Osiris.RegisterListener("CharacterCreationStarted", 0, "after", function()
  if #Globals.LateLoaders > 0 then
    local warnStr = Utils.BuildLateLoaderString()
    CLUtils.Warn(warnStr)
    Osi.OpenMessageBox(GetHostCharacter(), warnStr)
  end
end)
