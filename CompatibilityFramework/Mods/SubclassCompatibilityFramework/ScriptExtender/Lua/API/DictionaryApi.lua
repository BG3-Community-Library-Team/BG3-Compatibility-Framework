local function ValidateApiCall(payload, params)
  params.Validators = params.Validators or {}
  -- Default Validation
  table.insert(params.Validators, { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD })
  table.insert(params.Validators, { IsPayloadValid = Strings.ERROR_PAYLOAD_MISSING_FIELD })
  table.insert(params.Validators, { IsModLoaded = Strings.ERROR_MOD_NOT_LOADED })

  return DoValidation(payload, params)
end

local function Register(payload, params)
  local err = ValidateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(err)
    return
  end
  if params.Type == "complex" then
    if params.Table[payload.Name] == nil then
      params.Table[payload.Name] = {}
    end

    Utils.MergeTables(params.Table[payload.Name], payload.Obj)
  else
    params.Table[payload.Name] = payload.Guid
  end
end

local function Retrieve(payload, params)
  local err = ValidateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(error)
    return
  end

  return Utils.IsInTable_Nested[payload.Name]
end

-- Action Resources
function Api.RegisterActionResourceID(payload)
  Register(payload, {
    Table = Globals.ActionResources,
    Validators = { IsInTable = Strings.ERROR_ACTION_RESOURCE_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetActionResourcesID(payload)
  return Retrieve(payload, {
    Table = Globals.ActionResources,
    Validators = { DoesExist = Strings.ERROR_ACTION_RESOURCE_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Action Resource Groups
function Api.RegisterActionResourceGroupID(payload)
  Register(payload, {
    Table = Globals.ActionResourcesGroup,
    Validators = { IsInTable = Strings.ERROR_ACTION_RESOURCE_GROUP_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetActionResourceGroupID(payload)
  return Retrieve(payload, {
    Table = Globals.ActionResourceGroups,
    Validators = { DoesExist = Strings.ERROR_ACTION_RESOURCE_GROUP_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Feats
function Api.RegisterFeatID(payload)
  Register(payload, {
    Table = Globals.Feats,
    Validators = { IsInTable = Strings.ERROR_FEAT_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetFeatID(payload)
  return Retrieve(payload, {
    Table = Globals.Feats,
    Validators = { DoesExist = Strings.ERROR_FEAT_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Progressions
function Api.RegisterProgressionID(payload)
  Register(payload, {
    Table = Globals.Progressions,
    Type = "complex",
    -- Validators = { IsInTable = Strings.ERROR_PROGRESSION_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetProgressionID(payload)
  return Retrieve(payload, {
    Table = Globals.Progressions,
    Validators = { DoesExist = Strings.ERROR_PROGRESSION_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Equipment Lists
function Api.RegisterEquipmentListID(payload)
  Register(payload, {
    Table = Globals.EquipmentLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_EQUIPMENT }
  })
end

function Api.GetEquipmentListID(payload)
  return Retrieve(payload, {
    Table = Globals.EquipmentLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_EQUIPMENT }
  })
end

-- Passive Lists
function Api.RegisterPassiveListIDs(payload)
  return Register(payload, {
    Table = Globals.PassiveLists,
    Type = "complex",
    -- Validators = {}
  })
end

function Api.GetPassiveListIDs(payload)
  return Retrieve(payload, {
    Table = Globals.PassiveLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_PASSIVE }
  })
end

-- Spell Lists
function Api.RegisterSpellListIDs(payload)
  return Register(payload, {
    Table = Globals.SpellLists,
    Type = "complex",
    -- Validators = {}
  })
end

function Api.GetSpellListIDs(payload)
  return Retrieve(payload, {
    Table = Globals.SpellLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SPELL }
  })
end

-- Skill Lists
function Api.RegisterSkillListIDs(payload)
  return Register(payload, {
    Table = Globals.SkillLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_SKILL }
  })
end

function Api.GetSkillListIDs(payload)
  return Retrieve(payload, {
    Table = Globals.SkillLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SKILL }
  })
end

-- Ability Lists
function Api.RegisterAbilityListIDs(payload)
  return Register(payload, {
    Table = Globals.AbilityLists,
    Validators = { IsInTable = Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_ABILITY }
  })
end

function Api.GetAbilityListIDs(payload)
  return Retrieve(payload, {
    Table = Globals.AbilityLists,
    Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_ABILITIES }
  })
end
