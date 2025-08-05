function Api.ClassBlacklist(payloads)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      {
        Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.VAL_ERR_MOD_NOT_LOADED }
      })
    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
      return
    end
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    BlacklistHandler(payload, "Class")
  end
end
