Validators = {}

function DoValidation(payload, params)
  local err

  for fn in pairs(params) do
    err = Validators[fn](payload, params)

    if err ~= nil then
      return err
    end
  end
end

function Validators.IsPayloadEmpty(payload, params)
  if payload == nil then
    return Strings.ERROR_EMPTY_PAYLOAD
  end
end

function Validators.IsPayloadValid(payload, params)
  for field in pairs(params.ExpectFields) do
    if payload[field] == nil then
      return Strings.ERROR_PAYLOAD_MISSING_FIELD .. field
    end
  end
end

function Validators.IsModLoaded(payload, params)
  if not Ext.IsModLoaded(payload.modGuid) then
    return Strings.ERROR_MOD_NOT_LOADED .. payload.modGuid
  end
end
