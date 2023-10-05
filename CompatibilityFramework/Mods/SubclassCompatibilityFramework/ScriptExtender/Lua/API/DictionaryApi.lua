local function validateApiCall(payload, params)
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

local function retrieveSingular(payload, params)
  local err = validateApiCall(payload, params)

  if err ~= nil then
    Utils.Error(error)
    return
  end

  return params.Table[payload.Name]
end

local function AddMany(payload, params)
  -- TODO
end

local function retrieveMany(payload, params)

end

-- Feats
function Api.RegisterFeatID(payload)
  AddSingular(payload, {
    Table = Globals.Feats,
    Validators = { IsInTable = Strings.ERROR_FEAT_EXISTS_IN_DICTIONARY }
  })
end

function Api.GetFeatID(payload)
    return retrieveSingular(payload, {
        Table = Globals.Feats,
        Validators = { DoesExist = Strings.ERROR_FEAT_DOES_NOT_EXIST_IN_DICTIONARY }
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
  return retrieveSingular(payload, {
      Table = Globals.EquipmentLists,
      Validators = { DoesExist = Strings.ERROR_LIST_DOES_NOT_EXIST_IN_DICTIONARY_EQUIPMENT }
})
end

-- Passive Lists
function Api.RegisterPassiveListIDs(payload)

end

function Api.GetPassiveListIDs(name)
  return Globals.PassiveLists[name]
end
