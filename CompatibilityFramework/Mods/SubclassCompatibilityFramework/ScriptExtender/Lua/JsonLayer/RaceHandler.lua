local function ParseAndSubmitEntries(data, modGuid)
  Utils.Info("Entering ParseAndSubmitEntries")
  local payloads = {
    Insert = JsonUtils.BuilRacePayloads(data, modGuid, "Insert"),
    Remove = JsonUtils.BuildRacePayloads(data, modGuid, "Remove")
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      JsonUtils.Endpoints[action].Race({ payload })
    end
  end
end

function RaceJsonHandler(data, modGuid)
  Utils.Info("Entering RaceJsonHandler")
  for _, races in pairs(data) do
    ParseAndSubmitEntries(races, modGuid)
  end
end
