local function BuildSelectSpellsTable(params)
  local castingAbility = params.CastingAbility
  if not Utils.IsInTable(Globals.Attributes, params.CastingAbility) then
    castingAbility = "None"
  end

  return {
    SpellUUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
    Arg3 = params.SwapAmount or params.Prepared or "0",
    SelectorId = params.SelectorId or "",
    CastingAbility = castingAbility,
    ClassUUID = params.ClassUUID or "00000000-0000-0000-0000-000000000000",
    ActionResource = params.ActionResource or "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    PrepareType = params.PrepareType or "Unknown",
    CooldownType = params.CooldownType or "Default"
  }
end

local function BuildAddSpellsTable(params)
  local castingAbility = params.CastingAbility
  if not Utils.IsInTable(Globals.Attributes, params.CastingAbility) then
    castingAbility = "None"
  end
  return {
    SpellUUID = params.Guid or params.UUID,
    SelectorId = params.Descriptor or "",
    Ability = castingAbility or "None",
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
    Arg3 = params.SelectorId or ""
  }
end

local function BuildSelectAbilitiesTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Arg2 = params.Amount or 1,
    Arg3 = params.AbilityAmount or 1,
    Arg4 = params.SelectorId or ""
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
    Arg3 = params.SelectorId or ""
  }
end

local function BuildSelectSkillsExpertiseTable(params)
  return {
    UUID = params.Guid or params.UUID,
    Amount = params.Amount or "1",
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

local function AddSelector(payload)
  Utils.Info("Entering AddSelector")
  local type = payload.FileType or "Progression"
  local target = payload.Target or payload.TargetProgression

  if Utils.IsKeyInTable(Globals.ModuleTypes[type]) and payload.Selectors ~= nil then
    local queueType = Globals.ModuleTypes[payload.FileType]
    local fleshedObject = Utils.CacheOrRetrieve(target, type)
    if fleshedObject ~= nil then
      if Queue[queueType][target] == nil then
        Queue[queueType][target] = {}
      end
      if Queue[queueType][target][payload.Function] == nil then
        Queue[queueType][target][payload.Function] = {}
      end

      local selectorToInsert = BuildSelector(payload)
      table.insert(Queue[queueType][target][payload.Function], selectorToInsert)
    else
      Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
    end
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
