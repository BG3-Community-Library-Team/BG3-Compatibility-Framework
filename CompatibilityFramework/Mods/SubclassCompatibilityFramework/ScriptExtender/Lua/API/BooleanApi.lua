function Api.SetBoolean(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering API.SetBoolean")

  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
      return
    end
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    HandleBoolean(payload)
  end
end

-- TODO: Merge this and SetBoolean eventually, they're very similar
function Api.SetField(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering Api.SetField")

  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
      return
    end
    
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    
    HandleField(payload)
  end

end