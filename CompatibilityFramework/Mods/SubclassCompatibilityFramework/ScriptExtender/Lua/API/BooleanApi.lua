function Api.SetBoolean(payloads)
  Utils.Info("Entering API.SetBoolean")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payload, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD } })

    if err ~= nil then
      Utils.Error(error)
      return
    end
    HandleBoolean(payload)
  end
end
