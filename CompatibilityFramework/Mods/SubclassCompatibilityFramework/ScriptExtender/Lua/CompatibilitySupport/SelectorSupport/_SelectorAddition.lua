local function BuildSelectSpellsTable(params)
  local castingAbility = params.CastingAbility
  if not CLUtils.IsInTable(CLGlobals.Attributes, params.CastingAbility) then
    castingAbility = "None"
  end

  return {
    SpellUUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.SwapAmount or params.Prepared or "0",
    SelectorId = params.SelectorId or params.Descriptor or "",
    CastingAbility = castingAbility,
    ClassUUID = params.ClassUUID or "00000000-0000-0000-0000-000000000000",
    ActionResource = params.ActionResource or "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    PrepareType = params.PrepareType or "Unknown",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildAddSpellsTable(params)
  local castingAbility = params.CastingAbility
  if not CLUtils.IsInTable(CLGlobals.Attributes, params.CastingAbility) then
    castingAbility = "None"
  end
  return {
    SpellUUID = params.Guid or params.UUID,
    SelectorId = params.SelectorId or params.Descriptor or  "",
    Ability = castingAbility or "None",
    ActionResource = params.ActionResource or "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    PrepareType = params.PrepareType or "Unknown",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildSelectPassiveTable(params)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildSelectPassiveTable")
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Amount2 = params.ReplaceAmount or "0",
    Arg3 = params.SelectorId or params.Descriptor or  ""
  }
end

local function BuildSelectEquipmentTable(params)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildSelectEquipmentTable")
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.SelectorId or params.Descriptor or  ""
  }
end

local function BuildSelectAbilitiesTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Arg2 = params.Amount or "1",
    Arg3 = params.AbilityAmount or "1",
    Arg4 = params.SelectorId or params.Descriptor or  ""
  }
end

local function BuildSelectAbilityBonusTable(params)
  local defaultAmount = "2"
  if params.Amounts then
    defaultAmount = tostring(#(params.Amounts))
  end
  return {
    UUID = params.Guid or params.UUID,
    BonusType = params.BonusType or "AbilityBonus",
    Amount = params.Amount or defaultAmount,
    Amounts = params.Amounts or { "2", "1" }
  }
end

local function BuildSelectSkillsTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.SelectorId or params.Descriptor or  ""
  }
end

local function BuildSelectSkillsExpertiseTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.LimitToProficiency or params.Arg3 or true,
    Arg4 = params.SelectorId or params.Descriptor or  params.Arg4 or ""
  }
end

local function BuildSelector(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering BuildSelector")
  if payload.Function == CLGlobals.SelectorFunctions.SelectSpells then
    return BuildSelectSpellsTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.AddSpells then
    return BuildAddSpellsTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectPassives then
    return BuildSelectPassiveTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.ReplacePassives then
    return BuildSelectPassiveTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectEquipment then
    return BuildSelectEquipmentTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectAbilityBonus then
    return BuildSelectAbilityBonusTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectAbilities then
    return BuildSelectAbilitiesTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectSkills then
    return BuildSelectSkillsTable(payload.Params)
  end
  if payload.Function == CLGlobals.SelectorFunctions.SelectSkillsExpertise then
    return BuildSelectSkillsExpertiseTable(payload.Params)
  end
end

local function AddSelector(payload)
  CLUtils.Info(Strings.PREFIX .. "Entering AddSelector for " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
  Utils.ShipToQueue(payload, BuildSelector(payload), "Selectors", payload.Function)
end

function HandleSelector(payload)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleSelector")
    AddSelector(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
