local Endpoints = {
  Insert = Api.InsertRaceChildData,
  Remove = Api.RemoveRaceChildData
}

local function BuildPayloads(data, modGuid, action)
  Utils.Info("Entering BuildPayloads")
  local count = 0
  local result = {
    modGuid = modGuid,
    raceGuid = data.UUID,
    children = {}
  }

  for _, child in pairs(data.Children) do
    if child.Action == action then
      result.children[tostring(count)] = { Type = child.Type, Value = child.Value }
      count = count + 1
    end
  end

  return result
end

local function ParseAndSubmitEntries(data, modGuid)
  Utils.Info("Entering ParseAndSubmitEntries")
  local payloads = {
    Insert = BuildPayloads(data, modGuid, "Insert"),
    Remove = BuildPayloads(data, modGuid, "Remove")
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      Endpoints[action]({ payload })
    end
  end
end

function RaceJsonHandler(data, modGuid)
  Utils.Info("Entering RaceJsonHandler")
  for _, races in pairs(data) do
    ParseAndSubmitEntries(races, modGuid)
  end
end
