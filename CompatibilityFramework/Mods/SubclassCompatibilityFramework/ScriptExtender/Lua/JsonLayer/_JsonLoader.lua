local configFilePathPattern = "Mods/%s/ScriptExtender/CompatibilityFrameworkConfig.json"

local function SubmitData(data, modGUID)
  Utils.Info("Entering SubmitData")
  if data.Progressions ~= nil then
    ProgressionJsonHandler(data.Races, modGUID)
  end

  if data.Races ~= nil then
    RaceJsonHandler(data.Races, modGUID)
  end

  if data.Lists ~= nil then

  end
end

---@param configStr string
---@param modGUID GUIDSTRING
local function TryLoadConfig(configStr, modGUID)
  Utils.Info("Entering TryLoadConfig")
  local data = Ext.Json.Parse(configStr)
  if data ~= nil then
    SubmitData(data, modGUID)
  end
end

function LoadConfigFiles()
  Utils.Info("Entering LoadConfigFiles")
  for _, uuid in pairs(Ext.Mod.GetLoadOrder()) do
    local modData = Ext.Mod.GetMod(uuid)
    local filePath = configFilePathPattern:format(modData.Info.Directory)
    local config = Ext.IO.LoadFile(filePath, "data")
    if config ~= nil and config ~= "" then
      local b, err = xpcall(TryLoadConfig, debug.traceback, config, uuid)
      if not b then
        Ext.Utils.PrintError(err)
      end
    end
  end
end
