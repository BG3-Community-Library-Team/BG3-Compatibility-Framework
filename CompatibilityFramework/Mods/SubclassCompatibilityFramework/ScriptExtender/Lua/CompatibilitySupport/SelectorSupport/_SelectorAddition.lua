local function BuildSelectSpellsTable(params)
  return {
    SpellUUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.Prepared or "0",
    SelectorId = params.SelectorId or " ",
    CastingAbility = params.CastingAbility or "None",
    ActionResource = params.ActionResource or "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    PrepareType = params.PrepareType or "Unknown",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildAddSpellsTable(params)
  return {
    SpellUUID = params.Guid or params.UUID,
    SelectorId = params.Descriptor or " ",
    Ability = params.CastingAbility or "None",
    ActionResource = params.ActionResource or "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    PrepareType = params.PrepareType or "Unknown",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildSelectPassivesOrEquipmentTable(params)
  Utils.Info("Entering BuildSelectPassivesOrEquipmentTable")
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or 1,
    Arg3 = params.SelectorId or " "
  }
end

local function BuildSelectAbilitiesTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Arg2 = params.Amount or 1,
    Arg3 = params.AbilityAmount or 1,
    Arg4 = params.SelectorId or " "
  }
end

local function BuildSelectAbilityBonusTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    BonusType = params.BonusType or "AbilityBonus",
    Amounts = params.Amounts or { "2", "1" }
  }
end

local function BuildSelectSkillsTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.SelectorId or " "
  }
end

local function BuildSelectSkillsExpertiseTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.LimitToProficiency or params.Arg3 or true,
    Arg4 = params.SelectorId or params.Arg4 or " "
  }
end

local function BuildSelector(payload)
  Utils.Info("Entering BuildSelector")
  if payload.Function == Globals.SelectorFunctions.SelectSpells then
    return BuildSelectSpellsTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.AddSpells then
    return BuildAddSpellsTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectPassives then
    return BuildSelectPassivesOrEquipmentTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.ReplacePassives then
    return BuildSelectPassivesOrEquipmentTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectEquipment then
    return BuildSelectPassivesOrEquipmentTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectAbilityBonus then
    return BuildSelectAbilityBonusTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectAbilities then
    return BuildSelectAbilitiesTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectSkills then
    return BuildSelectSkillsTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectSkillsExpertise then
    return BuildSelectSkillsExpertiseTable(payload.Params)
  end
end

local function IsPayloadInSelector(selectorField, selectorToInsert, idType)
  local found = false

  local newSelectorID = selectorToInsert[idType]
  for _, value in pairs(selectorField) do
    local valID = value[idType]
    if valID == newSelectorID then
      found = true
    end
  end
  return found
end

local function AddSelector(payload)
  Utils.Info("Entering AddSelector")
  local target = payload.Target or payload.TargetProgression
  local type = payload.FileType or "Progression"
  local targetObj = Utils.CacheOrRetrieve(target, type)
  local selectorField = targetObj[payload.Function]
  local selectorToInsert = BuildSelector(payload)

  if not IsPayloadInSelector(selectorField, selectorToInsert, Globals.SelectorIdTypes[payload.Function]) then
    targetObj[payload.Function] = Utils.MergeTables(selectorField, { selectorToInsert })
  end
end

function HandleSelector(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleSelector")
    AddSelector(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
