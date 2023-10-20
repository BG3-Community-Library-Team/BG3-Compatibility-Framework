local Endpoints = {
  Insert = Api.InsertRaceChildData,
  Remove = Api.RemoveRaceChildData
}

local function BuildPayloads(data, modGuid, action)
  local count = 0
  local result = {
    modGuid = modGuid,
    raceGuid = data.UUID,
    children = {}
  }

  Utils.Info(Utils.Stringify(data))

  for _, child in pairs(data.Children) do
    if child.Action == action then
      result.children[tostring(count)] = { Type = child.Type, Value = child.Value }
      count = count + 1
    end
  end

  return result
end

local function parseAndSubmitEntries(data, modGuid)
  local payloads = {
    Insert = BuildPayloads(data, modGuid, "Insert"),
    Remove = BuildPayloads(data, modGuid, "Remove")
  }

  for action, payload in pairs(payloads) do
    if payload ~= nil then
      Utils.Info("Submitting entry: " .. Utils.Stringify(payload))
      Endpoints[action]({ payload })
    end
  end
end

function RaceJsonHandler(data, modGuid)
  for _, races in pairs(data) do
    local insertionEntries, removalEntries = parseAndSubmitEntries(races, modGuid)
  end
end
