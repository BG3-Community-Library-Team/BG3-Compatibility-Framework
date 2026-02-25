local configBasePattern = string.gsub("Mods/%s/ScriptExtender/CompatibilityFrameworkConfig.", "'", "\'")


--- { format = parser key, extensions = file extensions to try }
local configFormats = {
  { format = "json", extensions = { "json" } },
  { format = "yaml", extensions = { "yaml", "yml" } },
  -- { format = "toml", extensions = { "toml" } }
}

local function SubmitData(data, modGUID)
  CLUtils.Info(Strings.PREFIX .. "Entering SubmitData")
  if data.Origins ~= nil then
    OriginDataHandler(data.Origins, modGUID)
  end

  if data.ClassDescriptions ~= nil then
    ClassDescriptionDataHandler(data.ClassDescriptions, modGUID)
  end

  if data.Progressions ~= nil then
    ProgressionDataHandler(data.Progressions, modGUID)
  end

  if data.Feats ~= nil then
    FeatDataHandler(data.Feats, modGUID)
  end

  if data.Races ~= nil then
    RaceDataHandler(data.Races, modGUID)
  end

  if data.Lists ~= nil then
    ListDataHandler(data.Lists, modGUID)
  end

  if data.ActionResourceGroups ~= nil then
    ActionResourceGroupDataHandler(data.ActionResourceGroups, modGUID)
  end

  if data.Spells ~= nil then
    SpellDataHandler(data.Spells, modGUID)
  end

  if data.Backgrounds ~= nil then
    BackgroundDataHandler(data.Backgrounds, modGUID)
  end

  if data.BackgroundGoals ~= nil then
    BackgroundGoalDataHandler(data.BackgroundGoals, modGUID)
  end

  if data.ActionResources ~= nil then
    ActionResourceDataHandler(data.ActionResources, modGUID)
  end
end

---@param configStr string
---@param modGUID GUIDSTRING
---@param format "json"|"yaml"
local function TryLoadConfig(configStr, modGUID, format)
  CLUtils.Info(Strings.PREFIX .. "Entering TryLoadConfig (" .. format .. ")")
  local success, data
  if format == "yaml" then
    success, data = pcall(YamlParser.parse, configStr)
  else
    success, data = pcall(Ext.Json.Parse, configStr)
  end
  if success then
    if data ~= nil then
      SubmitData(data, modGUID)
    end
  else
    local errStr = (format == "yaml") and Strings.ERR_YAML_PARSE_FAIL or Strings.ERR_JSON_PARSE_FAIL
    CLUtils.Error(Strings.PREFIX .. errStr .. CLUtils.RetrieveModHandleAndAuthor(modGUID))
  end
end

function LoadConfigFiles()
  CLUtils.Info(Strings.PREFIX .. "Entering LoadConfigFiles")
  for _, uuid in pairs(Ext.Mod.GetLoadOrder()) do
    local modData = Ext.Mod.GetMod(uuid)
    local modName = modData.Info.Name
    local found = false

    -- Try each format in priority order (JSON first for backwards compatibility)
    for _, entry in ipairs(configFormats) do
      if found then break end
      for _, ext in ipairs(entry.extensions) do
        local filePath = (configBasePattern .. ext):format(modData.Info.Directory)
        local config = Ext.IO.LoadFile(filePath, "data")
        if config ~= nil and config ~= "" then
          CLUtils.Info(Strings.PREFIX .. "Found " .. ext .. " config for Mod: " .. modName)
          local b, err = xpcall(TryLoadConfig, debug.traceback, config, uuid, entry.format)
          if not b then
            CLUtils.Error(Strings.PREFIX .. err)
          end
          found = true
          break
        end
      end
    end
  end
end
