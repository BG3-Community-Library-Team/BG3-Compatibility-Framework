local function BackgroundGoalSubSectionHandler(data, goalUUID, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering BackgroundGoalSubSectionHandler")

  if data.Fields ~= nil then
    for _, field in pairs(data.Fields) do
      JsonUtils.ParseAndSubmitFields(field, goalUUID, modGuid, "BackgroundGoal")
    end
  end
end

function BackgroundGoalDataHandler(data, modGuid)
  CLUtils.Info(Strings.PREFIX .. "Entering BackgroundGoalDataHandler")

  for _, goal in pairs(data) do
    for _, uuid in pairs(JsonUtils.ResolveUUIDs(goal, modGuid)) do
      BackgroundGoalSubSectionHandler(goal, uuid, modGuid)
    end
  end
end
