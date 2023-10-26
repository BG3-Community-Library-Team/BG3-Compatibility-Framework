-- Handles SpellLists, SkillLists, and PassiveLists
function Api.InsertToList(payloads)
  for _, payload in pairs(payloads) do
    local err = DoValidation(payload, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD } })

    if err ~= nil then
      Utils.Error(error)
      return
    end

    HandleList(payload)
  end
end
