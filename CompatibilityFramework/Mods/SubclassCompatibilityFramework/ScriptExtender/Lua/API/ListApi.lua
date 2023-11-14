-- Handles SpellLists, SkillLists, and PassiveLists
function Api.InsertToList(payloads)
  for _, payload in pairs(payloads) do
    local err = DoValidation(payload,
      { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD, IsModLoaded = Strings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Utils.Warn(err)
    else
      if not Globals.AllowPayloads then
        Utils.AddToLateLoaders(payload.modGuid)
      end
      HandleList(payload)
    end
  end
end
