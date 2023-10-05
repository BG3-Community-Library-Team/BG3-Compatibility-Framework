Validators = {}

function DoValidation(payload, params)
  local err

  for key, val in pairs(params.Validators) do
    err = Validators[key](payload, params, val)

    if err ~= nil then
      return err
    end
  end
end

function Validators.IsPayloadEmpty(payload, params, val)
  if payload == nil then
    return val
  end
end

function Validators.IsPayloadValid(payload, params, val)
  local missingFields = {}
  for field in pairs(params.ExpectFields) do
    if payload[field] == nil then
      table.insert(missingFields, field)
    end
  end

  return val .. table.concat(missingFields, ", ")
end

function Validators.IsModLoaded(payload, params, val)
  if not Ext.IsModLoaded(payload.modGuid) then
    return val .. payload.modGuid
  end
end

function Validators.IsInTable(payload, params, val)
  if Utils.IsInTable(params.Table, payload.Name) then
    return val
  end
end

function Validators.DoesExist(payload, params, val)
  if not Utils.IsInTable(params.Table, payload.Name) then
    return val
  end
end
