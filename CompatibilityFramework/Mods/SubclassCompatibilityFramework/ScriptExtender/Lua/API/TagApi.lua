local function HandleTagPayload(payloads, actionType)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
    else
      if not Globals.AllowPayloads then
        Utils.AddToLateLoaders(payload.modGuid)
      end
      HandleTags(payload, actionType)
    end
  end
end

function Api.InsertTags(payloads)
  HandleTagPayload(payloads, 'Add')
end

function Api.RemoveTags(payloads)
  HandleTagPayload(payloads, 'Remove')
end
