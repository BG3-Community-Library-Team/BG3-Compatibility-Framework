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
    if goal.UUIDs ~= nil then
      for _, uuid in pairs(goal.UUIDs) do
        BackgroundGoalSubSectionHandler(goal, uuid, modGuid)
      end
    elseif type(goal.UUID) == "table" then
      CLUtils.Warn(Strings.PREFIX .. "Mod " .. CLUtils.RetrieveModHandleAndAuthor(modGuid) ..
        Strings.VAL_ERR_UUID_IS_TABLE .. table.concat(goal.UUID, ", ") ..
        Strings.VAL_ERR_UUID_IS_TABLE_B)
      for _, uuid in pairs(goal.UUID) do
        BackgroundGoalSubSectionHandler(goal, uuid, modGuid)
      end
    elseif goal.UUID ~= nil then
      BackgroundGoalSubSectionHandler(goal, goal.UUID, modGuid)
    end
  end
end
