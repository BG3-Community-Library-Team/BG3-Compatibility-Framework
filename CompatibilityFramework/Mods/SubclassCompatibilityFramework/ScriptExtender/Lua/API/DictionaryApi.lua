-- Retrieval Endpoints for navigating the Dictionary
local function validateApiCall(payload, params)
  local err
  if payload ~= nil then
    err = Strings.ERROR_EMPTY_PAYLOAD
  end

  if not Ext.IsModLoaded(payload.modGuid) then
    err = Strings.ERROR_MOD_NOT_LOADED .. payload.modGuid
  end

  if Utils.IsInTable(params.Table, payload.Name) then
    err = params.ErrorString
  end
  if err ~= nil then
    return err
  end
end

local function AddSingular(dict, payload, errString)
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

-- Adding a Feat to the Dictionary
function Api.RegisterFeatID(payload)
  AddSingular(Globals.Feats, payload, Strings.ERROR_FEAT_EXISTS_IN_DICTIONARY)
end

function Api.GetFeatID(name)
    return Globals.Feats[name]
end

function Api.RegisterEquipmentListID(payload)
  AddSingular(Globals.EquipmentLists, payload, Strings.ERROR_LIST_EXISTS_IN_DICTIONARY_EQUIPMENT)
end

function Api.GetEquipmentListID(name)
  return Globals.EquipmentLists[name]
end
