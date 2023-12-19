Ext.Require("Init/Strings.lua")

-- Require Community Library to function
if Ext.Mod.IsModLoaded("396c5966-09b0-40a1-af3f-93a5e9ce71c0") then
    Ext.Require("Init/_InitGlobals.lua")
    Ext.Require("Utils/_init.lua")
    Ext.Require("Globals/_init.lua")
    Ext.Require("CompatibilitySupport/_init.lua")
    Ext.Require("API/_init.lua")

    CLUtils.Info(CLStrings.LOADED_REQUIRED_FILES)

    Ext.Require("Init/_InitClasses.lua")
    Ext.Require("JsonLayer/_init.lua")
    Ext.Require("Init/_InitDefaults.lua")
else
    Ext.Utils.PrintError(Strings.ERR_CL_NOT_LOADED)
end
