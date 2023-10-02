function Api.InsertSelectors(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleSelector(payload)
      end
    end
  end
end

function Api.RemoveSelectors(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleSelectorRemoval(payload)
      end
    end
  end
end

-- Whoops, we provided someone with the wrong Endpoint. Here's to making things right.:
function Api.InsertSelector(payloads)
  Api.InsertSelectors(payloads)
end

function Api.RemoveSelector(payloads)
  Api.RemoveSelectors(payloads)
end
