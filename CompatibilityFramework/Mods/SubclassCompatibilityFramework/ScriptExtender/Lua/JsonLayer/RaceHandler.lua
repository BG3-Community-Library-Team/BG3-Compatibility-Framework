local function ParseAndSubmitEntries(data, modGuid)
  Utils.Info("Entering ParseAndSubmitEntries")
  for _, child in pairs(data.Children) do
    JsonUtils.Endpoints[child.Action].Race({ JsonUtils.BuildRacePayloads(data, modGuid, child) })
  end
end

function RaceJsonHandler(data, modGuid)
  Utils.Info("Entering RaceJsonHandler")
  for _, race in pairs(data) do
    ParseAndSubmitEntries(race, modGuid)
  end
end
