-- Handles SpellLists, SkillLists, and PassiveLists
function Api.InsertToList(payloads)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      CLUtils.Warn(err)
    else
      if not Globals.AllowPayloads then
        Utils.AddToLateLoaders(payload.modGuid)
      end
      HandleList(payload)
    end
  end
end
