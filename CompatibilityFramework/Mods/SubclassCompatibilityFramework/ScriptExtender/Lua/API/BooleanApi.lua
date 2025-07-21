function Api.SetBoolean(payloads)
  CLUtils.Info("Entering API.SetBoolean")

  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      table.insert(Globals.ValidationErrors, err)
      return
    end
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    HandleBoolean(payload)
  end
end
