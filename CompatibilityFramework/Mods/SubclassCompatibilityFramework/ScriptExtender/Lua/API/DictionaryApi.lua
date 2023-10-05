local function validateApiCall(payload, params)
  return DoValidation(payload, params)
end

local function AddSingular(dict, payload, validators, errString)
  local err = validateApiCall(payload, {
    Table = Globals.Feats,
    ErrorString = errString,
  })

  if err ~= nil then
    Utils.Error(err)
    return
  end

  dict[payload.Name] = payload.Guid
end

local function AddMany(dict, payload, errString)
  -- TODO
end

-- Feats
function Api.RegisterFeatID(payload)
  AddSingular(Globals.Feats, payload, Strings.ERROR_FEAT_EXISTS_IN_DICTIONARY)
end

function Api.GetFeatID(name)
  return Globals.Feats[name]
end

-- Equipment Lists
function Api.RegisterEquipmentListID(payload)
  AddSingular(Globals.EquipmentLists, payload, Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_EQUIPMENT)
end

function Api.GetEquipmentListID(name)
  return Globals.EquipmentLists[name]
end

-- Passive Lists
function Api.RegisterPassiveListIDs(payload)

end

function Api.GetPassiveListIDs(name)
  return Globals.PassiveLists[name]
end
