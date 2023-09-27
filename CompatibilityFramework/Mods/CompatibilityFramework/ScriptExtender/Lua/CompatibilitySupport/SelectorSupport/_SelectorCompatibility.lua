local function BuildSelectSpellsTable(params)
  return {
    SpellUUID = params.Guid,
    Amount = params.Amount or "1",
    Arg3 = params.Prepared or "0",
    SelectorId = params.SelectorId or "",
    CastingAbility = params.CastingAbility or "",
    ActionResource = params.ActionResource or "",
    PrepareType = params.PrepareType or "Default",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildAddSpellsTable(params)
  return {
    SpellUUID = params.Guid,
    SelectorId = params.Descriptor or "",
    Ability = params.CastingAbility or "",
    ActionResource = params.ActionResource or "",
    PrepareType = params.PrepareType or "Default",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildSelectPassivesOrEquipmentTable(params)
  return {
    UUID = params.Guid,
    Amount = params.Amount or "",
    Arg3 = params.SelectorId or ""
  }
end

local function BuildSelectAbilityBonusTable(params)
  return {
    UUID = params.Guid,
    Amount = params.Amount or "0",
    BonusType = params.BonusType or "AbilityBonus",
    Amounts = params.Amounts or { "2", "1" }
  }
end

local function BuildSelectSkillsTable(params)
  return {
    UUID = params.Guid,
    Amount = params.Amount or "0",
    Arg3 = params.SelectorId or ""
  }
end

local function BuildSelectSkillsExpertiseTable(params)
  return {
    UUID = params.Guid,
    Amount = params.Amount or "0",
    Arg3 = params.LimitToProficiency or params.Arg3 or true,
    Arg4 = params.SelectorId or params.Arg4 or ""
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
  if payload.Function == Globals.SelectorFunctions.SelectPassives or payload.Function == Globals.SelectorFunctions.SelectEquipment then
    return BuildSelectPassivesOrEquipmentTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectAbilityBonus then
    return BuildSelectAbilityBonusTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectSkills then
    return BuildSelectSkillsTable(payload.Params)
  end
  if payload.Function == Globals.SelectorFunctions.SelectSkillsExpertise then
    return BuildSelectSkillsExpertiseTable(payload.Params)
  end
end

local function AddSelector(payload)
  Utils.Info("Entering AddSelector")
  local selectorField = Utils.CacheOrRetrieveProgression(payload.TargetProgression)[payload.Function]

  table.insert(selectorField, BuildSelector(payload))
end

function HandleSelector(payload)
  if payload ~= nil then
    Utils.Info("Entering HandleSelector")
    AddSelector(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
