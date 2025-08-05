-- Handles SpellLists, SkillLists, and PassiveLists
function Api.InsertToList(payloads)
  Api.HandleListPayload(payloads, 'Add')
end

function Api.RemoveFromList(payloads)
  Api.HandleListPayload(payloads, 'Remove')
end

function Api.HandleListPayload(payloads, actionType)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
    else
      if not Globals.AllowPayloads then
        Utils.AddToLateLoaders(payload.modGuid)
      end
      HandleList(payload, actionType)
    end
  end
end
