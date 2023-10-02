-- Add support for Custom Strings
function Api.InsertStrings(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleProgressionString(payload)
      end
    end
  end
end

-- Add support for Custom Boosts
function Api.RemoveStrings(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleRemoveString(payload)
      end
    end
  end
end

function Api.InsertBoosts(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemoveBoosts(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertPassives(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemovePassives(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertPassivesForRemoval(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemovePassivesForRemoval(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertRequirements(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemoveRequirements(payloads)
  Api.RemoveStrings(payloads)
end
