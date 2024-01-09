local configFilePathPattern = string.gsub("Mods/%s/ScriptExtender/CompatibilityFrameworkConfig.json", "'", "\'")

local function SubmitData(data, modGUID)
  CLUtils.Info("Entering SubmitData")
  if data.Progressions ~= nil then
    ProgressionJsonHandler(data.Progressions, modGUID)
  end

  if data.Feats ~= nil then
    FeatJsonHandler(data.Feats, modGUID)
  end

  if data.Races ~= nil then
    RaceJsonHandler(data.Races, modGUID)
  end

  if data.Lists ~= nil then
    ListJsonHandler(data.Lists, modGUID)
  end

  if data.ActionResourceGroups ~= nil then
    ActionResourceGroupJsonHandler(data.ActionResourceGroups, modGUID)
  end

  if data.Spells ~= nil then
    SpellJsonHandler(data.Spells, modGUID)
  end
end

---@param configStr string
---@param modGUID GUIDSTRING
local function TryLoadConfig(configStr, modGUID)
  CLUtils.Info("Entering TryLoadConfig")
  local success, data = pcall(function ()
    return Ext.Json.Parse(configStr)
  end)
  if success then
    if data ~= nil then
      SubmitData(data, modGUID)
    end
  else
    CLUtils.Error(Strings.ERR_JSON_PARSE_FAIL .. CLUtils.RetrieveModHandleAndAuthor(modGUID))
  end
end

function LoadConfigFiles()
  CLUtils.Info("Entering LoadConfigFiles")
  for _, uuid in pairs(Ext.Mod.GetLoadOrder()) do
    local modData = Ext.Mod.GetMod(uuid)
    local filePath = configFilePathPattern:format(modData.Info.Directory)
    local config = Ext.IO.LoadFile(filePath, "data")
    if config ~= nil and config ~= "" then
      CLUtils.Info("Found config for Mod: " .. Ext.Mod.GetMod(uuid).Info.Name)
      local b, err = xpcall(TryLoadConfig, debug.traceback, config, uuid)
      if not b then
        CLUtils.Error(err)
      end
    end
  end
end
