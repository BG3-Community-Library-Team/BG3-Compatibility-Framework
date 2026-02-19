-- For inserting children nodes into a Race
function Api.InsertRaceChildData(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering API.InsertRaceChildData")

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
    RaceChildHandler(payload)
  end
end

function Api.RemoveRaceChildData(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering API.RemoveRaceChildData")

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
    RaceChildRemovalHandler(payload)
  end
end

-- Convenience function: insert children into ALL loaded races
function Api.InsertRaceChildDataAll(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering API.InsertRaceChildDataAll")

  for _, payload in pairs(payloads) do
    payload.raceGuid = "ALL"
  end

  Api.InsertRaceChildData(payloads)
end

-- Convenience function: remove children from ALL loaded races
function Api.RemoveRaceChildDataAll(payloads)
  CLUtils.Info(Strings.PREFIX .. "Entering API.RemoveRaceChildDataAll")

  for _, payload in pairs(payloads) do
    payload.raceGuid = "ALL"
  end

  Api.RemoveRaceChildData(payloads)
end
