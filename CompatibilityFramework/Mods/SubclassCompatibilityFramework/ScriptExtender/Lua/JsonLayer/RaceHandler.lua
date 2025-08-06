local function ParseAndSubmitEntries(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitEntries")
    for _, child in pairs(data.Children) do
    for _, value in pairs(child.Values) do
      JsonUtils.Endpoints[child.Action].Race({ JsonUtils.BuildRacePayloads(data, modGuid, { Type = child.Type, Value = value }) })
    end
  end
end

function RaceJsonHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceJsonHandler")
  for _, race in pairs(data) do
    ParseAndSubmitEntries(race, modGuid)
  end
end
