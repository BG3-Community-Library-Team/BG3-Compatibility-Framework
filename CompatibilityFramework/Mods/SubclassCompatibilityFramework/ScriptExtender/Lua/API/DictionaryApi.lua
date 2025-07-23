local function ValidateApiCall(payload, params)
  params.Validators = params.Validators or {}
  -- Default Validation
  table.insert(params.Validators, { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD })
  table.insert(params.Validators, { IsPayloadValid = CLStrings.ERROR_PAYLOAD_MISSING_FIELD })
  table.insert(params.Validators, { IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED })

  return CLUtils.DoValidation(payload, params)
end

local function Register(payload, params)
  local err = ValidateApiCall(payload, params)

  if err ~= nil then
    CLUtils.Error(Strings.PREFIX .. err)
    return
  end
  if params.Type == "complex" then
    if params.Table[payload.Name] == nil then
      params.Table[payload.Name] = {}
    end

    params.Table[payload.Name] = CLUtils.MergeTables(params.Table[payload.Name], payload.Obj)
  else
    params.Table[payload.Name] = payload.Guid
  end
end

local function Retrieve(payload, params)
  local err = ValidateApiCall(payload, params)

  if err ~= nil then
    CLUtils.Error(Strings.PREFIX .. err)
    return
  end

  return CLUtils.IsInTable_Nested[payload.Name]
end

-- Action Resources
function Api.RegisterActionResourceID(payload)
  Register(payload, {
    Table = CLGlobals.ActionResources,
    Validators = { IsInTable = CLStrings.ERROR_ACTION_RESOURCE_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetActionResourcesID(payload)
  return Retrieve(payload, {
    Table = CLGlobals.ActionResources,
    Validators = { DoesExist = CLStrings.ERROR_ACTION_RESOURCE_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Action Resource Groups
function Api.RegisterActionResourceGroupID(payload)
  Register(payload, {
    Table = CLGlobals.ActionResourcesGroup,
    Validators = { IsInTable = CLStrings.ERROR_ACTION_RESOURCE_GROUP_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetActionResourceGroupID(payload)
  return Retrieve(payload, {
    Table = CLGlobals.ActionResourceGroups,
    Validators = { DoesExist = CLStrings.ERROR_ACTION_RESOURCE_GROUP_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Feats
function Api.RegisterFeatID(payload)
  Register(payload, {
    Table = CLGlobals.Feats,
    Validators = { IsInTable = CLStrings.ERROR_FEAT_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetFeatID(payload)
  return Retrieve(payload, {
    Table = CLGlobals.Feats,
    Validators = { DoesExist = CLStrings.ERROR_FEAT_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Progressions
function Api.RegisterProgressionID(payload)
  Register(payload, {
    Table = CLGlobals.Progressions,
    Type = "complex",
    -- Validators = { IsInTable = Strings.ERROR_PROGRESSION_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetProgressionID(payload)
  return Retrieve(payload, {
    Table = CLGlobals.Progressions,
    Validators = { DoesExist = CLStrings.ERROR_PROGRESSION_DOES_NOT_EXIST_IN_DICTIONARY }
  })
end

-- Equipment Lists
function Api.RegisterEquipmentListID(payload)
  Register(payload, {
    Table = CLGlobals.EquipmentLists,
    Validators = { IsInTable = CLStrings.ERROR_LIST_EXISTS_IN_DICTIONARY_EQUIPMENT }
  })
end

function Api.GetEquipmentListID(payload)
  return Retrieve(payload, {
    Table = CLGlobals.EquipmentLists,
    Validators = { DoesExist = CLStrings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_EQUIPMENT }
  })
end

-- Passive Lists
function Api.RegisterPassiveListIDs(payload)
  return Register(payload, {
    Table = CLGlobals.PassiveLists,
    Type = "complex",
    -- Validators = {}
  })
end

function Api.GetPassiveListIDs(payload)
  return Retrieve(payload, {
    Table = CLGlobals.PassiveLists,
    Validators = { DoesExist = CLStrings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_PASSIVE }
  })
end

-- Spell Lists
function Api.RegisterSpellListIDs(payload)
  return Register(payload, {
    Table = CLGlobals.SpellLists,
    Type = "complex",
    -- Validators = {}
  })
end

function Api.GetSpellListIDs(payload)
  return Retrieve(payload, {
    Table = CLGlobals.SpellLists,
    Validators = { DoesExist = CLStrings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SPELL }
  })
end

-- Skill Lists
function Api.RegisterSkillListIDs(payload)
  return Register(payload, {
    Table = CLGlobals.SkillLists,
    Validators = { IsInTable = CLStrings.ERROR_LIST_EXISTS_IN_DICTIONARY_SKILL }
  })
end

function Api.GetSkillListIDs(payload)
  return Retrieve(payload, {
    Table = CLGlobals.SkillLists,
    Validators = { DoesExist = CLStrings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_SKILL }
  })
end

-- Ability Lists
function Api.RegisterAbilityListIDs(payload)
  return Register(payload, {
    Table = CLGlobals.AbilityLists,
    Validators = { IsInTable = CLStrings.ERROR_LIST_EXISTS_IN_DICTIONARY_ABILITY }
  })
end

function Api.GetAbilityListIDs(payload)
  return Retrieve(payload, {
    Table = CLGlobals.AbilityLists,
    Validators = { DoesExist = CLStrings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_ABILITIES }
  })
end
