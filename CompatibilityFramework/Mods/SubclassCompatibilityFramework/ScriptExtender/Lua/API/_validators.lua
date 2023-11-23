Validators = {}

function DoValidation(payload, params)
  local err

  for key, val in pairs(params.Validators) do
    err = Validators[key](payload, params, val)
    if err ~= nil then
      return Strings.ERROR_FAILED_VALIDATION .. err
    end
  end
end

function Validators.IsPayloadEmpty(payload, params, val)
  if payload == nil then
    return val
  end
end

function Validators.IsPayloadValid(payload, params, val)
  params.ExpectFields = params.ExpectFields or { "modGuid" }
  local missingFields = {}
  for _, field in pairs(params.ExpectFields) do
    if payload[field] == nil then
      table.insert(missingFields, field)
    end
  end

  return val .. table.concat(missingFields, ", ")
end

function Validators.IsModLoaded(payload, params, val)
  if not Ext.Mod.IsModLoaded(payload.modGuid) then
    return val .. payload.modGuid
  end
end

function Validators.IsInTable(payload, params, val)
  if Utils.IsInTable_Nested(params.Table, payload.Name) then
    return val
  end
end

function Validators.DoesExist(payload, params, val)
  if not Utils.IsInTable_Nested(params.Table, payload.Name) then
    return val
  end
end
