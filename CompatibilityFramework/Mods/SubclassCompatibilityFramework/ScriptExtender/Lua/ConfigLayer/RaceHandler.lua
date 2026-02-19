local function ParseAndSubmitEntries(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering ParseAndSubmitEntries")
  for _, child in pairs(data.Children) do
    local values = child.Values or (child.Value and { child.Value }) or {}

    for _, value in pairs(values) do
      JsonUtils.Endpoints[child.Action].Race({ JsonUtils.BuildRacePayloads(data, modGuid, { Type = child.Type, Value = value }) })
    end
  end
end

function RaceDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering RaceDataHandler")
  for _, race in pairs(data) do
    if race.ApplyToAllRaces then
      CLUtils.Info(Strings.PREFIX .. "ApplyToAllRaces flag detected, setting sentinel UUID")
      race.UUID = "ALL"
    end
    ParseAndSubmitEntries(race, modGuid)
  end
end
