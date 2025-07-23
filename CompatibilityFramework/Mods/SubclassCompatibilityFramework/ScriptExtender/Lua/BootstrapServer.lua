-- Require Community Library to function
if Ext.Mod.IsModLoaded("396c5966-09b0-40a1-af3f-93a5e9ce71c0") then
  Api = {}
  Utils = {}
  Globals = {}
  Ext.Require("Init/_InitGlobals.lua")
  CLGlobals.ShowWarnings = true

  Ext.Require("Globals/Strings.lua")
  Ext.Require("Utils/_init.lua")
  Ext.Require("Globals/_init.lua")
  Ext.Require("ServerDeprecation.lua")
  Ext.Osiris.RegisterListener("CharacterCreationStarted", 0, "after", function ()
    if #Globals.LateLoaders > 0 then
      local warnStr = Utils.BuildLateLoaderString()
      CLUtils.Warn(Strings.PREFIX .. warnStr)
      Osi.OpenMessageBox(GetHostCharacter(), warnStr)
    end
  end)
else
  Ext.Require("Globals/Strings.lua")
  Ext.Utils.PrintError(Strings.ERR_CL_NOT_LOADED)
end
