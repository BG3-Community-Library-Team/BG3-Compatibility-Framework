function Api.SetBoolean(payloads)
  Utils.Info("Entering API.SetBoolean")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payload, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD, IsModLoaded = Strings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Utils.Warn(err)
      return
    end
    HandleBoolean(payload)
  end
end
