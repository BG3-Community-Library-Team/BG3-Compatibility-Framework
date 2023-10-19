-- For inserting children nodes into a Race
function Api.InsertRaceChildData(payloads)
  Utils.Info("Entering API.InsertRaceChildData")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payloads, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD } })

    if err ~= nil then
      Utils.Error(error)
      return
    end

    RaceChildHandler(payload)
  end
end

function Api.RemoveRaceChildData(payloads)
  Utils.Info("Entering API.RemoveRaceChildData")

  for _, payload in pairs(payloads) do
    local err = DoValidation(payloads, { Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD } })

    if err ~= nil then
      Utils.Error(error)
      return
    end

    RaceChildRemovalHandler(payload)
  end
end
