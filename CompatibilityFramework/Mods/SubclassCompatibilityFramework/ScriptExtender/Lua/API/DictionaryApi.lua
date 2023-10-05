local function validateApiCall(payload, params)
  -- Default Validation
  table.insert(params.Validators, { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD })
  table.insert(params.Validators, { IsPayloadValid = Strings.ERROR_PAYLOAD_MISSING_FIELD })
  table.insert(params.Validators, { IsModLoaded = Strings.ERROR_MOD_NOT_LOADED })

  return DoValidation(payload, params)
end

local function AddSingular(payload, params)
  local err = validateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(err)
    return
  end

  params.Table[payload.Name] = payload.Guid
end

--[[
local function AddNested(payload, params)
    local err = validateApiCall(payload, params)

    if err ~= nil then
        Utils.Error(err)
        return
    end
    local resultTable = params.Table
    local temp_table = {}

    for key in string.gmatch(payload.Name, "[^.]+") do
        if resultTable[key] == nil then
            resultTable[key] = {}
            temp_table = temp_table[key]
        end
    end
end
]]--

local function AddProgression(payload, params)
  local err = validateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(err)
    return
  end

end

local function AddSpellList(payload, params)
  local err = validateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(err)
    return
  end

end

local function AddPassiveList(payload, params)
  local err = validateApiCall(payload, params)

    if err ~= nil then
        Utils.Error(err)
        return
    end

    -- Passives only have two levels to worry about
    if params.Table[payload.Name] == nil then
      params.Table[payload.Name] = {}
    end
    
    if payload.GuidKey ~= nil then
      params.Table[payload.Name][payload.GuidKey] = payload.Guid
    else
      table.insert(params.Table[payload.Name], payload.GuidKey)
    end
end

local function retrieve(payload, params)
  local err = validateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(error)
    return
  end

  return Utils.IsInTable_Nested[payload.Name]
end

-- Feats
function Api.RegisterFeatID(payload)
  AddSingular(payload, {
    Table = Globals.Feats,
    Validators = { IsInTable = Strings.ERROR_FEAT_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetFeatID(payload)
  return retrieve(payload, {
    Table = Globals.Feats,
    Validators = { DoesExist = Strings.ERROR_FEAT_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Progressions
function Api.RegisterProgressionID(payload)
  AddProgression(payload, {
    Table = Globals.Progressions,
    Validators = { IsInTable = Strings.ERROR_PROGRESSION_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetProgressionID(payload)
  return retrieve(payload, {
    Table = Globals.Progressions,
    Validators = { DoesExist = Strings.ERROR_PROGRESSION_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Equipment Lists
function Api.RegisterEquipmentListID(payload)
  AddSingular(payload, {
    Table = Globals.EquipmentLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_EQUIPMENT }
  })
end

function Api.GetEquipmentListID(payload)
  return retrieve(payload, {
    Table = Globals.EquipmentLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_EQUIPMENT }
  })
end

-- Passive Lists
function Api.RegisterPassiveListIDs(payload)
  return AddPassiveList(payload, {
    Table = Globals.PassiveLists,
    Validators = {}
  })
end

function Api.GetPassiveListIDs(payload)
  return retrieve(payload, {
    Table = Globals.PassiveLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_PASSIVE }
  })
end

-- Spell Lists
function Api.RegisterSpellListIDs(payload)
  return AddSpellList(payload, {
    Table = Globals.SpellLists,
    Validators = {}
  })
end

function Api.GetSpellListIDs(payload)
  return retrieve(payload, {
    Table = Globals.SpellLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SPELL }
  })
end

-- Skill Lists
function Api.RegisterSkillListIDs(payload)
  return AddSingular(payload, {
    Table = Globals.SkillLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_SKILL }
  })
end

function Api.GetSkillListIDs(payload)
  return retrieve(payload, {
    Table = Globals.SkillLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SKILL }
  })
end

-- Ability Lists
function Api.RegisterAbilityListIDs(payload)
  return AddSingular(payload, {
    Table = Globals.AbilityLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_ABILITY }
  })
end

function Api.GetAbilityListIDs(payload)
  return retrieve(payload, {
    Table = Globals.AbilityLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_ABILITIES }
  })
end
