-- For inserting children nodes into a Race
function Api.InsertRaceChildData(payloads)
  Utils.Info("Entering API.InsertRaceChildData")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payload, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD } })

    if err ~= nil then
      Utils.Error(error)
      return
    end

    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    RaceChildHandler(payload)
  end
end

function Api.RemoveRaceChildData(payloads)
  Utils.Info("Entering API.RemoveRaceChildData")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payloads, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD, IsModLoaded = Strings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      Utils.Warn(err)
      return
    end

    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    RaceChildRemovalHandler(payload)
  end
end
